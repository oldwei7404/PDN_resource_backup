# This script is created to parse (non-uniform) time stamped data, and return statistics   
## run example : YOUR_PYTHON_EXE waveform_parser.py [-d: in/out file directory] [-i: input file name]  [-p (if print out bin plot)]

import os, sys, getopt
import matplotlib.pyplot as plt 

class Waveform:
    waveform_file_path = ''
    col_time = 0
    col_waveform = 1
    list_time = []
    list_waveform = []

    bin_flor = 0.
    bin_ceil = 0. 
    bin_step = 0.

    val_MAX = -1.e6
    val_MIN = 1.e6

    bin_val_list = []   ## upper bound of bin 
    bin_time_accu_list = []  ## accumulated time within each val bin


    def __init__(self, file_input_path):
        line_cnt = 0
        cnt_set = 0
        with open(r'%s'%file_input_path, 'r') as fin:
            cln_str = fin.readline()
            while cln_str:
                cln_str_src = cln_str.lstrip(' ').rstrip('\n')
                if cln_str_src == '' or cln_str_src[0] == '#':
                    cln_str = fin.readline()
                    continue                 

                cln_str = cln_str_src.split()
                if cln_str[0] == 'Waveform_File_Path':
                    self.waveform_file_path = cln_str[1].lstrip('').rstrip('')
                    cnt_set = cnt_set + 1
                if cln_str[0] == 'Col_Time':
                    self.time = int(cln_str[1])
                    cnt_set = cnt_set + 1
                if cln_str[0] == 'Col_Waveform':
                    self.waveform = int(cln_str[1])
                    cnt_set = cnt_set + 1
                if cln_str[0] == 'Waveform_Analysis_Bin_Flor':
                    self.bin_flor = float(cln_str[1])
                    cnt_set = cnt_set + 1
                if cln_str[0] == 'Waveform_Analysis_Bin_Step':
                    self.bin_step = float(cln_str[1])
                    cnt_set = cnt_set + 1
                if cln_str[0] == 'Waveform_Analysis_Bin_Ceil':
                    self.bin_ceil = float(cln_str[1])
                    cnt_set = cnt_set + 1

                cln_str = fin.readline()
        fin.close()

        if cnt_set != 6:
            print('#ERROR: check ' + file_input_path + ' for 6 types of inputs\n')
            exit(-1)

        ### prepare bin
        bin_amt = int ( (self.bin_ceil - self.bin_flor) / self.bin_step ) + 1
        if bin_amt < 1:
            print("#ERROR: only 1 bin, check bin settings \n")
            exit(-1)

        for i in range (0, bin_amt ):
            self.bin_val_list.append( self.bin_flor + (i + 1) * self.bin_step)      ## upper bound of bin 
            self.bin_time_accu_list.append( 0. )     ## time accumulate, float value
              
### read in actual waveform 
    def read_parse_waveform_file(self):
        with open(r'%s'%self.waveform_file_path, 'r') as fin:
            time_st = 0.
            time_last = 0.
            time_this = 0.
            line_cnt = 0
            is_time_st_fnd = False  
            len_bin = len(self.bin_val_list)

            cln_str = fin.readline()
            while cln_str: 
                cln_st_src = cln_str.lstrip(' ').rstrip(' ').rstrip('\t').rstrip('\n')
                if cln_st_src == '' or cln_st_src[0] == '#':
                    cln_str = fin.readline()
                    continue 

                cln_str_split = cln_st_src.split(' ')
                time_this = float(cln_str_split[0])
                data_this = float(cln_str_split[2])   #### how to fix this ???

                if data_this > self.val_MAX:
                    self.val_MAX = data_this
                if data_this < self.val_MIN:
                    self.val_MIN = data_this

                ## if first data
                if is_time_st_fnd == False:
                    time_st = time_this
                    is_time_st_fnd = True
                    time_last = time_this
                    line_cnt = 1
                    cln_str = fin.readline()
                    continue 

                ## not first data
                time_lapse = time_this - time_last
                i_tmp_bin = 0
                is_data_inbin = False 
                for i_tmp_bin in range(0, len_bin):
                    if data_this < self.bin_val_list[i_tmp_bin]:
                        self.bin_time_accu_list[i_tmp_bin] = self.bin_time_accu_list[i_tmp_bin] + time_lapse 
                        is_data_inbin = True 
                        break 

                if is_data_inbin == False:  ## data larger than max bin val limit, put it in the max bin val 
                    self.bin_time_accu_list[len_bin - 1] = self.bin_time_accu_list[len_bin - 1] + time_lapse

                #print('DeBuG: ' + str(line_cnt) + ', ' + str(time_this)  + ', ' + str( data_this))  ## debug

                time_last = time_this 
                line_cnt = line_cnt + 1
                cln_str = fin.readline()

                
        fin.close()


### output statistics results
    def output_statistics(self, file_output_path):
        len_bin = len(self.bin_val_list)
        fout = open(file_output_path, 'w')
        time_tot = 0.
        for i in range (0, len_bin):
            time_tot = time_tot + self.bin_time_accu_list[i]

        fout.write('MAX: ' + str(self.val_MAX) + ', \tMIN: ' + str(self.val_MIN))
        fout.write('bin high bd,\t time_accmulated,\t, time_accumulated pct (%)\n')
        for i in range (0, len_bin):
            #fout.write(str(self.bin_val_list[i]) + ',\t' + str(self.bin_time_accu_list[i]) + ',\t' + str( self.bin_time_accu_list[i]/time_tot * 100. ) + '\n')
            fout.write(str( "{:.3f}".format( self.bin_val_list[i])) + ',\t' + str("{:.3E}".format( self.bin_time_accu_list[i])) + ',\t' + str( "{:.2f}".format( self.bin_time_accu_list[i]/time_tot * 100. )) + '\n')
           
        fout.close()


try:
    opts,args = getopt.getopt(sys.argv[1:],'d:i:p')
except getopt.GetoptError:
    print('\nUsage: YOUR_PYTHON_EXE waveform_parser.py [-d: in/out file directory] [-i: input file name]  [-p (if print out bin plot)]') 
    sys.exit(-1)
if (not opts) and args:
    print('\nUsage: YOUR_PYTHON_EXE waveform_parser.py [-d: in/out file directory] [-i: input file name]  [-p (if print out bin plot)]') 
    sys.exit(-1)


### main entrance 
file_dir = ''
file_input = ''
file_output = ''
is_plot = False 

for o, a in opts:
    if o == '-d':
        if os.name == 'nt':
            file_dir = a.lstrip(' ').rstrip(' ') + '\\'
        else:
            file_dir = a.lstrip(' ').rstrip(' ') + '/'
    if o == '-i':
        file_input = a.lstrip(' ').rstrip(' ')
    if o == '-p':
        is_plot = True 

file_input_path     = file_dir + file_input
file_output_path    = file_input_path + '_out_stat.txt'

if os.path.exists(file_input_path):
    print('#INFO: Input file path: ' + file_input_path)
    print('#INFO: Output file path: ' + file_output_path)
else:
    print('#ERROR: input file ' + file_input_path + 'does NOT exist !')
    sys.exit(-1)

### start processing data
waveformParseInst = Waveform(file_input_path)
waveformParseInst.read_parse_waveform_file()
waveformParseInst.output_statistics(file_output_path)