$$ Power integrity testbech:
$$ 1. Please replace sample_pcb_pkg subcircuit with your pcb and package model
$$ 2. Please adjust simulation time to catch low frequency noise based on AC response for your pck_pkg model

$$ Supply
.param	xvdd = '1.1*0.75'
.param	xvp  = '1.1*0.75'
.param	xvph = '1.1*1.2'

v_vph	vph_in	0	dc='xvph'
v_vp	vp_in	0	dc='xvp'
v_vdd	vdd_in	0	dc='xvdd'


*=================================================================================
*  Capacitor model
*=================================================================================
* .include '../CapLib/0603M_CapLib.ckt'
* .include '../CapLib/1005M_CapLib.ckt'
* .include '../CapLib/1608M_CapLib.ckt'
* .include '../CapLib/2012M_CapLib.ckt'
* .include '../CapLib/3216M_CapLib.ckt'

***** filter models 
.inc   /data/home/jiangongwei/work/models_cap/BLM18SN220TH1.mod
.param ferrite_mod1 = str('BLM18SN220TH1')

.subckt model_filter
+ pin_pwr_L pin_pwr_C ref_gnd 

 Xfilter			** NOTE: this filter is added to isolate VDDC from VDDD
  + pin_pwr_L		*** PMIC side 
  + pin_pwr_C		*** SoC side
  + str(ferrite_mod1)
 C1 	pin_pwr_C 	ref_gnd	 	47.u
 C2		pin_pwr_C	ref_gnd		1.u
 C3   	pin_pwr_C	ref_gnd		0.1u
 
 XfilterCap_1	pin_pwr_2 	ref_gnd	str(mlcc_47uF_1206)
 XfilterCap_2	pin_pwr_2 	ref_gnd	str(mlcc_1uF_0201)
 XfilterCap_3	pin_pwr_2 	ref_gnd	str(mlcc_0p1uF_0201)
.ends 

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
.inc /data/home/jiangongwei/work/models_cap/GCM188R70J225KE22_DC0V_125degC_0603_2.2uF.mod
.inc /data/home/jiangongwei/work/models_cap/mlcc_470uF_mockup_T598D477M2R5ATE009.mod
.inc /data/home/jiangongwei/work/models_cap/open_circuit.mod

.param mlcc_1uF_0402 		= str('GCM155C71A105KE38_DC0V_125degC_0402_1uF')
.param mlcc_1uF_0204 		= str('LLC152D70G105ME01_DC0V_125degC_0204_1uF')
.param mlcc_1uF_0201 		= str('GCM033D70E105ME36_DC0V_125degC_0201_1uF')
.param mlcc_1uF_0402_3T		= str('NFM15HC105D0G3_feedthrough_DC0V_85degC_3T_0402_1uF')
.param mlcc_2p2uF_0603		= str('GCM188R70J225KE22_DC0V_125degC')
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

*=================================================================================
*  pcb model
*=================================================================================
*.include '../pcb/pcb_C_none.inc'
*x_pcb vdd_ball vdd_in vp_ball vp_in vph_ball vph_in pcb

