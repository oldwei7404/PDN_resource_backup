### NOTE: 
### Input: 
### 1) csv format: time, data
### 2) freq remove start, end OR freq kept start, end pairs

import os, sys, getopt
import math
import matplotlib.pyplot as plt 
import scipy.interpolate

import numpy as np
from numpy.fft import fft, ifft 


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
                elif cln_str[0] == 'Input_Time_in_s':
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

                self.input_time.append( time_s - time_ST )    ### nominal profile starts from 0
                self.input_data.append( float(cln_str[1]) )     

                cln_str = fin.readline()              
            fin.close()

        self.input_data_len_orig = len(self.input_time)
      
        print('#INFO: Input time data read in, time duration ' + str(self.input_time[-1]) + 's, data entry amount: ' + str(len(self.input_time)))

    def data_repeat(self):
        OneOverFreqResoltn = 1./self.freqResoltn
        if (self.input_time[-1] < OneOverFreqResoltn):
            ### 0 padding if needed 
            # self.input_time.append( self.input_time[-1] + (self.input_time[-1] - self.input_time[-2]) )
            # self.input_data.append(0.)

            # self.input_time.append(OneOverFreqResoltn)
            # self.input_data.append(0.)

            ### copy self multiple times if needed 
            num_copy = math.ceil( OneOverFreqResoltn / self.input_time[-1]) - 1
            if num_copy <=0:
                return 

            for cnt_cpy in range (0, num_copy):
                time_st = self.input_time[-1] + (self.input_time[1] - self.input_time[0])
                # print('#DEBUG '+str(self.input_time[-1]) )
                for i_ in range(0, self.input_data_len_orig):
                    self.input_time.append( time_st + self.input_time[i_] )
                    self.input_data.append( self.input_data[i_] )
            print('#INFO: Input time data copied '+ str(num_copy) +' times, at freq = ' + str( 1./self.input_time[self.input_data_len_orig-1] ) + 'Hz, final data entry amount: ' + str(len(self.input_time)))

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

        plt.figure(figsize = (12, 6))

        plt.subplot(221)
        plt.plot(freq_fft[0:len_pos], np.abs(DataSpectrum[0:len_pos]), 'b')
        plt.xlabel('Freq (Hz)')
        # plt.xlim(1, freq_fft[len_pos])
        plt.xscale('log')
        plt.yscale('log')
        plt.ylabel('FFT Amplitude |X(freq)|')
        plt.ylim(min(np.abs(DataSpectrum)), max(np.abs(DataSpectrum)))
        plt.title('FFT Orig')

        ### freq filter
        DataSpectrum_process = np.copy(DataSpectrum)
        cnt_setZero = 0
        for freq_indx in range(0, NumFFTSample):
            freq_ = freq_fft[freq_indx]
            is_freq_in_list = False 

            for i_ in range(0,  len(self.freqPair_St)):
                if freq_ >= self.freqPair_St[i_] and freq_ <= self.freqPair_Ed[i_]:
                    is_freq_in_list = True 
                    break 
            
            if (self.is_freqFilter_0_OR_Keep_1 == 0 and is_freq_in_list == True) or (self.is_freqFilter_0_OR_Keep_1 == 1 and is_freq_in_list == False):
                DataSpectrum_process[freq_indx] = 0.        ## set freq compotent at this freq to 0 
                cnt_setZero = cnt_setZero + 1

        print('\n#INFO:' + str(cnt_setZero) + ' of ' + str(NumFFTSample) + ' set to 0.\n')

        plt.subplot(222)
        plt.plot(freq_fft[0:len_pos], np.abs(DataSpectrum_process[0:len_pos]), 'b')
        plt.xlabel('Freq (Hz)')
        # plt.xlim(1, freq_fft[len_pos])
        plt.xscale('log')
        plt.yscale('log')
        plt.ylabel('FFT Amplitude |X(freq)|')
        plt.ylim(min(np.abs(DataSpectrum)), max(np.abs(DataSpectrum)))
        plt.title('FFT after filtering')

        dataAftProcess= ifft(DataSpectrum_process)        
        min_plot = min( min(self.input_data), min(np.real(dataAftProcess)))
        max_plot = max( max(self.input_data), max(np.real(dataAftProcess)))

        plt.subplot(223)
        plt.plot(self.input_time, self.input_data, 'r')
        plt.xlabel('Time (s)')
        plt.xlim(self.input_time[0], self.input_time[ self.input_data_len_orig - 1] )
        plt.ylabel('Amplitude')
        # plt.ylim(min_plot, max_plot)
        plt.tight_layout()        
        plt.title('time signal orig')


        plt.subplot(224)
        plt.plot(time_samp, np.real(dataAftProcess), 'r')
        plt.xlabel('Time (s)')
        plt.xlim(self.input_time[0], self.input_time[ self.input_data_len_orig - 1] )
        plt.ylabel('Amplitude')
        # plt.ylim(min_plot, max_plot)
        plt.tight_layout()
        plt.title('time signal after filtering')

        plt.show()


# Main function 
try:
	opts,args = getopt.getopt(sys.argv[1:],'d:i:')
except getopt.GetoptError:
	print('\nUsage: fft_filter.py [-d file directory] [-i input.params] ')
	sys.exit(2)
if (not opts) and args:
	print('\nUsage: fft_filter.py [-d file directory] [-i input.params] ')
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

# BEGIN read input parameters
file_in_para = file_dir + file_in_para
file_out_waveform = file_in_para+'_out.csv'

if os.path.exists(file_in_para):
    print('#INFO: input parameters file:    ' + file_in_para)
else:
    print('#ERROR: intput parameter file <' + file_in_para + '> does not exist !')
    sys.exit(1)

dataInstFFT = DataFftProcess(file_in_para)
dataInstFFT.read_data()
dataInstFFT.data_repeat()
dataInstFFT.FFT_analysis()


print ("#INFO: FFT manipulation exit normally")