filename_pa  = "NNE_0p25_PA_resnet_noReLU_full_250122_v2_compressed.txt.csv"
filename_igi = "NNE_0p25_IGI_resnet_noReLU_full_250122_v2_compressed.txt.csv"

data_PA = csvread(filename_pa);
data_IGI = csvread(filename_igi);

%% add and scale by 4.
data_out = [data_PA(:,1), ( data_PA(:,2) + data_IGI(:,2) ) * 4.];

dlmwrite("curr_add_file_out.csv", data_out, ",")
