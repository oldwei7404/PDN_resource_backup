
***** input settings 
.param Vdd_c_d 			= '0.75'
.param Vdd_h			= '1.2'

	*** PCB model 
.inc 	/data/home/jiangongwei/work/PDN_SerDes/PDN_SerDes_PCIE/inc_data/ACM2_PT00547399_A_01_PWR_cut_pcie_eth_usb_run3_v2_IdEM.cir
.param PCB_model = str('ACM2_PT00547399_A_01_PWR_cut_pcie_eth_usb_run3_v2_IdEM')
.inc 	/data/home/jiangongwei/work/PDN_SerDes/PDN_SerDes_PCIE/inc_data/ACM3_06042024_HSIO_075_REV2_Discrete_IdEM.cir
.inc 	/data/home/jiangongwei/work/PDN_SerDes/PDN_SerDes_PCIE/inc_data/ACM3_06042024_HSIO_075_REV2_Discrete_Andes.cir

	*** pkg model 
.inc	/data/home/jiangongwei/work/PDN_SerDes/PDN_SerDes_PCIE/inc_data/ZJC_5_PDN_SerDes_cut_only_PCIE_IdEM.cir
.param pkg_model = str('ZJC_5_PDN_SerDes_cut_only_PCIE_IdEM')

* .inc	/data/home/jiangongwei/work/PDN_SerDes/PDN_SerDes_PCIE/inc_data/Mam_MCM_L12_BH9_Ballv0p82_AVDD075CLKPCIE_L6_mod1_12_BallMap.cir		*** 20231220 Andes pcie pkg 
* .param	pkg_model = str('Mam_MCM_L12_BH9_Ballv0p82_AVDD075CLKPCIE_L6_mod1_12_BallMap')

	*** other device model

***** current profile 231213
	*** vddc *** 
.param currSrc_vdd_c_cmn = str('./inc_data/profile_1213/i_avdd_clk_a0_cmn_WC.csv')				
			
.param currSrc_vdd_c_ln0 = str('./inc_data/profile_1213/i_avdd_clk_a0_lane_L0_WC.csv')						*** case 1
.param currSrc_vdd_c_ln1 = str('./inc_data/profile_1213/i_avdd_clk_a0_lane_L1_WC.csv')
.param currSrc_vdd_c_ln2 = str('./inc_data/profile_1213/i_avdd_clk_a0_lane_L2_WC.csv')
.param currSrc_vdd_c_ln3 = str('./inc_data/profile_1213/i_avdd_clk_a0_lane_L3_WC.csv')	
	* .param currSrc_vdd_c_ln0 = str('./inc_data/profile_1213/i_avdd_clk_a4_a0_a4_lane_L0_WC.csv')			*** case 2
	* .param currSrc_vdd_c_ln1 = str('./inc_data/profile_1213/i_avdd_clk_a4_a0_a4_lane_L1_WC.csv')
	* .param currSrc_vdd_c_ln2 = str('./inc_data/profile_1213/i_avdd_clk_a4_a0_a4_lane_L2_WC.csv')
	* .param currSrc_vdd_c_ln3 = str('./inc_data/profile_1213/i_avdd_clk_a4_a0_a4_lane_L3_WC.csv')

	* *** vddd *** 
.param currSrc_vdd_d_cmn = str('./inc_data/profile_1213/i_avdd_a0_cmn_WC.csv')

.param currSrc_vdd_d_ln0 = str('./inc_data/profile_1213/i_avdd_a0_lane_L0_WC.csv')
.param currSrc_vdd_d_ln1 = str('./inc_data/profile_1213/i_avdd_a0_lane_L1_WC.csv')
.param currSrc_vdd_d_ln2 = str('./inc_data/profile_1213/i_avdd_a0_lane_L2_WC.csv')
.param currSrc_vdd_d_ln3 = str('./inc_data/profile_1213/i_avdd_a0_lane_L3_WC.csv')
	* .param currSrc_vdd_d_ln0 = str('./inc_data/profile_1213/i_avdd_a4_a0_a4_lane_L0_WC.csv')
	* .param currSrc_vdd_d_ln1 = str('./inc_data/profile_1213/i_avdd_a4_a0_a4_lane_L1_WC.csv')
	* .param currSrc_vdd_d_ln2 = str('./inc_data/profile_1213/i_avdd_a4_a0_a4_lane_L2_WC.csv')
	* .param currSrc_vdd_d_ln3 = str('./inc_data/profile_1213/i_avdd_a4_a0_a4_lane_L3_WC.csv')
 
	*** vddh *** 
