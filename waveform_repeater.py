# This script is created to repeat input current waveforms.
# run example: YOUR_PYTHON_EXE waveform_parser.py [-d: in/out file directory] [-i: input file name] [-s: time stamp repeat start idx] [-e: time stamp repeat end idx] [-l: total length in TIME(s) of finished waveform] [-p: ONLY if plot result waveform]
# python .\waveform_repeater.py -d . -i cphy_ana_RX_FF_2T_3G5_vp_.pwl -s 2 -e 291660 -l 1.e-6  -p

import os, sys, getopt
import matplotlib.pyplot as plt


class Waveform:
    waveform_file_in_path = ''
    waveform_file_out_path = ''
    col_time = 0
    col_waveform = 1
    list_time = []
    list_waveform = []
    rpt_time_st_idx = 0
    rpt_time_ed_idx = 0
    rpt_time_len    = 0.

    val_MAX = -1.e6
    val_MIN = 1.e6


    def __init__(self, file_input_in_path_, waveform_file_out_path_, rpt_time_st_idx_, rpt_time_ed_idx_, rpt_time_len_):
        self.waveform_file_in_path = file_input_in_path_
        self.waveform_file_out_path = waveform_file_out_path_
        self.rpt_time_st_idx = rpt_time_st_idx_
        self.rpt_time_ed_idx = rpt_time_ed_idx_
        self.rpt_time_len    = rpt_time_len_
        line_cnt = 0

#####        
    def read_waveform(self):
        with open(r'%s'%self.waveform_file_in_path, 'r') as fin:
            time_this = 0.
            data_this = 0.
            line_cnt = 0

            cln_str = fin.readline()
            while cln_str: 
                cln_st_src = cln_str.lstrip(' ').rstrip(' ').rstrip('\t').rstrip('\n')
                if cln_st_src == '' or cln_st_src[0] == '#' or ( cln_st_src[0].isnumeric() == False and '+' not in cln_st_src[0] ) or  ')' in cln_str or '(' in cln_str: 
                    cln_str = fin.readline()
                    continue 

                if ',' in cln_st_src:
                    cln_str_split = cln_st_src.split(',')
                else:
                    cln_str_split = cln_st_src.split(' ')
                line_info_cnt = 0
                len_tmp = len(cln_str_split)
                for i in range(0, len_tmp): ### loop this line after splitting
                    if len(cln_str_split[i]) != 0 and cln_str_split[i] != ' ' and cln_str_split[i]!= '+': # and cln_str_split[i][0].isnumeric():
                        if line_info_cnt == 0:
                            time_this = float(cln_str_split[i])
                        elif line_info_cnt == 1:
                            data_this = float(cln_str_split[i])
                        line_info_cnt = line_info_cnt + 1
                    
                    if line_info_cnt == 2:
                        break

                self.list_time.append(time_this)
                self.list_waveform.append(data_this)

                if data_this > self.val_MAX:
                    self.val_MAX = data_this
                if data_this < self.val_MIN:
                    self.val_MIN = data_this

                line_cnt = line_cnt + 1
                cln_str = fin.readline()
        fin.close()       

    
#####
    def waveform_repeat(self):
        len_time_list = len(self.list_time)
        print('#INFO: duplicating waveforms ...')
        while self.list_time[-1] < self.rpt_time_len:
            time_shift_block = self.list_time[-1]
            for i in range (self.rpt_time_st_idx + 1, self.rpt_time_ed_idx):
                time_shift = time_shift_block + ( self.list_time[i] - self.list_time[self.rpt_time_st_idx] )
                self.list_time.append( time_shift )
                self.list_waveform.append( self.list_waveform[i] )

