
***** input settings 
.param Vdd_c_d 			= '0.75'
.param Vdd_h			= '1.2'

	*** PCB model 
.inc 	/data/home/jiangongwei/work/PDN_SerDes/PDN_SerDes_ETH/inc_data/ACM2_PT00547399_A_01_PWR_cut_pcie_eth_usb_run3_v2_IdEM.cir
.param PCB_model = str('ACM2_PT00547399_A_01_PWR_cut_pcie_eth_usb_run3_v2_IdEM')

	*** pkg model 
.inc	/data/home/jiangongwei/work/PDN_SerDes/PDN_SerDes_ETH/inc_data/ZJC_5_PDN_SerDes_cut_only_ETH10G.cir			*** NOTE: POR
.param pkg_model = str('ZJC_5_PDN_SerDes_cut_only_ETH10G')

					* .inc	/data/home/jiangongwei/work/PDN_SerDes/PDN_SerDes_ETH/inc_data/tcodb_eth_TC_IdEM.cir		*** NOTE: Cadence 10/16 TC pkg 
					* .param pkg_model = str('tcodb_eth_TC_IdEM')

***** current profiles 
.param currSrc_vdd_c_cmn 	= str('./inc_data/profile_1010/cmn_avdd_clk_current_ff.csv')
.param currSrc_vdd_c_tx 	= str('./inc_data/profile_1010/tx_avdd_clk_current_ff.csv')
.param currSrc_vdd_c_rx 	= str('./inc_data/profile_1010/rx_avdd_clk_current_ff.csv')
.param currSrc_vdd_d_cmn 	= str('./inc_data/profile_1010/cmn_avdd_current_ff.csv')
.param currSrc_vdd_d_tx 	= str('./inc_data/profile_1010/tx_avdd_current_ff.csv')
.param currSrc_vdd_d_rx 	= str('./inc_data/profile_1010/rx_avdd_current_ff.csv')
.param currSrc_vdd_h_cmn 	= str('./inc_data/profile_1010/cmn_avdd_h_current_ff.csv')
.param currSrc_vdd_h_tx 	= str('./inc_data/profile_1010/tx_avdd_h_current_ff.csv')
.param currSrc_vdd_h_rx 	= str('./inc_data/profile_1010/rx_avdd_h_current_ff.csv')

* .param currSrc_vdd_c_cmn 	= str('./inc_data/cmn_avdd_clk_current_ff.csv')
* .param currSrc_vdd_c_tx 	= str('./inc_data/tx_avdd_clk_current_ff.csv')
* .param currSrc_vdd_c_rx 	= str('./inc_data/rx_avdd_clk_current_ff.csv')
* .param currSrc_vdd_d_cmn 	= str('./inc_data/cmn_avdd_current_ff.csv')
* .param currSrc_vdd_d_tx 	= str('./inc_data/tx_avdd_current_ff.csv')
* .param currSrc_vdd_d_rx 	= str('./inc_data/rx_avdd_current_ff.csv')
* .param currSrc_vdd_h_cmn 	= str('./inc_data/cmn_avdd_h_current_ff.csv')
* .param currSrc_vdd_h_tx 	= str('./inc_data/tx_avdd_h_current_ff.csv')
* .param currSrc_vdd_h_rx 	= str('./inc_data/rx_avdd_h_current_ff.csv')

*** debug
* .param currSrc_vdd_d_cmn 	= str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_d_tx 	= str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_d_rx 	= str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_h_cmn 	= str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_h_tx 	= str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_h_rx 	= str('./inc_data/i_curr_0.csv')
*** debug end 

***** die params 
.param Cdie_avdd_c	= '72.55p'
.param Rdie_avdd_c  = '827m'
.param Res_avdd_c   = '150m'
.param Cdie_avdd_c_cmn 	= '108p'
.param Rdie_avdd_c_cmn 	= '550m'
.param Res_avdd_c_cmn  	= '150m'