.param currSrc_vdd_h_cmn = str('./inc_data/profile_1213/i_avdd_h_a0_cmn_WC.csv')

.param currSrc_vdd_h_ln0 = str('./inc_data/profile_1213/i_avdd_h_a0_lane_L0_WC.csv')
.param currSrc_vdd_h_ln1 = str('./inc_data/profile_1213/i_avdd_h_a0_lane_L1_WC.csv')
.param currSrc_vdd_h_ln2 = str('./inc_data/profile_1213/i_avdd_h_a0_lane_L2_WC.csv')
.param currSrc_vdd_h_ln3 = str('./inc_data/profile_1213/i_avdd_h_a0_lane_L3_WC.csv')
	* .param currSrc_vdd_h_ln0 = str('./inc_data/profile_1213/i_avdd_h_a4_a0_a4_lane_L0_WC.csv')
	* .param currSrc_vdd_h_ln1 = str('./inc_data/profile_1213/i_avdd_h_a4_a0_a4_lane_L1_WC.csv')
	* .param currSrc_vdd_h_ln2 = str('./inc_data/profile_1213/i_avdd_h_a4_a0_a4_lane_L2_WC.csv')
	* .param currSrc_vdd_h_ln3 = str('./inc_data/profile_1213/i_avdd_h_a4_a0_a4_lane_L3_WC.csv')

***** current profiles 10/18
	* *** vddc *** 
* .param currSrc_vdd_c_cmn = str('./inc_data/profile_1017/i_avdd_clk_a0_cmn_WC.csv')
* * .param currSrc_vdd_c_ln0 = str('./inc_data/profile_1017/i_avdd_clk_a0_lane_0_WC.csv')	
	* .param currSrc_vdd_c_ln0 = str('./inc_data/profile_1017/i_avdd_clk_a4_a0_a4_lane_0_WC.csv')			*** NOTE: run > 5us
* * .param currSrc_vdd_c_ln1 = str('./inc_data/profile_1017/i_avdd_clk_a0_lane_1_WC.csv')
	* .param currSrc_vdd_c_ln1 = str('./inc_data/profile_1017/i_avdd_clk_a4_a0_a4_lane_1_WC.csv')			*** NOTE: run > 5us
* * .param currSrc_vdd_c_ln2 = str('./inc_data/profile_1017/i_avdd_clk_a0_lane_2_WC.csv')
	* .param currSrc_vdd_c_ln2 = str('./inc_data/profile_1017/i_avdd_clk_a4_a0_a4_lane_2_WC.csv')			*** NOTE: run > 5us
* .param currSrc_vdd_c_ln3 = str('./inc_data/profile_1017/i_avdd_clk_a0_lane_3_WC.csv')
	* * .param currSrc_vdd_c_ln3 = str('./inc_data/profile_1017/i_avdd_clk_a4_a0_a4_lane_3_WC.csv')	
	
	* *** vddd ***
* .param currSrc_vdd_d_cmn = str('./inc_data/profile_1017/i_avdd_a0_cmn_WC.csv')
* * .param currSrc_vdd_d_ln0 = str('./inc_data/profile_1017/i_avdd_a0_lane_0_WC.csv')
	* .param currSrc_vdd_d_ln0 = str('./inc_data/profile_1017/i_avdd_a4_a0_a4_lane_0_WC.csv')
* * .param currSrc_vdd_d_ln1 = str('./inc_data/profile_1017/i_avdd_a0_lane_1_WC.csv')
	* .param currSrc_vdd_d_ln1 = str('./inc_data/profile_1017/i_avdd_a4_a0_a4_lane_1_WC.csv')
* * .param currSrc_vdd_d_ln2 = str('./inc_data/profile_1017/i_avdd_a0_lane_2_WC.csv')
	* .param currSrc_vdd_d_ln2 = str('./inc_data/profile_1017/i_avdd_a4_a0_a4_lane_2_WC.csv')