.include '../pcb/ACM2_PT00547399_A_01_PWR_cut_pcie_eth_usb_run3_v2_rmLF_manip.cir'
x_pcb 
 + soc_0p95v_eth_port 
 + soc_0p95v_pcie_port 
 + vdd_vp_ball 					*** soc_0p95v_ufs_port  
 + soc_1p8v_eth_port 
 + vph_ball 					*** soc_1p8v_ufs_port 
 + soc_1p8v_pcie_port
 + pcbCap_C2519
 + pcbCap_C2546
 + pcbCap_C2575
 + pcbCap_C2580
 + pcbCap_C2710
 + pcbCap_C2711
 + pcbCap_C2510
 + pcbCap_C2511
 + pcbCap_C2525
 + pcbCap_C2526
 + pcbCap_C2692
 + pcbCap_C2693
 + pcbCap_C2520
 + pcbCap_C2521
 + pcbCap_C2550
 + pcbCap_C2551
 + pcbCap_C2604
 + pcbCap_C2605
 + vp_in							*** pmic_0p95v_port
 + pcbCap_C2556
 + pcbCap_C2557
 + pcbCap_C2562
 + pcbCap_C2565
 + pcbCap_C2577
 + pcbCap_C2584
 + pcbCap_C2625
 + pcbCap_C2690
 + pcbCap_C2691
 + pcbCap_C2697
 + pcbCap_C2713
 + pcbCap_C2736
 + vph_in 							*** pmic_1p8v_HS_port 
 + pcbCap_C2553
 + pcbCap_C2559
 + pcbCap_C2586
 + pcbCap_C2631
 + pcbCap_C2694
 + pcbCap_C2717
 + pmic_1p8v_LS_pcie_port  
 + 0 
 + ACM2_PT00547399_A_01_PWR_cut_pcie_eth_usb_run3_v2_rmLF_manip
 
 *** PCB caps ***
 xpcbCap_C2525 pcbCap_C2525 0 	str(mlcc_1uF_0402)
 xpcbCap_C2526 pcbCap_C2526 0 	str(mlcc_1uF_0402)
 xpcbCap_C2510 pcbCap_C2510 0 	str(mlcc_2p2uF_0603)
 xpcbCap_C2511 pcbCap_C2511 0 	str(mlcc_2p2uF_0603)
 xpcbCap_C2692 pcbCap_C2692 0 	str(mlcc_10uF_0402)
 xpcbCap_C2693 pcbCap_C2693 0 	str(mlcc_10uF_0402)
 
 xpcbCap_C2556 pcbCap_C2556 0 	str(mlcc_1uF_0402)
 xpcbCap_C2557 pcbCap_C2557 0 	str(mlcc_1uF_0402)
 xpcbCap_C2584 pcbCap_C2584 0 	str(mlcc_2p2uF_0603)
 xpcbCap_C2625 pcbCap_C2625 0 	str(mlcc_2p2uF_0603)
 xpcbCap_C2690 pcbCap_C2690 0 	str(mlcc_10uF_0402)
 xpcbCap_C2691 pcbCap_C2691 0 	str(mlcc_10uF_0402)


*=================================================================================
*  pkg model
*=================================================================================
*r_vdd_vp_short  vdd_die  vp_vdd_die  1p
* r_vdd_vp_short2 vp_die   vp_vdd_die  1p   ** now vp_die needs to be replaced by vp_vdd_die, after vdd_die is merged


* .include '../pkg/pkg_C_none.inc'
* x_pkg vdd_die vdd_ball vp_die vp_ball vph_die vph_ball  pkg

*======
* .include '../pkg/ZJC_5_PDN_SerDes_cut_only_MIPI_IdEM.cir'
* xpkg 
* + vph_ball 
* + vp_ball
* + vph23_ball 
* + vp23_ball 
* + vph45_ball 
* + vp45_ball
* + vph67_ball 
* + vp67_ball
* + vph_die
* + vp_die		*vp_vdd_die
* + vph23_die
* + vp23_die
* + vph45_die
* + vp45_die
* + vph67_die
* + vp67_die 
* + pkgCap_01_VPH_C119
* + pkgCap_01_VP_C125
* + pkgCap_23_VPH_C126
* + pkgCap_23_VP_C121
* + pkgCap_45_VPH_C120
* + pkgCap_45_VP_C122
* + pkgCap_67_VPH_C128
* + pkgCap_67_VP_C127
* + 0 
* + ZJC_5_PDN_SerDes_cut_only_MIPI_IdEM