.param Cdie_avdd_d	= '161.5p'
.param Rdie_avdd_d  = '371m'
.param Res_avdd_d  = '150m'
.param Cdie_avdd_d_cmn 	= '315.8p'
.param Rdie_avdd_d_cmn 	= '190m'
.param Res_avdd_d_cmn  	= '150m'

.param Cdie_avdd_h	= '220p'
.param Rdie_avdd_h  = '272m'
.param Res_avdd_h  = '150m'
.param Cdie_avdd_h_cmn 	= '42p'
.param Rdie_avdd_h_cmn 	= '1420m'
.param Res_avdd_h_cmn  	= '150m'

***** end of user input 
***** die models 
.subckt model_die_eth_vdd_cdh_cmn
+ pin_bump ref_gnd Cdie = 1n. 	Rdie = 125m		Res = 50m 	delay = 0	pwl_file_in = str('./currSrc.csv')	

R_res_		pin_bump	2			Res 
C_die_		1			ref_gnd 	Cdie 
R_die_		2			1			Rdie 
IcurrSrc	2			ref_gnd		PWL pwlfile = str(pwl_file_in) 	R 	td = delay
.ends 
**
.subckt model_die_eth_vdd_cdh
+ pin_bump ref_gnd Cdie = 1n. 	Rdie = 125m		Res = 50m	delay = 0  	pwl_file_in_tx = str('./currSrc.csv')	pwl_file_in_rx = str('./currSrc.csv')			

R_res_		pin_bump	2			Res 
C_die_		1			ref_gnd 	Cdie 
R_die_		2			1			Rdie 
IcurrSrc_rx	2			ref_gnd		PWL pwlfile = str(pwl_file_in_rx)	R	td = delay 
IcurrSrc_tx	2			ref_gnd		PWL pwlfile = str(pwl_file_in_tx) 	R	td = delay 
.ends 

*************************************** cap model *****************************
.inc /data/home/jiangongwei/work/models_cap/GCM155D70E106ME36_DC0V_125degC_0402_10uF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM155D70G475ME36_DC0V_125degC_0402_4p7uF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM155C71A105KE38_DC0V_125degC_0402_1uF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM31CD70G476ME02_DC0V_125degC_1206_47uF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM32ED70E107ME36_DC0V_125degC_1210_100uF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM033D70E105ME36_DC0V_125degC_0201_1uF.mod 
.inc /data/home/jiangongwei/work/models_cap/NFM15HC105D0G3_feedthrough_DC0V_85degC_3T_0402_1uF.mod
.inc /data/home/jiangongwei/work/models_cap/LLC152D70G105ME01_DC0V_125degC_0204_1uF.mod
.inc /data/home/jiangongwei/work/models_cap/LLL153C70G104ME01_DC0V_125degC_0204_0.1uF.mod
.inc /data/home/jiangongwei/work/models_cap/GRT033R70J103KE01_DC0V_125degC_0201_0p01uF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM155R71C104KA55_DC0V_125degC_0402_0.1uF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM21BD70G226ME36_DC0V_125degC_0805_22uF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM155R71E153KA55_DC0V_125degC_0402_0.015uF.mod
.inc /data/home/jiangongwei/work/models_cap/GRT033C70J104KE01_DC0V_125degC_0201_0p1uF.mod
.inc /data/home/jiangongwei/work/models_cap/mlcc_470uF_mockup_T598D477M2R5ATE009.mod
.inc /data/home/jiangongwei/work/models_cap/GCM188R70J225KE22_DC0V_125degC_0603_2.2uF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM033R71A222KA03_DC0V_125degC_0201_2p2nF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM033R71E471KA03_DC0V_125degC_0201_0.47nF.mod
.inc /data/home/jiangongwei/work/models_cap/GCM033R71A472KA03_DC0V_125degC_0201_4.7nF.mod
.inc /data/home/jiangongwei/work/models_cap/open_circuit.mod

.inc /data/home/jiangongwei/work/models_cap/EC1001.mod
.inc /data/home/jiangongwei/work/models_cap/EC1002.mod
.inc /data/home/jiangongwei/work/models_cap/EC1100_200nF.mod

	***** define cap model strings for better ref ****