* .param currSrc_vdd_d_ln3 = str('./inc_data/profile_1017/i_avdd_a0_lane_3_WC.csv')
	* * .param currSrc_vdd_d_ln3 = str('./inc_data/profile_1017/i_avdd_a4_a0_a4_lane_3_WC.csv')

	* *** vddh ***
* .param currSrc_vdd_h_cmn = str('./inc_data/profile_1017/i_avdd_h_a0_cmn_WC.csv')
* * .param currSrc_vdd_h_ln0 = str('./inc_data/profile_1017/i_avdd_h_a0_lane_0_WC.csv')
	* .param currSrc_vdd_h_ln0 = str('./inc_data/profile_1017/i_avdd_h_a4_a0_a4_lane_0_WC.csv')
* * .param currSrc_vdd_h_ln1 = str('./inc_data/profile_1017/i_avdd_h_a0_lane_1_WC.csv')
	* .param currSrc_vdd_h_ln1 = str('./inc_data/profile_1017/i_avdd_h_a4_a0_a4_lane_1_WC.csv')
* * .param currSrc_vdd_h_ln2 = str('./inc_data/profile_1017/i_avdd_h_a0_lane_2_WC.csv')
	* .param currSrc_vdd_h_ln2 = str('./inc_data/profile_1017/i_avdd_h_a4_a0_a4_lane_2_WC.csv')
* .param currSrc_vdd_h_ln3 = str('./inc_data/profile_1017/i_avdd_h_a0_lane_3_WC.csv')
	* * .param currSrc_vdd_h_ln3 = str('./inc_data/profile_1017/i_avdd_h_a4_a0_a4_lane_3_WC.csv')

*** debug to use 0 current for some rails 
* .param currSrc_vdd_c_cmn = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_c_ln0 = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_c_ln1 = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_c_ln2 = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_c_ln3 = str('./inc_data/i_curr_0.csv')

* .param currSrc_vdd_d_cmn = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_d_ln0 = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_d_ln1 = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_d_ln2 = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_d_ln3 = str('./inc_data/i_curr_0.csv')

* .param currSrc_vdd_h_cmn = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_h_ln0 = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_h_ln1 = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_h_ln2 = str('./inc_data/i_curr_0.csv')
* .param currSrc_vdd_h_ln3 = str('./inc_data/i_curr_0.csv')
*** end of debug to quite vddd, vddh

***** die params 
.param Cdie_avdd_c_xcvr	= '268p'
.param Rdie_avdd_c_xcvr = '73m'
.param Res_avdd_c_xcvr  = '103m'
.param Cdie_avdd_c_cmn 	= '245p'
.param Rdie_avdd_c_cmn 	= '56m'
.param Res_avdd_c_cmn  	= '214m'

.param Cdie_avdd_d_xcvr	= '1.793n'
.param Rdie_avdd_d_xcvr = '98m'
.param Res_avdd_d_xcvr  = '131m'
.param Cdie_avdd_d_cmn 	= '1.76n'
.param Rdie_avdd_d_cmn 	= '22m'
.param Res_avdd_d_cmn  	= '308m'

.param Cdie_avdd_h_xcvr	= '81p'
.param Res_avdd_h_xcvr = '93m'
.param Cdie_avdd_h_cmn 	= '50p'
.param Res_avdd_h_cmn 	= '80m'

***** end of user input 
***** die models 
.subckt model_die_pcie_vdd_cdh_cmn
+ pin_bump ref_gnd Cdie = 1n. 	Rdie = 125m		Res = 50m	pwl_file_in = str('./currSrc.csv')	

R_res_		pin_bump	2			Res 
C_die_		1			ref_gnd 	Cdie 
R_die_		2			1			Rdie 
IcurrSrc	2			ref_gnd		PWL pwlfile = str(pwl_file_in) 	R
.ends model_die_pcie_vdd_cdh_cmn
**
.subckt model_die_pcie_vdd_cdh
+ pin_bump ref_gnd Cdie = 1n. 	Rdie = 125m		Res = 50m	pwl_file_in = str('./currSrc.csv')

