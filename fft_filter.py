### NOTE: 
### Input: 
### 1) csv format: time, data
### 2) freq remove start, end OR freq kept start, end pairs
### Example:   python .\fft_filter.py -d . -i .\input_fft_systemPDN.params -s

import os, sys, getopt
import math
import matplotlib.pyplot as plt 
import scipy.interpolate

import numpy as np
from numpy.fft import fft, ifft 
from matplotlib.widgets import MultiCursor
import stat
from stat import S_IREAD, S_IRGRP, S_IROTH

is_export_to_simplis_csv = False 

class DataFftProcess:
    input_fileName = ''
    unit_time_in_s = 1.
    freqPair_St = []
    freqPair_Ed = []
    is_freqFilter_0_OR_Keep_1= 0 
    sampleRate_per_s = 1000.
    freqResoltn = 1.e9  ### default 1GHz, i.e., disabled

    ##
    input_data_len_orig = 0
    input_time = []     ### unit: s
    input_data = []
    output_time = []
    output_data = []
    num_copy = 0

    ##
    data_fft_coeff=[]
    
    def __init__(self, in_fileName):
        line_cnt = 0
        wf_cnt = 0
        set_cnt = 0
        with open(r'%s'%in_fileName, 'r') as fin:
            cln_str = fin.readline()
            while cln_str:
                cln_str_src = cln_str.lstrip(' ').rstrip('\n')
                if cln_str_src == '' or cln_str_src[0] == '#':
                    cln_str = fin.readline()
                    continue 

                cln_str = cln_str_src.split()
                if cln_str[0] == 'Input_Time_Domain_File':
                    self.input_fileName = cln_str[1]
                elif cln_str[0] == 'Input_Time_Unit_in_s':
                    self.unit_time_in_s = float(cln_str[1]) 
                elif cln_str[0] == 'Analysis_Sample_Rate_PerSec':
                    self.sampleRate_per_s = float(cln_str[1])
                elif cln_str[0] == 'Analysis_Spectrum_Resolt':
                    self.freqResoltn = float(cln_str[1])
                elif cln_str[0] == 'Freq_Filter_0_OR_Keep_1':
                    self.is_freqFilter_0_OR_Keep_1 = int(cln_str[1])
                elif cln_str[0] == 'Freq_Pair':
                    if (len(cln_str) % 2 == 0 ):
                        print("#ERROR: freq no. needs to be even number")
                        exit(2) 
                    else: 
                        for i in range (1, len(cln_str)):
                            if i % 2 == 1:
                                self.freqPair_St.append(float(cln_str[i]))
                            else:
                                self.freqPair_Ed.append(float(cln_str[i]))

                else: 
                    print('#ERROR: unrecognized setting: ' + cln_str_src)

                cln_str = fin.readline()
        fin.close() 


    def read_data(self):
        stat_max = -1.e6
        stat_min = 1.e6
        with open(r'%s'%self.input_fileName, 'r') as fin:
            cln_str = fin.readline()
            time_ST = 0
            time_st_fnd = False
            data_cnt = 0
            while cln_str:
                cln_str_src = cln_str.lstrip(' ').rstrip('\n')
                if cln_str_src == '' or cln_str_src[0] == '#' or 'time' in cln_str_src or 'TIME' in cln_str_src or 'Time' in cln_str_src: ### skip empty line or lines start with #, or 'time'
                    cln_str = fin.readline()
                    continue    
                if ',' in cln_str:
                    cln_str = cln_str_src.split(',') 
                else:   
                    cln_str = cln_str_src.split()
                
                time_s = float(cln_str[0]) * self.unit_time_in_s
                data_cnt = data_cnt + 1

                if not time_st_fnd:
                    time_ST = time_s
                    time_st_fnd = True

                data_ = float(cln_str[1])
                self.input_time.append( time_s - time_ST )    ### nominal profile starts from 0
                self.input_data.append( data_ )     

                if data_ > stat_max:
                    stat_max = data_
                if data_ < stat_min:
                    stat_min = data_

                cln_str = fin.readline()              
            fin.close()

        self.input_data_len_orig = len(self.input_time)
      
        print('#INFO: Input time data read in, time duration ' + str(self.input_time[-1]) + 's, data entry amount: ' + str(len(self.input_time)) + '. Max Val: ' + "{:.3f}".format(stat_max) + '. Min Val: ' + "{:.3f}".format(stat_min) )


    def write_data_to_CSV(self, fileName):
        stat_max = -1.e6
        stat_min = 1.e6
        fout = open(fileName, 'w')
        fout.write('#Time(ns), filtered data\n')
        # print("### debug: "+ str(len(self.output_time))+ "\t"+ str(len(self.output_data)) + "\t" + str(self.input_data_len_orig))
        data_len_out = self.input_data_len_orig
        if data_len_out > len(self.output_data):
            data_len_out = len(self.output_data)

        for i in range(0, data_len_out):
            fout.write(str( self.output_time[i]) + ', ' + str(self.output_data[i]) + '\n')  

            if self.output_data[i] > stat_max:
                stat_max = self.output_data[i]
            if self.output_data[i] < stat_min:
                stat_min = self.output_data[i]

            if (self.output_time[i] > self.input_time[self.input_data_len_orig -1] ):
                break

        fout.close()
        print('#INFO: data output to CSV file: '+ fileName + '. Max Val: ' + "{:.3f}".format(stat_max) + '. Min Val: ' + "{:.3f}".format(stat_min) ) 

    def write_data_to_Simplis_CSV(self, fileName):
        len_lmt = 100000 - 3    ### -3 to allow time 0 

        data_len_out = self.input_data_len_orig
        if data_len_out > len(self.output_data):
            data_len_out = len(self.output_data)

        leng_rcd = data_len_out
        Num_Files = int(leng_rcd / len_lmt) + 1
        fileName_base = fileName

        if Num_Files > 1:
            print('\n\n#INFO: SIMPLIS split into ' + str(Num_Files) + ' files due to data length limit '+ str(len_lmt))

        for file_num in range (0, Num_Files):            
            baseNum = int(file_num * len_lmt)
            if file_num == Num_Files-1: ## last file
                len_lmt = int( leng_rcd - (Num_Files-1) * len_lmt )

            # NOTE: remove existing SIMPLIS file, if found
            if Num_Files >1: 
                fileName = fileName_base + '_' + str(file_num+1) + '_Of_' + str(Num_Files) +  '_simplis.csv'
            else: 
                fileName = fileName_base + '_simplis.csv'

            if os.path.isfile(fileName):
                os.chmod(fileName, stat.S_IWRITE)
                os.remove(fileName)   

            fout = open(fileName, 'w+')
            fout.write('START_DATA SHIFT_FIRST_TO_ZERO FORMAT=CSV,\n')
            if file_num == 0:
                for i in range(0, len_lmt):
                    fout.write(str(self.output_time[baseNum + i]) + ', "\t' + str(self.output_data[baseNum + i]) + ' "\t\n')  
                fout.write(str(self.output_time[baseNum + len_lmt]) + ', "\t0\t"\n')    ## make sure last current is 0
            else: 
                fout.write('0, "\t0\t"\n')    ### first 2 data point to be 0, to avoid spice issue
                fout.write( str( (self.output_time[baseNum -1] + self.output_time[baseNum] )*0.5 ) + ', "\t0\t"\n')
                for i in range(0, len_lmt):
                    fout.write(str(self.output_time[baseNum + i]) + ', "\t' + str(self.output_data[baseNum + i]) + ' "\t\n')  
                if baseNum + len_lmt < data_len_out:
                    fout.write(str((self.output_time[baseNum + len_lmt -1] + self.output_time[baseNum + len_lmt])*0.5 ) + ', "\t0\t"\n')    ## make sure last current is 0
            fout.close()

            # NOTE: simplis output fomrat files are made read only due to SIMPLIS tends to change file in run        
            os.chmod(fileName, S_IREAD|S_IRGRP|S_IROTH)
            print('#INFO: Current waveform output as PWL to READ ONLY file : ' + fileName)


    def data_repeat(self):
        OneOverFreqResoltn = 1./self.freqResoltn
        if (self.input_time[-1] < OneOverFreqResoltn):
            ### 0 padding if needed 
            # self.input_time.append( self.input_time[-1] + (self.input_time[-1] - self.input_time[-2]) )
            # self.input_data.append(0.)

            # self.input_time.append(OneOverFreqResoltn)
            # self.input_data.append(0.)

            ### copy self multiple times if needed 
            self.num_copy = math.ceil( OneOverFreqResoltn / self.input_time[-1]) - 1
            if self.num_copy <=0:
                return 

            if abs( self.input_data[-1] - self.input_data[0] ) > abs(self.input_data[0]) * 0.01 :
                print('\n\n#WARNING: last data ' + str(self.input_data[-1]) + ' is outside of 1 pct range of first data '+ str( self.input_data[0]) +'\n\n')
                

            for cnt_cpy in range (0, self.num_copy):
                time_st = self.input_time[-1] + (self.input_time[1] - self.input_time[0])
                # print('#DEBUG '+str(self.input_time[-1]) )
                for i_ in range(0, self.input_data_len_orig):
                    self.input_time.append( time_st + self.input_time[i_] )
                    self.input_data.append( self.input_data[i_] )
            print('#INFO: Input time data copied '+ str(self.num_copy) +' times, at freq = ' + str( 1./self.input_time[self.input_data_len_orig-1] ) + 'Hz, final data entry amount: ' + str(len(self.input_time)))

    def FFT_analysis(self):
        time_len_in_s = self.input_time[-1] - self.input_time[0]

        func_interp = scipy.interpolate.interp1d(self.input_time, self.input_data)
       
        NumFFTSample = int( time_len_in_s * self.sampleRate_per_s)
        time_per_sample = 1. / self.sampleRate_per_s
        data_resample = []
        time_samp = []

        for i in range(0, NumFFTSample):
            time_samp.append ( time_per_sample * i )
            data_resample.append( func_interp(time_samp[-1] ) )

        DataSpectrum = fft(data_resample)
        freq_fft = np.fft.fftfreq(NumFFTSample, time_per_sample)
        len_pos = int (len(DataSpectrum) * 0.5 )

        fig = plt.figure(figsize = (12, 6))

        plt1 = plt.subplot(221)
        plt.plot(freq_fft[0:len_pos], np.abs(DataSpectrum[0:len_pos]), 'k--')
        plt.xlabel('Freq (Hz)')
        # plt.xlim(1, freq_fft[len_pos])
        plt.xscale('log')
        plt.yscale('log')
        plt.grid()
        plt.ylabel('FFT Amplitude |X(freq)|')
        plt.ylim(min(np.abs(DataSpectrum)), max(np.abs(DataSpectrum)))
        plt.title('FFT Orig')

        ### freq filter
        DataSpectrum_process = np.copy(DataSpectrum)
        cnt_setZero = 0
        NumFFTSample_tmp = int(NumFFTSample * 0.5)
        for freq_indx in range(0, NumFFTSample_tmp):
            freq_ = freq_fft[freq_indx]
            is_freq_in_list = False 

            for i_ in range(0,  len(self.freqPair_St)):
                if freq_ >= self.freqPair_St[i_] and freq_ <= self.freqPair_Ed[i_]:
                    is_freq_in_list = True 
                    break 
            
            if (self.is_freqFilter_0_OR_Keep_1 == 0 and is_freq_in_list == True) or (self.is_freqFilter_0_OR_Keep_1 == 1 and is_freq_in_list == False):
                DataSpectrum_process[freq_indx] = 0.                        ## set freq compotent at this freq to 0 
                DataSpectrum_process[NumFFTSample - freq_indx- 1] = 0.      ## symmetric freq also set to 0
                cnt_setZero = cnt_setZero + 1

        print('\n#INFO:' + str(cnt_setZero) + ' of ' + str(NumFFTSample) + ' set to 0.\n')

        plt2 = plt.subplot(222)
        plt.plot(freq_fft[0:len_pos], np.abs(DataSpectrum_process[0:len_pos]), 'k--')
        plt.xlabel('Freq (Hz)')
        # plt.xlim(1, freq_fft[len_pos])
        plt.xscale('log')
        plt.yscale('log')
        plt.grid()
        plt.ylabel('FFT Amplitude |X(freq)|')
        plt.ylim(min(np.abs(DataSpectrum)), max(np.abs(DataSpectrum)))
        plt.title('FFT after filtering')

        dataAftProcess= ifft(DataSpectrum_process)        
        min_plot = min( min(self.input_data), min(np.real(dataAftProcess)))
        max_plot = max( max(self.input_data), max(np.real(dataAftProcess)))
        self.output_time = time_samp
        self.output_data = np.real(dataAftProcess[0:self.input_data_len_orig+1])

        plt3 = plt.subplot(223)
        plt.plot(self.input_time, self.input_data, 'r', label = 'orig.')
        plt.plot(time_samp, np.real(dataAftProcess), 'b', label = 'processed')
        plt.xlabel('Time (s)')
        plt.xlim(self.input_time[0], self.input_time[ self.input_data_len_orig - 1] )
        plt.ylabel('Amplitude')
        plt.grid()
        # plt.ylim(min_plot, max_plot)
        plt.tight_layout()        
        plt.title('time signal orig (red) vs. after filtering (blue)')

        plt4 = plt.subplot(224)
        plt.plot(time_samp, np.real(dataAftProcess), 'b')
        plt.xlabel('Time (s)')
        plt.xlim(self.input_time[0], self.input_time[ self.input_data_len_orig - 1] )
        plt.ylabel('Amplitude')
        plt.grid()
        # plt.ylim(min_plot, max_plot)
        plt.tight_layout()
        plt.title('time signal after filtering')

        # cursor = MultiCursor(fig.canvas, (plt1, plt2, plt3, plt4), color='r',lw=0.5, horizOn=True, vertOn=True)

        plt.show()



