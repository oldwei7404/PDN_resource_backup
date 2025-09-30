### NOTE:
### python bump_pair_loc.py -d. -i bump_pair_loc_input.param

# Example of "bump_pair_loc_input.param"
# BumpDataLib_CSV_File    bumpData_map_VSS.csv
# BumpDataLib_CSV_File_Name_Col_StartFr0      0
# BumpDataLib_CSV_File_X_Col_StartFr0  1
# BumpDataLib_CSV_File_Y_Col_StartFr0  2


# BumpDataInput_CSV_File  bump_curr_bumps.csv
# BumpDataInput_CSV_File_Name_Col_StartFr0    0
# BumpDataInput_CSV_File_X_Col_StartFr0   1
# BumpDataInput_CSV_File_Y_Col_StartFr0   2

# BumpDataLib_CSV_File_Unit_in_mm     0.001
# BumpDataInput_CSV_File_Unit_in_mm   1.

# Distance_Warning_Limit_in_mm   0.15   
# end of "bump_pair_loc_input.param"


import os, sys, getopt
import math
import numpy as np
from scipy.spatial import ckdtree

class BumpPairLoc:
    bumpDataLib_bumpName = []
    bumpDataLib_bumpCoord = []
    
    bumpDataInput_bumpName = []
    bumpDataInput_bumpCoord = []
    
    BumpDataLib_CSV_File = ''
    BumpDataLib_CSV_File_Name_Col_StartFr0 = 0
    BumpDataLib_CSV_File_X_Col_StartFr0 = 0
    BumpDataLib_CSV_File_Y_Col_StartFr0 = 0

    BumpDataInput_CSV_File = ''
    BumpDataInput_CSV_File_Name_Col_StartFr0 = 0
    BumpDataInput_CSV_File_X_Col_StartFr0 = 0
    BumpDataInput_CSV_File_Y_Col_StartFr0 = 0

    BumpDataLib_CSV_File_Unit_in_mm = 1. 
    BumpDataInput_CSV_File_Unit_in_mm = 1.
    
    Distance_Warning_Limit_in_mm = 0.0
    
    def __init__(self, param_file):
        line_cnt = 0
        
        with open(r'%s'%param_file, 'r') as fin:
            cln_str = fin.readline()
            while cln_str:
                cln_str_src = cln_str.lstrip(' ').rstrip('\n')
                if cln_str_src == '' or cln_str_src[0] == '#':
                    cln_str = fin.readline()
                    continue 

                cln_str = cln_str_src.split()
                if cln_str[0] == 'BumpDataLib_CSV_File':
                    self.BumpDataLib_CSV_File = cln_str[1]
                elif cln_str[0] == 'BumpDataLib_CSV_File_Name_Col_StartFr0':
                    self.BumpDataLib_CSV_File_Name_Col_StartFr0 = int(cln_str[1])                    
                elif cln_str[0] == 'BumpDataLib_CSV_File_X_Col_StartFr0':
                    self.BumpDataLib_CSV_File_X_Col_StartFr0 = int(cln_str[1])
                elif cln_str[0] == 'BumpDataLib_CSV_File_Y_Col_StartFr0':
                    self.BumpDataLib_CSV_File_Y_Col_StartFr0 = int(cln_str[1])
                    
                elif cln_str[0] == 'BumpDataInput_CSV_File':
                    self.BumpDataInput_CSV_File = cln_str[1]
                elif cln_str[0] == 'BumpDataInput_CSV_File_Name_Col_StartFr0':
                    self.BumpDataInput_CSV_File_Name_Col_StartFr0 = int(cln_str[1])   
                elif cln_str[0] == 'BumpDataInput_CSV_File_X_Col_StartFr0':
                    self.BumpDataInput_CSV_File_X_Col_StartFr0 = int(cln_str[1])
                elif cln_str[0] == 'BumpDataInput_CSV_File_Y_Col_StartFr0':
                    self.BumpDataInput_CSV_File_Y_Col_StartFr0 = int(cln_str[1])
                    
                elif cln_str[0] == 'BumpDataLib_CSV_File_Unit_in_mm':
                    self.BumpDataLib_CSV_File_Unit_in_mm = float(cln_str[1])
                elif cln_str[0] == 'BumpDataInput_CSV_File_Unit_in_mm':
                    self.BumpDataInput_CSV_File_Unit_in_mm = float(cln_str[1])
                    
                elif cln_str[0] == 'Distance_Warning_Limit_in_mm':
                    self.Distance_Warning_Limit_in_mm = float(cln_str[1])
                
                cln_str = fin.readline()
                
        fin.close()
        