.param mlcc_1uF_0402 		= str('GCM155C71A105KE38_DC0V_125degC_0402_1uF')
.param mlcc_1uF_0204 		= str('LLC152D70G105ME01_DC0V_125degC_0204_1uF')
.param mlcc_1uF_0201 		= str('GCM033D70E105ME36_DC0V_125degC_0201_1uF')
.param mlcc_1uF_0402_3T		= str('NFM15HC105D0G3_feedthrough_DC0V_85degC_3T_0402_1uF')
.param mlcc_4p7uF_0402 		= str('GCM155D70G475ME36_DC0V_125degC_0402_4p7uF')
.param mlcc_10uF_0402 		= str('GCM155D70E106ME36_DC0V_125degC_0402_10uF')
.param mlcc_47uF_1206		= str('GCM31CD70G476ME02_DC0V_125degC_1206_47uF')
.param mlcc_100uF_1210		= str('GCM32ED70E107ME36_DC0V_125degC_1210_100uF')
.param mlcc_0p1uF_0402		= str('GCM155R71C104KA55_DC0V_125degC')
.param mlcc_0p1uF_0201		= str('GRT033C70J104KE01_DC0V_125degC')
.param mlcc_0p1uF_0204 		= str('LLL153C70G104ME01_DC0V_125degC')
.param mlcc_0p015uF_0402	= str('GCM155R71E153KA55_DC0V_125degC')
.param mlcc_0p01uF_0201		= str('GRT033R70J103KE01_DC0V_125degC')
.param mlcc_22uF_0805		= str('GCM21BD70G226ME36_DC0V_125degC_0805_22uF')
.param mlcc_470uF_mockup	= str('mlcc_470uF_mockup_T598D477M2R5ATE009') 
.param mlcc_2p2uF_0603		= str('GCM188R70J225KE22_DC0V_125degC')
.param mlcc_2p2nF_0201		= str('GCM033R71A222KA03_DC0V_125degC')
.param mlcc_0p47nF_0201		= str('GCM033R71E471KA03_DC0V_125degC')
.param mlcc_4p7nF_0201		= str('GCM033R71A472KA03_DC0V_125degC')

.param siCap_empwr_EC1001 = str('EC1001')
.param siCap_empwr_EC1002 = str('EC1002')
.param siCap_empwr_EC1100_200nF = str('EC1100_200nF')

***** filter models 
.inc   /data/home/jiangongwei/work/models_cap/BLM18SN220TH1.mod
.param ferrite_mod1 = str('BLM18SN220TH1')

.subckt model_filter
+ pin_pwr_L pin_pwr_C ref_gnd 

 Xfilter			** NOTE: this filter is added to isolate VDDC from VDDD
  + pin_pwr_L
  + pin_pwr_C
  + str(ferrite_mod1)

 XfilterCap_1	pin_pwr_C 	ref_gnd	str(mlcc_47uF_1206)
 XfilterCap_2	pin_pwr_C 	ref_gnd	str(mlcc_1uF_0402)
 XfilterCap_3	pin_pwr_C 	ref_gnd	str(mlcc_0p1uF_0402)
.ends 

.subckt model_filter_22uF
+ pin_pwr_L pin_pwr_C ref_gnd 

 Xfilter			** NOTE: this filter is added to isolate VDDC from VDDD
  + pin_pwr_L
  + pin_pwr_C
  + str(ferrite_mod1)

 XfilterCap_1	pin_pwr_C 	ref_gnd	str(mlcc_22uF_0805)
 XfilterCap_2	pin_pwr_C 	ref_gnd	str(mlcc_1uF_0402)
 XfilterCap_3	pin_pwr_C 	ref_gnd	str(mlcc_0p1uF_0402)
.ends 

***** PMIC 
Vref_gnd 		ref_gnd		0	0.	
Vsrc_vdd_c_d	pwr_pmic_0p95		ref_gnd	Vdd_c_d		*** can be switched to PMIC model 
Vsrc_vdd_h		pwr_pmic_1p8 		ref_gnd	Vdd_h		*** can be switched to PMIC model 