R_res_		pin_bump	2			Res 
C_die_		1			ref_gnd 	Cdie 
R_die_		2			1			Rdie 
IcurrSrc	2			ref_gnd		PWL pwlfile = str(pwl_file_in) 	R
.ends model_die_pcie_vdd_cdh

.subckt meas_filter
+ pin_in  ref_gnd 	hf  lf 

E_meas pin_meas ref_gnd  pin_in ref_gnd	1.0

C_hf pin_meas	hf  	159.15p
R_hf hf         ref_gnd 1k

R_lf pin_meas	lf		1k
C_lf lf 		ref_gnd	159.15p
.ends meas_filter

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
.inc /data/home/jiangongwei/work/models_cap/open_circuit.mod

.inc /data/home/jiangongwei/work/models_cap/EC1001.mod
.inc /data/home/jiangongwei/work/models_cap/EC1002.mod
.inc /data/home/jiangongwei/work/models_cap/EC1100_200nF.mod
.inc /data/home/jiangongwei/work/models_cap/EC1004_240nF_fix.mod
.inc /data/home/jiangongwei/work/models_cap/ECAP_1000nF_6x3_fix.mod

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

.param siCap_empwr_EC1001 = str('EC1001')
.param siCap_empwr_EC1002 = str('EC1002')
.param siCap_empwr_EC1100_200nF = str('EC1100_200nF')
.param siCap_empwr_EC1004_240nF = str('EC1004')
.param siCap_empwr_EC1000nF_6x3 = str('ECAP_1000nF_6x3')

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
Vsrc_vdd_h		pwr_pmic_pcie_1p8 	ref_gnd	Vdd_h		*** can be switched to PMIC model 

					* ***** enable to debug, to short PCB (i.e., connect pkg directly to PMIC)
					* r_vddc bga_pwr_pcie_0p95_vddc	bga_pwr_pcie_0p95	1.n
					* r_vddd bga_pwr_pcie_0p95_vddd	bga_pwr_pcie_0p95	1.n
						 
					* r_debug_pcie_0p95_to_pmic 	bga_pwr_pcie_0p95		pwr_pmic_0p95	1.n
					* r_debug_pcie_1p8_to_pmic 	bga_pwr_pcie_1p8		pwr_pmic_pcie_1p8	1.n
	
***** PCB 
.if ( 0 )  *** ACM2 board 
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
	 
	 xcapPcb_C2520	capPcb_C2520	ref_gnd		str(mlcc_1uF_0402)
	 xcapPcb_C2521	capPcb_C2521	ref_gnd		str(mlcc_1uF_0402) 
	 xcapPcb_C2550	capPcb_C2550	ref_gnd		str(mlcc_2p2uF_0603) 
	 xcapPcb_C2551	capPcb_C2551	ref_gnd		str(mlcc_2p2uF_0603)  
	 xcapPcb_C2604	capPcb_C2604	ref_gnd		str(mlcc_10uF_0402)
	 xcapPcb_C2605	capPcb_C2605	ref_gnd		str(mlcc_10uF_0402)

	 xcapPcb_C2553	capPcb_C2553	ref_gnd		str(mlcc_1uF_0402)
	 xcapPcb_C2559	capPcb_C2559	ref_gnd		str(mlcc_1uF_0402) 
	 xcapPcb_C2586	capPcb_C2586	ref_gnd		str(mlcc_2p2uF_0603) 
	 xcapPcb_C2631	capPcb_C2631	ref_gnd		str(mlcc_2p2uF_0603)  
	 xcapPcb_C2694	capPcb_C2694	ref_gnd		str(mlcc_10uF_0402)
	 xcapPcb_C2717	capPcb_C2717	ref_gnd		str(mlcc_10uF_0402)
	 
	*****
		***** filter 
		 xModel_filter_vddc
		 + bga_pwr_pcie_0p95
		 + bga_pwr_pcie_0p95_vddc
		 + ref_gnd
		 + model_filter
		 * + model_filter_22uF
		 
		 * xModel_filter_vddd
		 * + bga_pwr_pcie_0p95
		 * + bga_pwr_pcie_0p95_vddd
		 * + ref_gnd
		 * + model_filter
		 * * + model_filter_22uF


	 ***** shorting VDDC, VDDD to PCB 
		 * r_vddc bga_pwr_pcie_0p95_vddc	bga_pwr_pcie_0p95	1.n
		 r_vddd bga_pwr_pcie_0p95_vddd	bga_pwr_pcie_0p95	1.n