###
    def read_data(self):
        ### read in library x, y, bump name 
        self.bumpDataLib_bumpCoord = np.loadtxt(self.BumpDataLib_CSV_File, delimiter=',',   \
                                                usecols=( self.BumpDataLib_CSV_File_X_Col_StartFr0, self.BumpDataLib_CSV_File_Y_Col_StartFr0 ),  \
                                                dtype=np.float32)
        self.bumpDataLib_bumpCoord = self.bumpDataLib_bumpCoord * self.BumpDataLib_CSV_File_Unit_in_mm  ### normalize unit to mm         
        self.bumpDataLib_bumpName = np.genfromtxt( self.BumpDataLib_CSV_File, delimiter=",", usecols=(self.BumpDataLib_CSV_File_Name_Col_StartFr0,), dtype=str, encoding="utf-8")
       
        ### read in target x, y, bump name
        self.bumpDataInput_bumpCoord = np.loadtxt(self.BumpDataInput_CSV_File, delimiter=',',   \
                                                usecols=( self.BumpDataInput_CSV_File_X_Col_StartFr0, self.BumpDataInput_CSV_File_Y_Col_StartFr0 ),  \
                                                dtype=np.float32)
        self.bumpDataInput_bumpCoord = self.bumpDataInput_bumpCoord * self.BumpDataInput_CSV_File_Unit_in_mm
        self.bumpDataInput_bumpName = np.genfromtxt( self.BumpDataInput_CSV_File, delimiter=",", usecols=(self.BumpDataInput_CSV_File_Name_Col_StartFr0,), dtype=str, encoding="utf-8")
        
        print('#INFO: read in lib data: ' + self.BumpDataLib_CSV_File)
        print('#INFO: read in target data: ' + self.BumpDataInput_CSV_File)
        
        # print(self.bumpDataLib_bumpName[0])
        
        return 1
    
    def find_pair_for_Input(self):
        bump_pair_rslt = []
        tree = ckdtree.cKDTree(self.bumpDataLib_bumpCoord)
        
        idx_input = 0
        for bump_input in self.bumpDataInput_bumpCoord:
            bump_name_input = self.bumpDataInput_bumpName[idx_input]
            dist, idx = tree.query(bump_input, k=1)
            idx = int(idx)
            
            ## bumps pair found 
            bump_name_input = self.bumpDataInput_bumpName[idx_input]
            bump_name_pair_fnd = self.bumpDataLib_bumpName[idx]
            bump_pair_rslt.append( [bump_name_input, bump_name_pair_fnd])
        
            if (dist > self.Distance_Warning_Limit_in_mm ):
                print('#WARNING: target bump: '+bump_name_input+", \t fond bump: " + bump_name_pair_fnd+', \t distance=' + str(dist) )
            # print('#DeBuG: '+ str( bump_pair_rslt[idx_input][0]) + ', '+ str( bump_pair_rslt[idx_input][1]))
            
            idx_input = idx_input + 1
            
        ### write bump pair to file
        fout = open(self.BumpDataInput_CSV_File.rstrip('.csv')+'_out.csv', 'w')
        for entry in bump_pair_rslt:
            fout.write(str(entry[0]) + ', ' + str(entry[1]) + '\n')
        
        fout.close()
                   
        print('#INFO: ALL'+ str(self.bumpDataInput_bumpCoord.shape) + ' target bumps paired. Quit normally')

# Main function 
file_in_para = ''
file_dir = '.'

try:
	opts,args = getopt.getopt(sys.argv[1:],'d:i:m:s')
except getopt.GetoptError:
	print('\nUsage: bump_pair_loc.py [-d file directory] [-i bump_pair_loc_input.param] ')
	sys.exit(2)
if (not opts) and args:
	print('\nUsage: bump_pair_loc.py [-d file directory] [-i bump_pair_loc_input.param] ')
	sys.exit(2)

for o,a in opts:
    if o =='-d':
        if os.name == 'nt':
            file_dir = a.lstrip(' ').rstrip(' ') + '\\'
            print('#INFO: file_dir:' + file_dir)
        else:
            file_dir = a.lstrip(' ').rstrip(' ') + '/'
    if o =='-i':
        file_in_para = a.lstrip(' ').rstrip(' ')

file_in_para = file_dir + file_in_para


if os.path.exists(file_in_para):
    print('#INFO: input parameters file:    ' + file_in_para)
else:
    print('#ERROR: intput parameter file <' + file_in_para + '> does not exist !')
    sys.exit(1)
    
bumpPairLocInst = BumpPairLoc(file_in_para)
bumpPairLocInst.read_data()
bumpPairLocInst.find_pair_for_Input()