* ***** PCB 
xblk_PCB
 + bga_pwr_eth_0p95
 + bga_pwr_pcie_0p95
 + bga_pwr_usb_0p95
 + bga_pwr_eth_1p8
 + bga_pwr_usb_1p8
 + bga_pwr_pcie_1p8
 + capPcb_C2519
 + capPcb_C2546
 + capPcb_C2575
 + capPcb_C2580
 + capPcb_C2710
 + capPcb_C2711
 + capPcb_C2520
 + capPcb_C2521
 + capPcb_C2550
 + capPcb_C2551
 + capPcb_C2604
 + capPcb_C2605
 + pwr_pmic_0p95
 + capPcb_C2556
 + capPcb_C2557
 + capPcb_C2562
 + capPcb_C2565
 + capPcb_C2577
 + capPcb_C2584
 + capPcb_C2625
 + capPcb_C2690
 + capPcb_C2691
 + capPcb_C2697
 + capPcb_C2713
 + capPcb_C2736
 + pwr_pmic_1p8
 + capPcb_C2553
 + capPcb_C2559
 + capPcb_C2586
 + capPcb_C2631
 + capPcb_C2694
 + capPcb_C2717
 + pwr_pmic_pcie_1p8
 + ref_gnd
 + str(PCB_model)
 
 XcapPcb_C2519	capPcb_C2519	ref_gnd		str(mlcc_1uF_0402)
 XcapPcb_C2546	capPcb_C2546	ref_gnd		str(mlcc_1uF_0402) 
 XcapPcb_C2575	capPcb_C2575	ref_gnd		str(mlcc_2p2uF_0603) 
 XcapPcb_C2580	capPcb_C2580	ref_gnd		str(mlcc_2p2uF_0603)  
 XcapPcb_C2710	capPcb_C2710	ref_gnd		str(mlcc_10uF_0402)
 XcapPcb_C2711	capPcb_C2711	ref_gnd		str(mlcc_10uF_0402)

 XcapPcb_C2562	capPcb_C2562	ref_gnd		str(mlcc_1uF_0402)
 XcapPcb_C2565	capPcb_C2565	ref_gnd		str(mlcc_1uF_0402) 
 XcapPcb_C2577	capPcb_C2577	ref_gnd		str(mlcc_2p2uF_0603) 
 XcapPcb_C2713	capPcb_C2713	ref_gnd		str(mlcc_2p2uF_0603)  
 XcapPcb_C2697	capPcb_C2697	ref_gnd		str(mlcc_10uF_0402)
 XcapPcb_C2736	capPcb_C2736	ref_gnd		str(mlcc_10uF_0402)
 


***** opt 1/2: filter 
	 xModel_filter_vddc							*** NOTE: vddc filter impact is larger 
	 + bga_pwr_eth_0p95
	 + bga_pwr_vdd_c
	 + ref_gnd
	 * + model_filter
	 + model_filter_22uF
	 
	 xModel_filter_vddd							*** NOTE: vddd filter impact is larger 
	 + bga_pwr_eth_0p95
	 + bga_pwr_vdd_d
	 + ref_gnd
	 * + model_filter
	 + model_filter_22uF
	 
	 xModel_filter_vddh
	 + bga_pwr_eth_1p8
	 + bga_pwr_vdd_h
	 + ref_gnd
	 + model_filter
	 * + model_filter_22uF

	 xModel_filter_vddh_cmn						*** NOTE: h_cmn filter impact is larger  
	 + bga_pwr_eth_1p8
	 + bga_pwr_vdd_h_cmn
	 + ref_gnd
	 + model_filter
	 * + model_filter_22uF

***** opt 2/2, shorting VDDC, VDDD to PCB 
	 * r_vddc bga_pwr_vdd_c		bga_pwr_eth_0p95	1.n
	 * r_vddd bga_pwr_vdd_d		bga_pwr_eth_0p95	1.n
	 * r_vddh bga_pwr_vdd_h		bga_pwr_eth_1p8		1.n			*** NOTE: h p2p prefers w/o filter
	 * r_vddh_cmn bga_pwr_vdd_h_cmn	bga_pwr_eth_1p8		1.n 
 
 
  ***** pkg
