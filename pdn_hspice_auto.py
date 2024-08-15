import os, sys, getopt
import glob
# import math, cmath
import shutil
from datetime import datetime
import matplotlib.pyplot as plt

file_in_para = ''
file_spice_template = ''

### 
class hspice_batch_sim_generator:
    vdd_pwr = 0.75
    Is_Use_Ecap = 0 
    Is_Use_MIM = 0 

    Is_TR_0_or_AC_1 = ''
    tStep = ''
    tStop = ''
    td_delay = ''

    file_spice_template = ''
    path_linux_spice_file = ''
    
    profile_Name_In_Spice_List = []
    profile_Csv_KeyWord_List = []
    num_profile_cluster = 0

    csv_file_dir = ''
    curr_profile_pair = {}  ### { current profile name in spice, csv data file list }


    def __init__(self, file_in_para, file_dir):
        self.csv_file_dir = file_dir

        with open(r'%s'%file_in_para, 'r') as fin:
            cln_str = fin.readline()
            while cln_str:
                cln_str_src = cln_str.lstrip(' ').rstrip('\n')
                if cln_str_src == '' or cln_str_src[0] == '#':
                    cln_str = fin.readline()
                    continue 

                cln_str = cln_str_src.split()
                if cln_str[0] == 'VDD_in_Volt':  
                    self.vdd_pwr = float (cln_str[1]) 
                elif cln_str[0] == 'Is_Use_Ecap':
                    self.Is_Use_Ecap = int (cln_str[1])
                elif cln_str[0] == 'Is_Use_MIM':
                    self.Is_Use_MIM = int (cln_str[1])
                elif 'Profile_Name_In_Spice' in cln_str[0]:
                    self.profile_Name_In_Spice_List.append(cln_str[1])
                elif 'Profile_Csv_Keyword' in cln_str[0]:
                    self.profile_Csv_KeyWord_List.append(cln_str[1])
                elif 'SPICE_Template' in cln_str[0]:
                    self.file_spice_template = cln_str[1]
                elif 'SPICE_Files_Linux_Path' in cln_str[0]:
                    self.path_linux_spice_file = cln_str[1]
                elif 'Is_TR_0_or_AC_1' in cln_str[0]:
                    self.Is_TR_0_or_AC_1 = cln_str[1]
                elif 'tStep' in cln_str[0]:
                    self.tStep = cln_str[1]
                elif 'tStop' in cln_str[0]:
                    self.tStop = cln_str[1]
                elif 'td_delay' in cln_str[0]:
                    self.td_delay = cln_str[1]    
                
                else: 
                    print('#ERROR Unknown parameters: ' + cln_str[0] + '\n')
                cln_str = fin.readline()
        fin.close()

        print('#INFO: reading parameters finished\n')
        print('Vdd: ' + str(self.vdd_pwr))
        print('Is_Use_Ecap: ' + str(self.Is_Use_Ecap))
        print('Is_Use_MIM: ' + str(self.Is_Use_MIM))
        print('SPICE_Template: ' + self.file_spice_template)

        print('\n target PWL src name, keyword:')
        for idx, data in enumerate(self.profile_Name_In_Spice_List):
            print('\t'+ self.profile_Name_In_Spice_List[idx] + ', ' + self.profile_Csv_KeyWord_List[idx])
        
        ## search file 
        os.chdir(self.csv_file_dir)
        for file in os.listdir(self.csv_file_dir):  ## loop each csv file in directory
            if file.endswith('.csv'):
                for idx, kw in enumerate(self.profile_Csv_KeyWord_List):      ## check if this file belongs to a keyword class 
                    if kw in file:  ## keyword found 
                        pro_name_spice = self.profile_Name_In_Spice_List[idx]
                        if pro_name_spice in self.curr_profile_pair.keys():     ## key exist, add to the file list  
                            self.curr_profile_pair[pro_name_spice].append(file)
                        else:                                                   ## key does not exist, add key and init list 
                            self.curr_profile_pair[pro_name_spice] = []
                            self.curr_profile_pair[pro_name_spice].append(file)
                        break  
        
        print('\n#INFO: csv classification done: ')
        for key_ in self.curr_profile_pair:
            print(key_+':') 
            print(self.curr_profile_pair[key_])
            if self.num_profile_cluster == 0:
                self.num_profile_cluster = len(self.curr_profile_pair[key_])
            elif self.num_profile_cluster != len(self.curr_profile_pair[key_]):
                print('#ERROR: Num of profile per type are diff, check input:' + str(self.num_profile_cluster) + '. vs '+ str(len(self.curr_profile_pair[key_])))