* xpkgCap_01_VPH_C119 	pkgCap_01_VPH_C119	0 	str(mlcc_0p1uF_0201)
* xpkgCap_01_VP_C125 		pkgCap_01_VP_C125	0 	str(mlcc_0p1uF_0201)
 
 *======
 .include '../pkg/Mam_MCM_L12_BH9_Ballv0p81.cir'
 xpkg 
 + vp_die 	*** NOTE: vp_01 
 + vph_die 	*** NOTE: vph_01
 + vdd_die 	*** NOTE: vdd_01
 + vp_die_45
 + vph_die_45
 + vdd_die_45
 + vp_ball
 + vph_ball
 + vdd_ball
 + vp_ball_45
 + vph_ball_45
 + vdd_ball_45
 + pkgCap_01_VP_C119
 + pkgCap_01_VP_C126
 + pkgCap_01_VPH_C121
 + pkgCap_01_VDD_C125
 + pkgCap_45_VP_C120
 + pkgCap_45_VP_C128
 + pkgCap_45_VPH_C127
 + pkgCap_45_VDD_C122 
 + ref_gnd 
 + Mam_MCM_L12_BH9_Ballv0p81
 
 xpkgCap_01_VP_C119		pkgCap_01_VP_C119	0	str(mlcc_0p1uF_0201)
 xpkgCap_01_VP_C126		pkgCap_01_VP_C126	0	str(mlcc_0p1uF_0201)
 xpkgCap_01_VPH_C121	pkgCap_01_VPH_C121	0	str(mlcc_0p1uF_0201)
 xpkgCap_01_VDD_C125	pkgCap_01_VDD_C125	0	str(mlcc_0p1uF_0201)

 xpkgCap_45_VP_C120		pkgCap_45_VP_C120	0	str(mlcc_0p1uF_0201)
 xpkgCap_45_VP_C128		pkgCap_45_VP_C128	0	str(mlcc_0p1uF_0201)
 xpkgCap_45_VPH_C127	pkgCap_45_VPH_C127	0	str(mlcc_0p1uF_0201)
 xpkgCap_45_VDD_C122	pkgCap_45_VDD_C122	0	str(mlcc_0p1uF_0201)

.param use_filter = 1
	***** add filter to isolate xtalk from vp to vdd 
 .if (use_filter == 1) 
	 xModel_filter_vdd01
	 + vdd_vp_ball
	 + vdd_ball
	 + ref_gnd
	 + model_filter
	 
	 xModel_filter_vdd45
	 + vdd_vp_ball
	 + vdd_ball_45
	 + ref_gnd
	 + model_filter
	 
 .endif 
 .if (use_filter != 1) 
	 r_vdd_ball_pcb_short1	vdd_ball	vdd_vp_ball		1.n			*** NOTE: short vdd/vp 
	 r_vdd_ball_pcb_short3	vdd_ball_45	vdd_vp_ball		1.n			*** NOTE: short vdd/vp 
 .endif 
 
 r_vdd_ball_pcb_short2	vp_ball		vdd_vp_ball		1.n			*** NOTE: short vdd/vp
 r_vdd_ball_pcb_short4	vp_ball_45	vdd_vp_ball		1.n			*** NOTE: short vdd/vp 
 
 r_vph_ball_pcb_short1 vph_ball_45 	vph_ball  	1.n 
 
*=================================================================================
*  die model
*=================================================================================
***** IP model for Power Integrity analysis
.include '../model_15M_1X_h_1Xb_v_1Xe_h_1Ya_v_1Yb_h_5Y_vhvhv_2Yy2R/dwc_mipi_cdphy2_core_rx_2l2t_ns.sp'                      
xdwc_mipi_cdphy_2l2t_ns_ln0 
 + vdd_die 
 + vp_die 
 + vph_die
 + dwc_mipi_cdphy2_core_rx_2l2t_ns_cphy_4g5_inc
 + time_delay_dig = 0.		
 + time_delay_vdd = 0.
 + time_delay_vp  = 0.
 + time_delay_vph = 0. 

              
xdwc_mipi_cdphy_2l2t_ns_ln1
 + vdd_die 
 + vp_die 
 + vph_die
 + dwc_mipi_cdphy2_core_rx_2l2t_ns_cphy_4g5_inc
 + time_delay_dig = 0.		
 + time_delay_vdd = 0.
 + time_delay_vp  = 0.
 + time_delay_vph = 0. 

xdwc_mipi_cdphy_2l2t_ns_ln4
 + vdd_die_45 
 + vp_die_45 
 + vph_die_45
 + dwc_mipi_cdphy2_core_rx_2l2t_ns_cphy_4g5_inc
 + time_delay_dig = 0.		
 + time_delay_vdd = 0.
 + time_delay_vp  = 0.
 + time_delay_vph = 0. 
 