xblk_pkg
 + bga_pwr_vdd_h_cmn 		
 + bga_pwr_vdd_c			
 + bga_pwr_vdd_d			
 + bga_pwr_vdd_h			
 + bump_pwr_vdd_h_cmn
 + bump_pwr_vdd_c
 + bump_pwr_vdd_d
 + bump_pwr_vdd_h
 + capPkg_C117_vdd_c
 + capPkg_C130_vdd_d
 + capPkg_C129_vdd_h
 + ref_gnd 
 + str(pkg_model)
 
 XcapPkg_C117_vdd_c		capPkg_C117_vdd_c	ref_gnd	str(mlcc_4p7nF_0201)
 XcapPkg_C130_vdd_d		capPkg_C130_vdd_d	ref_gnd	str(mlcc_0p47nF_0201)
 XcapPkg_C129_vdd_h		capPkg_C129_vdd_h	ref_gnd	str(mlcc_0p47nF_0201)
 
			 *** debug CDNS pkg 
			 * xblk_pkg 
			 * + bump_pwr_vdd_c_x1
			 * + bump_pwr_vdd_c 
			 * + bump_pwr_vdd_c_x8
			 * + bump_pwr_vdd_h_x1
			 * + bump_pwr_vdd_h 
			 * + bump_pwr_vdd_h_x8			 
			 * + bump_pwr_vdd_d_x1
			 * + bump_pwr_vdd_d 
			 * + bump_pwr_vdd_d_x8			 
			 * + bump_pwr_vdd_h_cmn_x1
			 * + bump_pwr_vdd_h_cmn 
			 * + bump_pwr_vdd_h_cmn_x8	
			 * + bga_pwr_vdd_c_x1
			 * + bga_pwr_vdd_c 
			 * + bga_pwr_vdd_c_x8
			 * + bga_pwr_vdd_h_x1
			 * + bga_pwr_vdd_h 
			 * + bga_pwr_vdd_h_x8			 
			 * + bga_pwr_vdd_d_x1
			 * + bga_pwr_vdd_d 
			 * + bga_pwr_vdd_d_x8			 
			 * + bga_pwr_vdd_h_cmn_x1
			 * + bga_pwr_vdd_h_cmn 
			 * + bga_pwr_vdd_h_cmn_x8	
			 * + ref_gnd 
			 * + str(pkg_model)			 
			 *** debug CDNS pkg end 
 
 ***** die 
 *** Note: all 3 lanes use same profile for now
 Xblk_die_vdd_c_cmn 		bump_pwr_vdd_c	ref_gnd	model_die_eth_vdd_cdh_cmn	Cdie= 'Cdie_avdd_c_cmn'		Rdie= 'Rdie_avdd_c_cmn'		Res= 'Res_avdd_c_cmn' 	delay = 0.
 + pwl_file_in = str(currSrc_vdd_c_cmn)
 Xblk_die_vdd_c_lane_0 		bump_pwr_vdd_c	ref_gnd	model_die_eth_vdd_cdh	Cdie= 'Cdie_avdd_c'			Rdie= 'Rdie_avdd_c'			Res= 'Res_avdd_c' 	delay = 0.
 + pwl_file_in_tx = str(currSrc_vdd_c_tx)	pwl_file_in_rx = str(currSrc_vdd_c_rx)
 Xblk_die_vdd_c_lane_1 		bump_pwr_vdd_c	ref_gnd	model_die_eth_vdd_cdh	Cdie= 'Cdie_avdd_c'			Rdie= 'Rdie_avdd_c'			Res= 'Res_avdd_c' 	delay = 800.p
 + pwl_file_in_tx = str(currSrc_vdd_c_tx)	pwl_file_in_rx = str(currSrc_vdd_c_rx)
 Xblk_die_vdd_c_lane_2 		bump_pwr_vdd_c	ref_gnd	model_die_eth_vdd_cdh	Cdie= 'Cdie_avdd_c'			Rdie= 'Rdie_avdd_c'			Res= 'Res_avdd_c' 	delay = 1600.p
 + pwl_file_in_tx = str(currSrc_vdd_c_tx)	pwl_file_in_rx = str(currSrc_vdd_c_rx)
 
 Xblk_die_vdd_d_cmn 		bump_pwr_vdd_d	ref_gnd	model_die_eth_vdd_cdh_cmn	Cdie= 'Cdie_avdd_d_cmn'		Rdie= 'Rdie_avdd_d_cmn'		Res= 'Res_avdd_d_cmn' 	delay = 0.
 + pwl_file_in = str(currSrc_vdd_d_cmn)
 Xblk_die_vdd_d_lane_0 		bump_pwr_vdd_d	ref_gnd	model_die_eth_vdd_cdh	Cdie= 'Cdie_avdd_d'			Rdie= 'Rdie_avdd_d'			Res= 'Res_avdd_d' 	delay = 0.
 + pwl_file_in_tx = str(currSrc_vdd_d_tx)	pwl_file_in_rx = str(currSrc_vdd_d_rx)
 Xblk_die_vdd_d_lane_1 		bump_pwr_vdd_d	ref_gnd	model_die_eth_vdd_cdh	Cdie= 'Cdie_avdd_d'			Rdie= 'Rdie_avdd_d'			Res= 'Res_avdd_d' 	delay = 800.p
 + pwl_file_in_tx = str(currSrc_vdd_d_tx)	pwl_file_in_rx = str(currSrc_vdd_d_rx)
 Xblk_die_vdd_d_lane_2 		bump_pwr_vdd_d	ref_gnd	model_die_eth_vdd_cdh	Cdie= 'Cdie_avdd_d'			Rdie= 'Rdie_avdd_d'			Res= 'Res_avdd_d' 	delay = 1600.p
 + pwl_file_in_tx = str(currSrc_vdd_d_tx)	pwl_file_in_rx = str(currSrc_vdd_d_rx)
 
 Xblk_die_vdd_h_cmn 		bump_pwr_vdd_h_cmn	ref_gnd	model_die_eth_vdd_cdh_cmn	Cdie= 'Cdie_avdd_h_cmn'		Rdie= 'Rdie_avdd_h_cmn'		Res= 'Res_avdd_h_cmn' 	delay = 0.	
 + pwl_file_in = str(currSrc_vdd_h_cmn)
 
 Xblk_die_vdd_h_lane_0 		bump_pwr_vdd_h	ref_gnd	model_die_eth_vdd_cdh	Cdie= 'Cdie_avdd_h'			Rdie= 'Rdie_avdd_h'			Res= 'Res_avdd_h' 	delay = 0.
 + pwl_file_in_tx = str(currSrc_vdd_h_tx)	pwl_file_in_rx = str(currSrc_vdd_h_rx)
 Xblk_die_vdd_h_lane_1 		bump_pwr_vdd_h	ref_gnd	model_die_eth_vdd_cdh	Cdie= 'Cdie_avdd_h'			Rdie= 'Rdie_avdd_h'			Res= 'Res_avdd_h' 	delay = 800.p
 + pwl_file_in_tx = str(currSrc_vdd_h_tx)	pwl_file_in_rx = str(currSrc_vdd_h_rx)
 Xblk_die_vdd_h_lane_2 		bump_pwr_vdd_h	ref_gnd	model_die_eth_vdd_cdh	Cdie= 'Cdie_avdd_h'			Rdie= 'Rdie_avdd_h'			Res= 'Res_avdd_h' 	delay = 1600.p
 + pwl_file_in_tx = str(currSrc_vdd_h_tx)	pwl_file_in_rx = str(currSrc_vdd_h_rx)
 