# Main function 
try:
	opts,args = getopt.getopt(sys.argv[1:],'d:i:s')
except getopt.GetoptError:
	print('\nUsage: fft_filter.py [-d file directory] [-i input.params] <-s to export to Simplis CSV>')
	sys.exit(2)
if (not opts) and args:
	print('\nUsage: fft_filter.py [-d file directory] [-i input.params] <-s to export to Simplis CSV>')
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
    if o =='-s':
        is_export_to_simplis_csv = True 

# BEGIN read input parameters
file_in_para = file_dir + file_in_para
#file_out_waveform = file_in_para+'_out.csv'

if os.path.exists(file_in_para):
    print('#INFO: input parameters file:    ' + file_in_para)
else:
    print('#ERROR: intput parameter file <' + file_in_para + '> does not exist !')
    sys.exit(1)

dataInstFFT = DataFftProcess(file_in_para)
dataInstFFT.read_data()
dataInstFFT.data_repeat()
dataInstFFT.FFT_analysis()

file_out_waveform = dataInstFFT.input_fileName+'_out.csv'
dataInstFFT.write_data_to_CSV(file_out_waveform)

if is_export_to_simplis_csv:
    dataInstFFT.write_data_to_Simplis_CSV(file_out_waveform)


print ("#INFO: FFT manipulation exit normally\n\n")