xdwc_mipi_cdphy_2l2t_ns_ln5
 + vdd_die_45 
 + vp_die_45 
 + vph_die_45
 + dwc_mipi_cdphy2_core_rx_2l2t_ns_cphy_4g5_inc
 + time_delay_dig = 0.		
 + time_delay_vdd = 0.
 + time_delay_vp  = 0.
 + time_delay_vph = 0. 
 
*** =====
.option post=1
.option parhier = local 
.option measform = 1
.option lis_new
.option post probe

.param is_ac_run = 0

.if ( is_ac_run == 1 )  *** jgwei AC sim
	*** NOTE: DO not include port def if tran analysis later
	.if ( 0 )
		P1 vp_die		0	port=1	z0 = 0.1
		P2 vph_die	    0	port=2	z0 = 0.1

		.lin 	sparcalc=1 	filename=impedance_plot	noisecalc=0 	gdcalc=0	format=touchstone 	dataformat=MA 
		.probe ac zin(1)(m) zin(1)(p) zin(2)(m) zin(2)(p) 
	.endif
	
	i_ac_vp_vdd_die vp_die 0 dc=0 ac=1
	.probe ac v(vp_die)
	
	*i_ac_vph_die    vph_die    0 dc=0 ac=1		
	*.probe ac v(vph_die)

	*i_ac_vp_vdd_die vdd_die 0 dc=0 ac=1
	*.probe ac v(vdd_die)
	
	.ac 	dec 50 1. 1.G
	
.endif 

.if ( is_ac_run != 1 )  *** jgwei trans sim


	.param tStep	= 10.p
	.param tStop	= 6.u

	.tran tStep tSTOP 

	.probe tran v(vdd_die)  v(vp_die) 	v(vph_die)	
	.probe tran v(vdd_die_45)  v(vp_die_45) 	v(vph_die_45)
	
	*.probe x(xpkg.a_9)   x(xpkg.a_10) 
	.probe x(xpkg.a_1)   x(xpkg.a_2) 	x(xpkg.a_3)
	.probe x(xpkg.a_4)   x(xpkg.a_5) 	x(xpkg.a_6)


$$ Start/end points for selected transient measures
.param sim_time = 6.u
.param ringing_period_exclude = 0

.param vdd_meas_start = 0
.param vdd_meas_end = sim_time
.param ana_burst_start = 0.4754u     	
.param ana_burst_end = 0.6441u

$$ TR measures on die p2p
.meas tran vdd_die_p2p 		PP	V(vdd_die)	from='vdd_meas_start' to='vdd_meas_end'
.meas tran vp_die_p2p  		PP	V(vp_die)	from='ringing_period_exclude' to='sim_time'
.meas tran vph_die_p2p 		PP	V(vph_die)	from='ringing_period_exclude' to='sim_time'

.meas tran p2p_vdd		PARAM='(vdd_die_p2p/xvdd)*100'
.meas tran p2p_vp		PARAM='(vp_die_p2p/xvp)*100'
.meas tran p2p_vph		PARAM='(vph_die_p2p/xvph)*100'

.meas tran hsonly_vp_die_p2p  	PP	V(vp_die)	from='ana_burst_start' to='ana_burst_end'
.meas tran hsonly_vph_die_p2p 	PP	V(vph_die)	from='ana_burst_start' to='ana_burst_end'

.meas tran hsonly_p2p_vp	PARAM='(hsonly_vp_die_p2p/xvp)*100'
.meas tran hsonly_p2p_vph	PARAM='(hsonly_vph_die_p2p/xvph)*100'

.meas tran vp_min MIN V(vp_die)	from='ringing_period_exclude' to='sim_time'
.meas tran vp_min_marg PARAM='vp_min-0.87*0.8'
.meas tran hsonly_vp_min MIN V(vp_die)	from='ana_burst_start' to='ana_burst_end'
.meas tran hsonly_vp_min_marg PARAM='hsonly_vp_min-0.87*0.75'



.endif 