*** run settings 
.option post=1
.option parhier = local 
.option measform = 1
.option lis_new
.option post probe

.param is_ac_run = 0

.if ( is_ac_run == 1 )  *** jgwei AC sim
	.if ( 1 )
		*** NOTE: DO not include port def if tran analysis later
		P1 bump_pwr_vdd_c		ref_gnd	port=1	z0 = 0.1
		P2 bump_pwr_vdd_d		ref_gnd	port=2	z0 = 0.1
		P3 bump_pwr_vdd_h		ref_gnd	port=3	z0 = 0.1
		P4 bump_pwr_vdd_h_cmn	ref_gnd	port=4	z0 = 0.1
		
		.lin 	sparcalc=1 	filename=impedance_plot	noisecalc=0 	gdcalc=0	format=touchstone 	dataformat=MA 
		.probe ac zin(1)(m) zin(1)(p) zin(2)(m) zin(2)(p)  zin(3)(m) zin(3)(p)  zin(4)(m) zin(4)(p)
		
		.ac 	dec 50 1. 1.G
			
	.endif 

.endif 


.if ( is_ac_run != 1 )  *** jgwei trans sim
	.param tStep	= 10.p
	.param tStop	= 1.u
	
	.tran tStep tSTOP 

	.probe tran v(bump_pwr_vdd_c) 	v(bump_pwr_vdd_d)	v(bump_pwr_vdd_h)	v(bump_pwr_vdd_h_cmn)
	.probe x(xblk_pkg.a_6)   x(xblk_pkg.a_7) 	x(xblk_pkg.a_8)		x(xblk_pkg.a_5) 

	.param vdd_meas_start = 0.n
	.param vdd_meas_end   = 1000.n
	.meas tran bump_pwr_vdd_c_p2p 	PP	V(bump_pwr_vdd_c)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_c_vmax	MAX	V(bump_pwr_vdd_c)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_c_vmin	MIN	V(bump_pwr_vdd_c)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_c_vmax_t	WHEN	V(bump_pwr_vdd_c) = 'bump_pwr_vdd_c_vmax' 	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_c_vmin_t	WHEN	V(bump_pwr_vdd_c) = 'bump_pwr_vdd_c_vmin' 	from='vdd_meas_start' to='vdd_meas_end'

	.meas tran bump_pwr_vdd_d_p2p 	PP	V(bump_pwr_vdd_d)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_d_vmax	MAX	V(bump_pwr_vdd_d)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_d_vmin	MIN	V(bump_pwr_vdd_d)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_d_vmax_t	WHEN	V(bump_pwr_vdd_d) = 'bump_pwr_vdd_d_vmax' 	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_d_vmin_t	WHEN	V(bump_pwr_vdd_d) = 'bump_pwr_vdd_d_vmin' 	from='vdd_meas_start' to='vdd_meas_end'

	.meas tran bump_pwr_vdd_h_p2p 	PP	V(bump_pwr_vdd_h)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_h_vmax	MAX	V(bump_pwr_vdd_h)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_h_vmin	MIN	V(bump_pwr_vdd_h)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_h_vmax_t	WHEN	V(bump_pwr_vdd_h) = 'bump_pwr_vdd_h_vmax' 	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_h_vmin_t	WHEN	V(bump_pwr_vdd_h) = 'bump_pwr_vdd_h_vmin' 	from='vdd_meas_start' to='vdd_meas_end'

	.meas tran bump_pwr_vdd_h_cmn_p2p 	PP	V(bump_pwr_vdd_h_cmn)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_h_cmn_vmax	MAX	V(bump_pwr_vdd_h_cmn)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_h_cmn_vmin	MIN	V(bump_pwr_vdd_h_cmn)	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_h_cmn_vmax_t	WHEN	V(bump_pwr_vdd_h_cmn) = 'bump_pwr_vdd_h_cmn_vmax' 	from='vdd_meas_start' to='vdd_meas_end'
	.meas tran bump_pwr_vdd_h_cmn_vmin_t	WHEN	V(bump_pwr_vdd_h_cmn) = 'bump_pwr_vdd_h_cmn_vmin' 	from='vdd_meas_start' to='vdd_meas_end'

	
.endif 