###
    def gene_spice_scripts(self):
        os.chdir(self.csv_file_dir)
        file_list_sp = glob.glob('*_hspice_auto_script_*.sp')
        if len(file_list_sp) != 0:  ### remove existing spice scripts
            for f_ in file_list_sp:
                os.remove(f_)        

        date_str = datetime.today().strftime('%Y_%m_%d')
        date_str_num = datetime.today().strftime('%Y%m%d')

        folder_rslt = 'results_' + date_str_num
        if os.path.isdir(folder_rslt):
            shutil.rmtree(folder_rslt)
        os.makedirs(folder_rslt)

        f_runScript = open('run_hspice_auto_'+ date_str_num + '.sh', "w")

        for grp in range(0, self.num_profile_cluster):    ### loop all grps
            header = '.param Vdd 	= ' + str(self.vdd_pwr) + '\n\n'
            header = header + '.param is_use_ecap_ebed = ' + str(self.Is_Use_Ecap) + '\n'
            header = header + '.param is_MIM = ' + str(self.Is_Use_MIM) + '\n'
            header = header + '.param is_ac_run = ' + str(self.Is_TR_0_or_AC_1) + '\n'
            header = header + '.param tStep	= ' + str(self.tStep) + '\n'
            header = header + '.param tStop	= ' + str(self.tStop) + '\n'
            header = header + '.param td_delay = ' + str(self.td_delay) + '\n\n'

            for key_ in self.curr_profile_pair:     ### loop each profile for a spice 
                header = header + '.param ' + key_ +' = str(\'' + self.path_linux_spice_file + self.curr_profile_pair[key_][grp] + '\')\n'
            # print(header)

            ### write spice script 
            fileName_spice_out = date_str +'_hspice_auto_script_num' + str(grp) + '.sp'
            with open(fileName_spice_out, 'a') as fout:
                fout.write('*** START of auto generated section ***\n')
                fout.write(header)
                fout.write('*** END of auto generated section ***\n\n')
                with open(self.file_spice_template, 'r') as fin_rd:
                    cln_str = fin_rd.readline()
                    while cln_str:
                        fout.write(cln_str)
                        cln_str = fin_rd.readline()

                fin_rd.close()
            fout.close()

            ### write tcl script 
            plotData = 'pkg_bump_pa_ns_3'
            fileName_tcl_out = date_str +'_wv_script_num' + str(grp) + '.tcl'
            with open(fileName_tcl_out, 'w') as fout_tcl:
                tcl_str = 'set file [sx_open_sim_file_read ' +  date_str +'_hspice_auto_script_num' + str(grp) + '.tr' + date_str_num +'] \n'
                tcl_str = tcl_str + 'set sig1 [sx_signal pkg_bump_pa_ns_3]\n'
                tcl_str = tcl_str + 'sx_export_precision 7\n'
                tcl_str = tcl_str + 'sx_export_csv on\n'
                tcl_str = tcl_str + 'sx_export_data' + ' "./' + date_str +'_num' + str(grp) + '___' +  plotData + '.csv" ' +  '$sig1\n'
                fout_tcl.write(tcl_str)
            fout_tcl.close()

        
            f_runScript.write('hspice  -i ' + fileName_spice_out + ' -o '+ folder_rslt + ' -n ' + date_str_num + str(grp) + '\n')
            f_runScript.write('cd ' + folder_rslt  +'\n')
            f_runScript.write('wv -ace_no_gui ' + fileName_tcl_out + '\n')
            f_runScript.write('cd ..\n\n')

        f_runScript.close()
        print('#INFO: Spice scripts generation finished.')

### Main function 

try:
	opts,args = getopt.getopt(sys.argv[1:],'d:i:')
except getopt.GetoptError:
	print('\nUsage: python pdn_hspice_auto.py [-d file directory] [-i pdn_hspice_auto_input.params]')
	sys.exit(2)
if (not opts) and args:
	print('\nUsage: python pdn_hspice_auto.py [-d file directory] [-i pdn_hspice_auto_input.params]')
	sys.exit(2)

for o,a in opts:
    if o =='-d':
        if os.name == 'nt':
            file_dir = a.lstrip(' ').rstrip(' ') + '\\'
        else:
            file_dir = a.lstrip(' ').rstrip(' ') + '/'
    if o =='-i':
        file_in_para = a.lstrip(' ').rstrip(' ')

if os.path.exists(file_in_para):
    print('#INFO: input parameters file:    ' + file_in_para)
else:
    print('#ERROR: intput parameter file <' + file_in_para + '> does not exist !')
    sys.exit(1)

hspice_scripts_gene = hspice_batch_sim_generator(file_in_para, file_dir)
hspice_scripts_gene.gene_spice_scripts()