#####
    def output_waveform(self):
        print('#INFO: output waveforms ...')
        fout = open(self.waveform_file_out_path, 'w') 
        len_data = len(self.list_time)

        if self.waveform_file_in_path.endswith('.pwl'):
            fout.write('I/V_YourCurrSrcName  YourSrcNode  YourRefGnd PWL(\n')
            for i in range(0, len_data):
                fout.write('+ '+ str(self.list_time[i]) + '\t' + str(self.list_waveform[i]) + '\n')
            fout.write('+ r=0) \n')

        else:   # self.waveform_file_in_path.endswith('.tim'):
            fout.write('BEGIN  TIMEDATA' + '\n')
            fout.write('# T ( SEC  V  R 50 )' + '\n')
            fout.write('%   time      voltage' + '\n')  ### Note: this is not typo, "voltage" is just format for TIM file       
            for i in range(0, len_data):
                fout.write(str(self.list_time[i]) + '\t' + str(self.list_waveform[i]) + '\n')
            fout.write('END \n')

        fout.close()

            
    def PlotWaveform(self):
        print('#INFO: plotting waveforms ...')
        plt.rcParams.update({'font.size': 15})
        plt.plot(self.list_time, self.list_waveform, 'b', linewidth=0.2, label='Waveform')
        plt.legend(loc=1)
        plt.xlabel('Time', fontsize=14, weight='bold')
        plt.ylabel('Data', fontsize=14, weight='bold')
        plt.title('Output data plot')

        ax = plt.subplot(111)
        plt.grid(True, which='both')	
        ax.grid(which='major', linewidth=0.8)
        ax.grid(which='minor', linestyle=':', linewidth=0.5)
        ax.minorticks_on()        
        plt.savefig(file_dir + 'current_waveform.png', dpi = 600)
        plt.show()
        plt.clf()
        plt.close()
### main funciton entrance
try:
    opts,args = getopt.getopt(sys.argv[1:],'d:i:s:e:l:p')
except getopt.GetoptError:
    print('\nUsage: YOUR_PYTHON_EXE waveform_parser.py [-d: in/out file directory] [-i: input file name] [-s: time stamp repeat start idx] [-e: time stamp repeat end idx] [-l: total len of finished waveform] [-p: ONLY if plot result waveform]') 
    sys.exit(-1)
if (not opts) and args:
    print('\nUsage: YOUR_PYTHON_EXE waveform_parser.py [-d: in/out file directory] [-i: input file name] [-s: time stamp repeat start idx] [-e: time stamp repeat end idx] [-l: total len of finished waveform] [-p: ONLY if plot result waveform]') 
    sys.exit(-1)

file_dir = ''
file_input = ''
file_output = ''
is_plot = False 
rpt_time_st_idx_ = 0
rpt_time_ed_idx_ = 0
rpt_time_len_   = 0.

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
    if o == '-s':
        rpt_time_st_idx_ = int (a.lstrip(' ').rstrip(' ')) 
    if o == '-e':
        rpt_time_ed_idx_ = int (a.lstrip(' ').rstrip(' '))
    if o == '-l':
        rpt_time_len_   = float (a.lstrip(' ').rstrip(' '))


file_input_path     = file_dir + file_input
if file_input_path.endswith('tim'):
    file_output_path    = file_input_path.rstrip('.tim') + '_out_stat.tim'
elif file_input_path.endswith('pwl'):
    file_output_path    = file_input_path.rstrip('.pwl') + '_out_stat.pwl'

if os.path.exists(file_input_path):
    print('#INFO: Input file path: ' + file_input_path)
    print('#INFO: Output file path: ' + file_output_path)
else:
    print('#ERROR: input file ' + file_input_path + 'does NOT exist !')
    sys.exit(-1)


    ### start processing data
print('#INFO: waveform parser in process...')
waveformRepeatInst = Waveform(file_input_path, file_output_path, rpt_time_st_idx_, rpt_time_ed_idx_, rpt_time_len_)
waveformRepeatInst.read_waveform()
waveformRepeatInst.waveform_repeat()
waveformRepeatInst.output_waveform()

if is_plot:
    waveformRepeatInst.PlotWaveform()

print('#INFO: waveform repeater finished normally.')