.endif *** ACM2 board end 

.if ( 1 )  *** ACM3 board 0p75V only (plug to node 0p95V)
	xblk_PCB
	+ pwr_pmic_0p95
	+ pwr_pmic_0p95
	+ P0V75_C2C_A_C177
	+ P0V75_C2C_A_C178
	+ P0V75_C2C_A_C179
	+ P0V75_C2C_A_C823
	+ P0V75_C2C_A_FB_PORT1
	+ P0V75_C2C_A_FB_PORT2
	+ P0V75_C2C_CLK_A_C189
	+ P0V75_C2C_CLK_A_C190
	+ P0V75_C2C_CLK_A_C191
	+ P0V75_C2C_CLK_A_C827
	+ P0V75_C2C_CLK_A_PORT1
	+ P0V75_C2C_CLK_A_PORT2
	+ P0V75_ETH10G_A_C157
	+ P0V75_ETH10G_A_C158
	+ P0V75_ETH10G_A_C159
	+ P0V75_ETH10G_A_C164
	+ P0V75_ETH10G_A_FB_PORT1
	+ P0V75_ETH10G_A_FB_PORT2
	+ P0V75_ETH10G_CLK_A_C152
	+ P0V75_ETH10G_CLK_A_C153
	+ P0V75_ETH10G_CLK_A_C154
	+ P0V75_ETH10G_CLK_A_C155
	+ P0V75_ETH10G_CLK_A_FB_PORT1
	+ P0V75_ETH10G_CLK_A_FB_PORT2
	+ P0V75_HSIO_A_C2513
	+ P0V75_HSIO_A_C2514
	+ P0V75_HSIO_A_C2515
	+ P0V75_HSIO_A_C2516
	+ CapPcb_C182											* P0V75_PCIe_A_C182
	+ CapPcb_C183											* P0V75_PCIe_A_C183
	+ CapPcb_C184											* P0V75_PCIe_A_C184
	+ CapPcb_C815											* P0V75_PCIe_A_C815
	+ P0V75_PCIe_A_FB_PORT1
	+ P0V75_PCIe_A_FB_PORT2
	+ CapPcb_C169								* P0V75_PCIe_CLK_A_C169
	+ CapPcb_C170								* P0V75_PCIe_CLK_A_C170
	+ CapPcb_C171								* P0V75_PCIe_CLK_A_C171
	+ CapPcb_C192								* P0V75_PCIe_CLK_A_C192
	+ P0V75_PCIe_CLK_A_FB_PORT1
	+ P0V75_PCIe_CLK_A_FB_PORT2
	+ PORT_U68_NetL127_Group_U68_GND_Group
	+ U14_U14_P0V75_C2C_A_Group_U14_GND_Group
	+ U14_U14_P0V75_C2C_CLK_A_Group_U14_GND_Group
	+ U14_U14_P0V75_ETH10G_A_Group_U14_GND_Group
	+ U14_U14_P0V75_ETH10G_CLK_A_Group_U14_GND_Group
	+ bga_pwr_pcie_0p95_vddd							* U14_U14_P0V75_PCIe_A_Group_U14_GND_Group
	+ bga_pwr_pcie_0p95_vddc							* U14_U14_P0V75_PCIe_CLK_A_Group_U14_GND_Group
	+ ref_gnd
	+ ACM3_06042024_HSIO_075_REV2_Discrete_IdEM
	* + ACM3_06042024_HSIO_075_REV2_Discrete_Andes
 
	xCapPcb_C192  	CapPcb_C192	ref_gnd		str(mlcc_47uF_1206)
	xCapPcb_C169  	CapPcb_C169	ref_gnd		str(mlcc_1uF_0402)
	xCapPcb_C170  	CapPcb_C170	ref_gnd		str(mlcc_0p1uF_0402)
	xCapPcb_C171  	CapPcb_C171	ref_gnd		str(mlcc_0p01uF_0201)
											
	xCapPcb_C815  	CapPcb_C815	ref_gnd		str(mlcc_0p1uF_0402)
	xCapPcb_C182  	CapPcb_C182	ref_gnd		str(mlcc_1uF_0402)
	xCapPcb_C183  	CapPcb_C183	ref_gnd		str(mlcc_0p1uF_0402)
	xCapPcb_C184  	CapPcb_C184	ref_gnd		str(mlcc_0p01uF_0201)
	
	*** FB 0p75V rail
	xFB_pcie_vddc			P0V75_PCIe_CLK_A_FB_PORT1	P0V75_PCIe_CLK_A_FB_PORT2 	str(ferrite_mod1)
	* r_pcie_vddc_fb_short	P0V75_PCIe_CLK_A_FB_PORT1	P0V75_PCIe_CLK_A_FB_PORT2 	1.n					*** short FB 
	
	xFB_pcie_vddd			P0V75_PCIe_A_FB_PORT1	P0V75_PCIe_A_FB_PORT2 	str(ferrite_mod1)
	* r_pcie_vddd_fb_short	P0V75_PCIe_A_FB_PORT1	P0V75_PCIe_A_FB_PORT2 	1.n							*** short FB

 .endif	*** ACM3 board end  

 
 ***** pkg 
 xblk_pkg
  + bga_pwr_pcie_0p95_vddc 	ref_gnd			
  + bga_pwr_pcie_0p95_vddd	ref_gnd	
  + bga_pwr_pcie_1p8	ref_gnd			*NOTE: bga_pwr_vdd_h
  + bump_pwr_vdd_c		ref_gnd
  + bump_pwr_vdd_d		ref_gnd
  + bump_pwr_vdd_h		ref_gnd
  + capPkg_C133_vdd_c	ref_gnd
  + capPkg_C141_vdd_d	ref_gnd
  + capPkg_C140_vdd_h	ref_gnd
  + str(pkg_model)
  
  xcapPkg_C133_vdd_c  	capPkg_C133_vdd_c ref_gnd 	str(mlcc_2p2nF_0201)
  xcapPkg_C141_vdd_d  	capPkg_C141_vdd_d ref_gnd 	str(mlcc_0p1uF_0204)
  xcapPkg_C140_vdd_h  	capPkg_C140_vdd_h ref_gnd 	str(mlcc_0p47nF_0201)
  
  *** test to add more DSC
    * xcapPkg_C133_2_vdd_c  	capPkg_C133_vdd_c 	str(siCap_empwr_EC1100_200nF)
	* xcapPkg_C133_3_vdd_c  	capPkg_C133_vdd_c 	str(siCap_empwr_EC1100_200nF)
	* xcapPkg_C133_4_vdd_c  	capPkg_C133_vdd_c 	str(siCap_empwr_EC1100_200nF)
	
 *** test to add more DSC using si cap	
	* xcapPkg_C133_2_vdd_c 	
	* + capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c
	* + ref_gnd ref_gnd ref_gnd ref_gnd ref_gnd ref_gnd 
	* + str(siCap_empwr_EC1004_240nF)	
	* xcapPkg_C133_3_vdd_c 	
	* + capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c
	* + ref_gnd ref_gnd ref_gnd ref_gnd ref_gnd ref_gnd 
	* + str(siCap_empwr_EC1004_240nF)	
	* xcapPkg_C133_4_vdd_c 	
	* + capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c	capPkg_C133_vdd_c
	* + ref_gnd ref_gnd ref_gnd ref_gnd ref_gnd ref_gnd 
	* + str(siCap_empwr_EC1004_240nF)	
 
 * xblk_pkg 		*** 20231220 Andes pcie pkg 
 * + a_1  a_2  a_3  a_4  a_5  a_6  a_7  a_8  a_9  a_10
 * + bump_pwr_vdd_c bump_pwr_vdd_d bump_pwr_vdd_h a_14 a_15 a_16 a_17 a_18 a_19 a_20
 * + a_21 a_22 a_23 a_24 a_25 a_26 a_27 a_28 bga_pwr_pcie_0p95_vddc bga_pwr_pcie_0p95_vddd
 * + bga_pwr_pcie_1p8 a_32 a_33 a_34 a_35 a_36 a_37 a_38 a_39 a_40
 * + a_41 a_42 a_43 a_44 a_45 a_46 a_47 a_48 a_49 a_50
 * + a_51 a_52 a_53 ref_gnd
 * + str(pkg_model)
 
