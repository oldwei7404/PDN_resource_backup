*** This test bench is to be use to simulate the self induced supply noise amplitude on this specific Protocol
*** Using *hspice*
**********************************************************************************************************

* Generic *hspice* testbench and settings
*.include 'hspice_analysis_AC.cfg'

* Synopsys top IP spice PI model
.include '../model/dwc_mipi_mphy_type1_pma_2tx_2rx_ns.sp'


* EXTERNAL VOLTAGE PARAMETERS
.PARAM xvph 			= 1.32
.PARAM xvp 			= 0.825
.PARAM xvptx 			= 'xvp'
.PARAM xvpdig 			= 'xvp'
.PARAM t_max_pwl_1024_UI        = 88n

* EXTERNAL VOLTAGE SOURCES
v_gnd gd gnd! dc=0
vph vph_supply gd dc='xvph' ac=0
vp vp_supply gd dc='xvp' ac=0


*=================================================================================
*  Capacitor model
*=================================================================================
.include '../CapLib/0603M_CapLib.ckt'
.include '../CapLib/1005M_CapLib.ckt'
.include '../CapLib/1608M_CapLib.ckt'
.include '../CapLib/2012M_CapLib.ckt'
.include '../CapLib/3216M_CapLib.ckt'

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
*x_pcb vp_ball vp_supply vph_ball vph_supply pcb
.include '../pcb/ACM2_PT00547399_A_01_PWR_cut_pcie_eth_usb_run3_v2_rmLF_manip.cir'
x_pcb 
 + soc_0p95v_eth_port 
 + soc_0p95v_pcie_port 
 + vp_ball 						*** soc_0p95v_ufs_port  
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
 + vp_supply							*** pmic_0p95v_port
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
 + vph_supply 							*** pmic_1p8v_HS_port 
 + pcbCap_C2553
 + pcbCap_C2559
 + pcbCap_C2586
 + pcbCap_C2631
 + pcbCap_C2694
 + pcbCap_C2717
 + pmic_1p8v_LS_pcie_port  
 + gd 
 + ACM2_PT00547399_A_01_PWR_cut_pcie_eth_usb_run3_v2_rmLF_manip
 
 *** PCB caps ***
 xpcbCap_C2525 pcbCap_C2525 gd 	str(mlcc_1uF_0402)
 xpcbCap_C2526 pcbCap_C2526 gd 	str(mlcc_1uF_0402)
 xpcbCap_C2510 pcbCap_C2510 gd 	str(mlcc_2p2uF_0603)
 xpcbCap_C2511 pcbCap_C2511 gd 	str(mlcc_2p2uF_0603)
 xpcbCap_C2692 pcbCap_C2692 gd 	str(mlcc_10uF_0402)
 xpcbCap_C2693 pcbCap_C2693 gd 	str(mlcc_10uF_0402)
 
 xpcbCap_C2556 pcbCap_C2556 gd 	str(mlcc_1uF_0402)
 xpcbCap_C2557 pcbCap_C2557 gd 	str(mlcc_1uF_0402)
 xpcbCap_C2584 pcbCap_C2584 gd 	str(mlcc_2p2uF_0603)
 xpcbCap_C2625 pcbCap_C2625 gd 	str(mlcc_2p2uF_0603)
 xpcbCap_C2690 pcbCap_C2690 gd 	str(mlcc_10uF_0402)
 xpcbCap_C2691 pcbCap_C2691 gd 	str(mlcc_10uF_0402)
 
*=================================================================================
*  pkg model
*=================================================================================
r_vp_die    vp_die    vp_die0 1p
r_vpdig_die vpdig_die vp_die0 1p
r_vptx0_die vptx0_die vp_die0 1p

r_vph_die1  vph_die1  vph_die0  1p
r_vph_die2  vph_die2  vph_die0  1p

*** jgwei change  
*.include '../pkg/pkg_C_none.inc'
*x_pkg vp_die0 vp_ball vph_die0 vph_ball  pkg

.include '../pkg/ZJC_5_PDN_SerDes_cut_only_UFS.cir'
xpkg 
 + vph_ball 
 + vp_ball 
 + vph_die0 
 + vp_die0 
 + pkgCap_132 
 + pkgCap_131 
 + gd 
 + ZJC_5_PDN_SerDes_cut_only_UFS

xpkgCap_C132 	pkgCap_132 	gd str(mlcc_0p1uF_0201)
xpkgCap_C131 	pkgCap_131 	gd str(mlcc_0p1uF_0201)

*=================================================================================
*  die model
*=================================================================================
x_pma vp_die vpdig_die vpdig_pg vph_die1 vph_die2 vptx0_die gd die_power_integrity_netlist 


*=================================================================================
*  additional probe
*=================================================================================
* .probe  I(x_pma.xlane*.Itx_ana_vph)
* .probe  I(x_pma.xlane*.Irx_ana_vph)
* .probe  I(x_pma.xlane*.Irx_ana_vp)
* .probe  I(x_pma.xlane*.Itx_ana_vpdig)
* .probe  I(x_pma.xlane*.Irx_ana_vpdig)
* .probe  I(x_pma.xlane*.Itx_ana_vptx)
* .probe  I(x_pma.xlane*.Ilane_dig_vpdig)

* .probe  I(x_pma.xsup.Isup_ana_vph)
* .probe  I(x_pma.xsup.Isup_ana_vp)
* .probe  I(x_pma.xsup.Isup_ana_vpdig)
* .probe  I(x_pma.xsup.Isup_dig_vpdig)



*** =====
.option post=1
*.chkanode type=gate dv=0.5*pvdd report=active
.option parhier = local 
.option measform = 1
.option lis_new
.option post probe

.param is_ac_run = 1

.if ( is_ac_run == 1 )  *** jgwei AC sim
	*** NOTE: DO not include port def if tran analysis later
	.if ( 1 )
		P1 vp_die0	gd	port=1	z0 = 0.1
		P2 vph_die0	gd	port=2	z0 = 0.1

		.lin 	sparcalc=1 	filename=impedance_plot	noisecalc=0 	gdcalc=0	format=touchstone 	dataformat=MA 
		.probe ac zin(1)(m) zin(1)(p) zin(2)(m) zin(2)(p) 
	.endif 
	
	*i_ac_vph0 vph_die0 gd dc=0 ac=1
	*.probe ac v(vph_die0)
	
	*i_ac_vp0  vp_die0  gd dc=0 ac=1
	*.probe ac v(vp_die0)

	.ac 	dec 50 1. 1.G
	
.endif 

.if ( is_ac_run != 1 )  *** jgwei trans sim


	.param tStep	= 10.p
	.param tStop	= 88.n

	.tran tStep tSTOP 

	.probe tran v(vp_die0) 	v(vph_die0)
	.probe x(xpkg.a_3)   x(xpkg.a_4) 


.endif 