***** die
Xblk_die_vdd_c_cmn 			bump_pwr_vdd_c	ref_gnd	model_die_pcie_vdd_cdh_cmn	Cdie= 'Cdie_avdd_c_cmn'		Rdie= 'Rdie_avdd_c_cmn'		Res= 'Res_avdd_c_cmn'  	pwl_file_in = str(currSrc_vdd_c_cmn)
Xblk_die_vdd_c_ln0 			bump_pwr_vdd_c	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_c_xcvr'	Rdie= 'Rdie_avdd_c_xcvr'	Res= 'Res_avdd_c_xcvr'  pwl_file_in = str(currSrc_vdd_c_ln0)
Xblk_die_vdd_c_ln1 			bump_pwr_vdd_c	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_c_xcvr'	Rdie= 'Rdie_avdd_c_xcvr'	Res= 'Res_avdd_c_xcvr'  pwl_file_in = str(currSrc_vdd_c_ln1)
Xblk_die_vdd_c_ln2 			bump_pwr_vdd_c	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_c_xcvr'	Rdie= 'Rdie_avdd_c_xcvr'	Res= 'Res_avdd_c_xcvr'  pwl_file_in = str(currSrc_vdd_c_ln2)
Xblk_die_vdd_c_ln3 			bump_pwr_vdd_c	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_c_xcvr'	Rdie= 'Rdie_avdd_c_xcvr'	Res= 'Res_avdd_c_xcvr'  pwl_file_in = str(currSrc_vdd_c_ln3)

Xblk_die_vdd_d_cmn 			bump_pwr_vdd_d	ref_gnd	model_die_pcie_vdd_cdh_cmn	Cdie= 'Cdie_avdd_d_cmn'		Rdie= 'Rdie_avdd_d_cmn'		Res= 'Res_avdd_d_cmn'  	pwl_file_in = str(currSrc_vdd_d_cmn)
Xblk_die_vdd_d_ln0 			bump_pwr_vdd_d	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_d_xcvr'	Rdie= 'Rdie_avdd_d_xcvr'	Res= 'Res_avdd_d_xcvr'  pwl_file_in = str(currSrc_vdd_d_ln0)
Xblk_die_vdd_d_ln1 			bump_pwr_vdd_d	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_d_xcvr'	Rdie= 'Rdie_avdd_d_xcvr'	Res= 'Res_avdd_d_xcvr'  pwl_file_in = str(currSrc_vdd_d_ln1)
Xblk_die_vdd_d_ln2 			bump_pwr_vdd_d	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_d_xcvr'	Rdie= 'Rdie_avdd_d_xcvr'	Res= 'Res_avdd_d_xcvr'  pwl_file_in = str(currSrc_vdd_d_ln2)
Xblk_die_vdd_d_ln3 			bump_pwr_vdd_d	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_d_xcvr'	Rdie= 'Rdie_avdd_d_xcvr'	Res= 'Res_avdd_d_xcvr'  pwl_file_in = str(currSrc_vdd_d_ln3)

Xblk_die_vdd_h_cmn 			bump_pwr_vdd_h	ref_gnd	model_die_pcie_vdd_cdh_cmn	Cdie= 'Cdie_avdd_h_cmn'		Rdie= 1.e-6		Res= 'Res_avdd_h_cmn'  	pwl_file_in = str(currSrc_vdd_h_cmn)
Xblk_die_vdd_h_ln0 			bump_pwr_vdd_h	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_h_xcvr'	Rdie= 1.e-6		Res= 'Res_avdd_h_xcvr'  pwl_file_in = str(currSrc_vdd_h_ln0)
Xblk_die_vdd_h_ln1 			bump_pwr_vdd_h	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_h_xcvr'	Rdie= 1.e-6		Res= 'Res_avdd_h_xcvr'  pwl_file_in = str(currSrc_vdd_h_ln1)
Xblk_die_vdd_h_ln2 			bump_pwr_vdd_h	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_h_xcvr'	Rdie= 1.e-6		Res= 'Res_avdd_h_xcvr'  pwl_file_in = str(currSrc_vdd_h_ln2)
Xblk_die_vdd_h_ln3 			bump_pwr_vdd_h	ref_gnd	model_die_pcie_vdd_cdh		Cdie= 'Cdie_avdd_h_xcvr'	Rdie= 1.e-6		Res= 'Res_avdd_h_xcvr'  pwl_file_in = str(currSrc_vdd_h_ln3)

***** HF/LF meas
Xvddc_meas
 + bump_pwr_vdd_c
 + ref_gnd
 + pin_vddc_meas_hf
 + pin_vddc_meas_lf
 + meas_filter

Xvddd_meas
 + bump_pwr_vdd_d
 + ref_gnd
 + pin_vddd_meas_hf
 + pin_vddd_meas_lf
 + meas_filter
 
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
		P1 bump_pwr_vdd_c	ref_gnd	port=1	z0 = 0.1
		P2 bump_pwr_vdd_d	ref_gnd	port=2	z0 = 0.1
		P3 bump_pwr_vdd_h	ref_gnd	port=3	z0 = 0.1

		
		.lin 	sparcalc=1 	filename=impedance_plot	noisecalc=0 	gdcalc=0	format=touchstone 	dataformat=MA 
		.probe ac zin(1)(m) zin(1)(p) zin(2)(m) zin(2)(p)  zin(3)(m) zin(3)(p)
		
		.ac 	dec 50 1. 1.G
			
	.endif 

.endif 


.if ( is_ac_run != 1 )  *** jgwei trans sim
	.param tStep	= 10.p
	.param tStop	= 5.u   		*  1.3u
	
	.tran tStep tSTOP 

	.probe tran v(bump_pwr_vdd_c) 	v(bump_pwr_vdd_d)	v(bump_pwr_vdd_h)
	.probe tran v(pin_vddc_meas_hf)  v(pin_vddc_meas_lf)	v(pin_vddd_meas_hf)  v(pin_vddd_meas_lf)
	
	.probe x(xblk_pkg.a_1)   x(xblk_pkg.a_2) 	x(xblk_pkg.a_3) 
	.probe x(xblk_pkg.a_4)   x(xblk_pkg.a_5) 	x(xblk_pkg.a_6) 
	.probe x(xblk_PCB.a_19)  x(xblk_PCB.a_39)

	* .param vdd_meas_start = 35.n
	* .param vdd_meas_end   = 5.u
	* .meas tran bump_pwr_vdd_c_p2p 	PP	V(bump_pwr_vdd_c)	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_c_vmax	MAX	V(bump_pwr_vdd_c)	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_c_vmin	MIN	V(bump_pwr_vdd_c)	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_c_vmax_t	WHEN	V(bump_pwr_vdd_c) = 'bump_pwr_vdd_c_vmax' 	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_c_vmin_t	WHEN	V(bump_pwr_vdd_c) = 'bump_pwr_vdd_c_vmin' 	from='vdd_meas_start' to='vdd_meas_end'

	* .meas tran bump_pwr_vdd_d_p2p 	PP	V(bump_pwr_vdd_d)	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_d_vmax	MAX	V(bump_pwr_vdd_d)	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_d_vmin	MIN	V(bump_pwr_vdd_d)	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_d_vmax_t	WHEN	V(bump_pwr_vdd_d) = 'bump_pwr_vdd_d_vmax' 	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_d_vmin_t	WHEN	V(bump_pwr_vdd_d) = 'bump_pwr_vdd_d_vmin' 	from='vdd_meas_start' to='vdd_meas_end'

	* .meas tran bump_pwr_vdd_h_p2p 	PP	V(bump_pwr_vdd_h)	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_h_vmax	MAX	V(bump_pwr_vdd_h)	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_h_vmin	MIN	V(bump_pwr_vdd_h)	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_h_vmax_t	WHEN	V(bump_pwr_vdd_h) = 'bump_pwr_vdd_h_vmax' 	from='vdd_meas_start' to='vdd_meas_end'
	* .meas tran bump_pwr_vdd_h_vmin_t	WHEN	V(bump_pwr_vdd_h) = 'bump_pwr_vdd_h_vmin' 	from='vdd_meas_start' to='vdd_meas_end'
	
.endif 