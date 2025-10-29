oProject = oApp.GetActiveProject()
oDoc = oProject.GetActiveDesign()


pins=[]
nets=[]
# oDoc.ScrGetPinsOnPart('RefDesFix__3', 'DIE130_103124', pins, nets)
# oDoc.ScrGetPinsOnPart('DIE130_103124', 'DIE130_103124', pins, nets)
oDoc.ScrGetPinsOnPart('DIEDIE', 'DIEDIE', pins, nets)

pins_VDD=[]
pins_VSS=[]
len_pins = len(pins)

for idx in range(len_pins):
	entry = nets[idx]
	if entry == 'VDD075NNE':
		pins_VDD.append(pins[idx])
	elif entry == 'VSS':
		pins_VSS.append(pins[idx])
		
print(len(pins))
print(len(pins_VDD))

midpt_VDD = len(pins_VDD) 
pins_VDD = pins_VDD[:midpt_VDD]

midpt_VSS = len(pins_VSS) 
pins_VSS = pins_VSS[:midpt_VSS]

print('VDD pin count: ', len(pins_VDD))
print('VSS pin count: ', len(pins_VSS))

len_pin_VDD = len(pins_VDD)



# read in current profile 
filename_vdd = 'per_bump_curr_NNE_VDD.csv' 

curr_vdd_bump_name = []
curr_vdd_bump_curr = []

fin = open(filename_vdd, 'r')
cln_str = fin.readline()  
while cln_str:
	cln_str = cln_str.split(',')
	
	curr_vdd_bump_name.append(cln_str[0])
	curr_vdd_bump_curr.append(float(cln_str[1]))
	cln_str = fin.readline()  
fin.close()

print('VDD pin current read in: ', len(curr_vdd_bump_curr) )


#filename_vss = 'per_bump_curr_NNE_VSS.csv' 
#
#curr_vss_bump_name = []
#curr_vss_bump_curr = []
#
#fin = open(filename_vss, 'r')
#cln_str = fin.readline()  
#while cln_str:
#   cln_str = cln_str.split(',')
#
# curr_vss_bump_name.append(cln_str[0])
# curr_vss_bump_curr.append(float(cln_str[1]))
# cln_str = fin.readline()  
#fin.close()
#
#print('VSS pin current read in: ', len(curr_vss_bump_curr) )

### set current sources 

    ### read VDD/VSS pair 
filename_pair = 'bump_curr_bump_out.csv' 
bump_pair_dict = {}

fin = open(filename_pair, 'r')
cln_str = fin.readline()  
while cln_str:
	cln_str = cln_str.split(',')
	bump_target   = cln_str[0].lstrip(' ').rstrip(' ')
	bump_pair_fnd = cln_str[1].lstrip(' ').rstrip(' ').rstrip('\n')
	bump_pair_dict[bump_target] = bump_pair_fnd
	cln_str = fin.readline()  
fin.close()

    ### add current srcs 
for idx in range(len_pin_VDD):
	currSrc_bump_pwr = pins_VDD[idx]
	currSrc_bump_srcNum = 'currSrcBump_'+str(idx)
	try: 
		idx_fnd = curr_vdd_bump_name.index(currSrc_bump_pwr)
		curr_val = curr_vdd_bump_curr[idx_fnd]
		bump_pair_fnd = bump_pair_dict[currSrc_bump_pwr]
		print('### INFO: Adding current source idx:',idx,  currSrc_bump_pwr, bump_pair_fnd, curr_val)
        ### neg terminal is per bump
		# oDoc.ScrPlaceCircuitElement(currSrc_bump_srcNum, 'currSrcBump', 4, 0, 'RefDesFix__3', 'DIE130_103124', currSrc_bump_pwr, 0, 'RefDesFix__3', 'DIE130_103124', bump_pair_fnd , 0., 0., 5.e7, 0., curr_val, 0.)
        # oDoc.ScrPlaceCircuitElement(currSrc_bump_srcNum, 'currSrcBump', 4, 0, 'DIE130_103124', 'DIE130_103124', currSrc_bump_pwr, 0, 'DIE130_103124', 'DIE130_103124', bump_pair_fnd , 0., 0., 5.e7, 0., curr_val, 0.)
        oDoc.ScrPlaceCircuitElement(currSrc_bump_srcNum, 'currSrcBump', 4, 0, 'DIEDIE', 'DIEDIE', currSrc_bump_pwr, 0, 'DIEDIE', 'DIEDIE', bump_pair_fnd , 0., 0., 5.e7, 0., curr_val, 0.)
        
        ### neg terminal is VSS pin grp 
        # oDoc.ScrPlaceCircuitElement(currSrc_bump_srcNum, 'currSrcBump', 4, 0, 'RefDesFix__3', 'DIE130_103124', currSrc_bump_pwr, 1, 'RefDesFix__3', 'DIE130_103124', 'DIE130_103124_VSS_Group', 0., 0., 5.e7, 0., curr_val, 0.)
        
	except ValueError: 
		print('### warning fail to find current for bump:', currSrc_bump_pwr)


    ### add voltage probes 
for idx in range(len_pin_VDD):
	currSrc_bump_pwr = pins_VDD[idx]
	currSrc_bump_srcNum = 'vprobe_'+str(idx)
	try: 
		idx_fnd = curr_vdd_bump_name.index(currSrc_bump_pwr)
		# curr_val = curr_vdd_bump_curr[idx_fnd]
		bump_pair_fnd = bump_pair_dict[currSrc_bump_pwr]
		print('### INFO: Adding probe idx ',idx,  currSrc_bump_pwr, bump_pair_fnd)
		# oDoc.ScrPlaceCircuitElement(currSrc_bump_srcNum, 'currSrcBump', 6, 0, 'RefDesFix__3', 'DIE130_103124', currSrc_bump_pwr, 0, 'RefDesFix__3', 'DIE130_103124', bump_pair_fnd , 0., 0., 0., 0., 0., 0.)
        # oDoc.ScrPlaceCircuitElement(currSrc_bump_srcNum, 'currSrcBump', 6, 0, 'DIE130_103124', 'DIE130_103124', currSrc_bump_pwr, 0, 'DIE130_103124', 'DIE130_103124', bump_pair_fnd , 0., 0., 0., 0., 0., 0.)
        oDoc.ScrPlaceCircuitElement(currSrc_bump_srcNum, 'currSrcBump', 6, 0, 'DIEDIE', 'DIEDIE', currSrc_bump_pwr, 0, 'DIEDIE', 'DIEDIE', bump_pair_fnd , 0., 0., 0., 0., 0., 0.)
        

	except ValueError: 
		print('### warning fail to add for bump:', currSrc_bump_pwr)


### export voltage probe 
oDoc.ScrExportVprobeData('DCIRSimPerBump_wBGA', 'C:\SIM_folder\Ecap_study\B0_pkg_DCIR_per_bump\per_bump_vprobe.vpb')










*oDoc.ScrPlaceCircuitElement('currSrcBump_2', 'currSrcBump', 4, 0, 'RefDesFix__3', 'DIE130_103124', 'AU2', 1, 'RefDesFix__3', 'DIE130_103124', 'DIE130_103124_VSS_Group', 0., 0., 0., 0., 1.5, 0.)

*oDoc.ScrPlaceCircuitElement('currSrcBump_1', 'currSrcBump', 4, 0, 'RefDesFix__3', 'DIE130_103124', 'AU2', 0, 'RefDesFix__3', 'DIE130_103124', 'AY6', 0., 0., 0., 0., 1.5, 0.)

* currSrcName = 'currSrcPerBump_1'
* oDoc.ScrPlaceCircuitElementsToNearestRefPin(4, 1.5, 'RefDesFix__3', 'DIE130_103124', 'AK1',  )


* currSrc= oDoc.ScrGetActiveComponentList('Current Sources')
* tmp=oDoc.ScrGetActiveComponentList('Voltage Sources')
* print(tmp)

oDoc.ScrPlaceCircuitElement


###
oProject = oApp.GetActiveProject()
oDoc = oProject.GetActiveDesign()

for idx in range(len_pin_VDD):
    currSrc_bump_pwr = pins_VDD[idx]
    currSrc_bump_srcNum = 'currSrcBump_'+str(idx)
    idx_fnd = curr_vdd_bump_name.index(currSrc_bump_pwr)
    curr_val = curr_vdd_bump_curr[idx_fnd]
    bump_pair_fnd = bump_pair_dict[currSrc_bump_pwr]
    print('### INFO: Adding current source #', idx, currSrc_bump_pwr, bump_pair_fnd, curr_val)
    oDoc.ScrPlaceCircuitElement(currSrc_bump_srcNum, 'currSrcBump', 4, 0, 'DIEDIE', 'DIEDIE', currSrc_bump_pwr, 0, 'DIEDIE', 'DIEDIE', bump_pair_fnd , 0., 0., 5.e7, 0., curr_val, 0.)
   
   
   
for idx in range(len_pin_VDD):
    currSrc_bump_pwr = pins_VDD[idx]
    currSrc_bump_srcNum = 'vprobe_'+str(idx)
    idx_fnd = curr_vdd_bump_name.index(currSrc_bump_pwr)
    bump_pair_fnd = bump_pair_dict[currSrc_bump_pwr]
    print('### INFO: Adding #', idx, currSrc_bump_pwr, bump_pair_fnd)
    oDoc.ScrPlaceCircuitElement(currSrc_bump_srcNum, 'currSrcBump', 6, 0, 'DIEDIE', 'DIEDIE', currSrc_bump_pwr, 0, 'DIEDIE', 'DIEDIE', bump_pair_fnd , 0., 0., 0., 0., 0., 0.)


### manually added 64 partition curr, 251027

oDoc.ScrPlaceCircuitElement('currScr_0_1', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_1_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_1_VSS' , 0., 0., 5.e7, 0., 4.37, 0.)
oDoc.ScrPlaceCircuitElement('currScr_0_2', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_2_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_2_VSS' , 0., 0., 5.e7, 0., 3.46, 0.)
oDoc.ScrPlaceCircuitElement('currScr_0_3', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_3_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_3_VSS' , 0., 0., 5.e7, 0., 3.96, 0.)
oDoc.ScrPlaceCircuitElement('currScr_0_4', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_4_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_4_VSS' , 0., 0., 5.e7, 0., 6.09, 0.)
oDoc.ScrPlaceCircuitElement('currScr_0_5', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_5_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_5_VSS' , 0., 0., 5.e7, 0., 8.17, 0.)
oDoc.ScrPlaceCircuitElement('currScr_0_6', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_6_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_6_VSS' , 0., 0., 5.e7, 0., 7.15, 0.)
oDoc.ScrPlaceCircuitElement('currScr_0_7', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_7_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_0_7_VSS' , 0., 0., 5.e7, 0., 5.64, 0.)

oDoc.ScrPlaceCircuitElement('currScr_1_1', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_1_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_1_VSS' , 0., 0., 5.e7, 0., 3.98, 0.)
oDoc.ScrPlaceCircuitElement('currScr_1_2', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_2_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_2_VSS' , 0., 0., 5.e7, 0., 3.05, 0.)
oDoc.ScrPlaceCircuitElement('currScr_1_3', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_3_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_3_VSS' , 0., 0., 5.e7, 0., 3.56, 0.)
oDoc.ScrPlaceCircuitElement('currScr_1_4', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_4_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_4_VSS' , 0., 0., 5.e7, 0., 5.74, 0.)
oDoc.ScrPlaceCircuitElement('currScr_1_5', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_5_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_5_VSS' , 0., 0., 5.e7, 0., 7.31, 0.)
oDoc.ScrPlaceCircuitElement('currScr_1_6', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_6_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_6_VSS' , 0., 0., 5.e7, 0., 6.41, 0.)
oDoc.ScrPlaceCircuitElement('currScr_1_7', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_7_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_1_7_VSS' , 0., 0., 5.e7, 0., 5.08, 0.)

oDoc.ScrPlaceCircuitElement('currScr_2_1', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_1_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_1_VSS' , 0., 0., 5.e7, 0., 3.96, 0.)
oDoc.ScrPlaceCircuitElement('currScr_2_2', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_2_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_2_VSS' , 0., 0., 5.e7, 0., 3.15, 0.)
oDoc.ScrPlaceCircuitElement('currScr_2_3', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_3_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_3_VSS' , 0., 0., 5.e7, 0., 3.65, 0.)
oDoc.ScrPlaceCircuitElement('currScr_2_4', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_4_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_4_VSS' , 0., 0., 5.e7, 0., 5.66, 0.)
oDoc.ScrPlaceCircuitElement('currScr_2_5', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_5_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_5_VSS' , 0., 0., 5.e7, 0., 7.21, 0.)
oDoc.ScrPlaceCircuitElement('currScr_2_6', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_6_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_6_VSS' , 0., 0., 5.e7, 0., 6.47, 0.)
oDoc.ScrPlaceCircuitElement('currScr_2_7', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_7_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_2_7_VSS' , 0., 0., 5.e7, 0., 5.10, 0.)

oDoc.ScrPlaceCircuitElement('currScr_3_1', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_1_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_1_VSS' , 0., 0., 5.e7, 0., 3.81, 0.)
oDoc.ScrPlaceCircuitElement('currScr_3_2', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_2_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_2_VSS' , 0., 0., 5.e7, 0., 3.05, 0.)
oDoc.ScrPlaceCircuitElement('currScr_3_3', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_3_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_3_VSS' , 0., 0., 5.e7, 0., 3.46, 0.)
oDoc.ScrPlaceCircuitElement('currScr_3_4', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_4_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_4_VSS' , 0., 0., 5.e7, 0., 5.24, 0.)
oDoc.ScrPlaceCircuitElement('currScr_3_5', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_5_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_5_VSS' , 0., 0., 5.e7, 0., 6.58, 0.)
oDoc.ScrPlaceCircuitElement('currScr_3_6', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_6_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_6_VSS' , 0., 0., 5.e7, 0., 5.98, 0.)
oDoc.ScrPlaceCircuitElement('currScr_3_7', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_7_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_3_7_VSS' , 0., 0., 5.e7, 0., 4.73, 0.)

oDoc.ScrPlaceCircuitElement('currScr_4_1', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_1_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_1_VSS' , 0., 0., 5.e7, 0., 3.91, 0.)
oDoc.ScrPlaceCircuitElement('currScr_4_2', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_2_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_2_VSS' , 0., 0., 5.e7, 0., 2.81, 0.)
oDoc.ScrPlaceCircuitElement('currScr_4_3', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_3_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_3_VSS' , 0., 0., 5.e7, 0., 3.38, 0.)
oDoc.ScrPlaceCircuitElement('currScr_4_4', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_4_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_4_VSS' , 0., 0., 5.e7, 0., 5.71, 0.)
oDoc.ScrPlaceCircuitElement('currScr_4_5', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_5_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_5_VSS' , 0., 0., 5.e7, 0., 7.65, 0.)
oDoc.ScrPlaceCircuitElement('currScr_4_6', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_6_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_6_VSS' , 0., 0., 5.e7, 0., 6.72, 0.)
oDoc.ScrPlaceCircuitElement('currScr_4_7', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_7_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_4_7_VSS' , 0., 0., 5.e7, 0., 5.18, 0.)

oDoc.ScrPlaceCircuitElement('currScr_5_1', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_1_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_1_VSS' , 0., 0., 5.e7, 0., 4.04, 0.)
oDoc.ScrPlaceCircuitElement('currScr_5_2', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_2_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_2_VSS' , 0., 0., 5.e7, 0., 3.00, 0.)
oDoc.ScrPlaceCircuitElement('currScr_5_3', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_3_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_3_VSS' , 0., 0., 5.e7, 0., 3.54, 0.)
oDoc.ScrPlaceCircuitElement('currScr_5_4', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_4_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_4_VSS' , 0., 0., 5.e7, 0., 5.71, 0.)
oDoc.ScrPlaceCircuitElement('currScr_5_5', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_5_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_5_VSS' , 0., 0., 5.e7, 0., 7.25, 0.)
oDoc.ScrPlaceCircuitElement('currScr_5_6', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_6_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_6_VSS' , 0., 0., 5.e7, 0., 6.52, 0.)
oDoc.ScrPlaceCircuitElement('currScr_5_7', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_7_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_5_7_VSS' , 0., 0., 5.e7, 0., 5.12, 0.)

oDoc.ScrPlaceCircuitElement('currScr_6_0', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_0_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_0_VSS' , 0., 0., 5.e7, 0., 0.36, 0.)
oDoc.ScrPlaceCircuitElement('currScr_6_1', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_1_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_1_VSS' , 0., 0., 5.e7, 0., 3.98, 0.)
oDoc.ScrPlaceCircuitElement('currScr_6_2', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_2_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_2_VSS' , 0., 0., 5.e7, 0., 3.27, 0.)
oDoc.ScrPlaceCircuitElement('currScr_6_3', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_3_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_3_VSS' , 0., 0., 5.e7, 0., 3.74, 0.)
oDoc.ScrPlaceCircuitElement('currScr_6_4', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_4_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_4_VSS' , 0., 0., 5.e7, 0., 5.64, 0.)
oDoc.ScrPlaceCircuitElement('currScr_6_5', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_5_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_5_VSS' , 0., 0., 5.e7, 0., 7.01, 0.)
oDoc.ScrPlaceCircuitElement('currScr_6_6', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_6_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_6_VSS' , 0., 0., 5.e7, 0., 6.36, 0.)
oDoc.ScrPlaceCircuitElement('currScr_6_7', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_7_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_6_7_VSS' , 0., 0., 5.e7, 0., 5.10, 0.)

oDoc.ScrPlaceCircuitElement('currScr_7_0', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_0_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_0_VSS' , 0., 0., 5.e7, 0., 0.96, 0.)
oDoc.ScrPlaceCircuitElement('currScr_7_1', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_1_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_1_VSS' , 0., 0., 5.e7, 0., 3.41, 0.)
oDoc.ScrPlaceCircuitElement('currScr_7_2', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_2_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_2_VSS' , 0., 0., 5.e7, 0., 2.69, 0.)
oDoc.ScrPlaceCircuitElement('currScr_7_3', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_3_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_3_VSS' , 0., 0., 5.e7, 0., 3.11, 0.)
oDoc.ScrPlaceCircuitElement('currScr_7_4', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_4_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_4_VSS' , 0., 0., 5.e7, 0., 4.78, 0.)
oDoc.ScrPlaceCircuitElement('currScr_7_5', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_5_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_5_VSS' , 0., 0., 5.e7, 0., 6.20, 0.)
oDoc.ScrPlaceCircuitElement('currScr_7_6', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_6_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_6_VSS' , 0., 0., 5.e7, 0., 5.50, 0.)
oDoc.ScrPlaceCircuitElement('currScr_7_7', 'currSrcBump', 4, 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_7_VDD075NNE', 1, 'RefDesFix__3', 'DIE130_103124', 'PAR_7_7_VSS' , 0., 0., 5.e7, 0., 4.28, 0.)



### create ports for BGA inside NNE die shadow 

for idx1 in range (0, 8):
    for idx2 in range (0, 4):
        oDoc.ScrPlaceCircuitElement('BGA_port_'+str(idx1)+'_'+str(idx2) , 'BGA_port', 3, 1, 'RefDesFix__9', 'BGA', 'BGA_GRP_'+str(idx1)+'_'+str(idx2)+'_VDD075NNE', 1, 'RefDesFix__9', 'BGA', 'BGA_GRP_'+str(idx1)+'_'+str(idx2)+'_VSS' , 0., 0., 0.0, 0.1, 0., 0.)

### create ports for BGA outside NNE die shadow 
for idx1 in range (0, 2):
    for idx2 in range (1, 4):
        oDoc.ScrPlaceCircuitElement('BGA_port_'+str(idx1)+'_'+str(idx2)+'_Out' , 'BGA_port_Out', 3, 1, 'RefDesFix__9', 'BGA', 'BGA_GRP_'+str(idx1)+'_'+str(idx2)+'_VDD075NNE_1', 1, 'RefDesFix__9', 'BGA', 'BGA_GRP_'+str(idx1)+'_'+str(idx2)+'_VSS_1' , 0., 0., 0.0, 0.1, 0., 0.)

for idx1 in range (0, 2):
    for idx2 in range (4, 5):
        oDoc.ScrPlaceCircuitElement('BGA_port_'+str(idx1)+'_'+str(idx2)+'_Out' , 'BGA_port_Out', 3, 1, 'RefDesFix__9', 'BGA', 'BGA_GRP_'+str(idx1)+'_'+str(idx2)+'_VDD075NNE', 1, 'RefDesFix__9', 'BGA', 'BGA_GRP_'+str(idx1)+'_'+str(idx2)+'_VSS' , 0., 0., 0.0, 0.1, 0., 0.)



###
for idx1 in range (1, 9):
    for idx2 in range (0, 4):
        oDoc.ScrPlaceCircuitElement('BGA_port_'+str(idx1)+'_'+str(idx2) , 'BGA_port', 3, 1, 'BGA_RAP1', 'U14', 'U14_GRP_'+str(idx1)+'_'+str(idx2)+'_MAM_NNE_VDD', 1, 'BGA_RAP1', 'U14', 'U14_GRP_'+str(idx1)+'_'+str(idx2)+'_GND' , 0., 0., 0.0, 0.1, 0., 0.)

### create ports for BGA outside NNE die shadow 

for idx1 in range (0, 2):
    for idx2 in range (1, 4):
        oDoc.ScrPlaceCircuitElement('BGA_port_'+str(idx1)+'_'+str(idx2)+'_Out' , 'BGA_port_Out', 3, 1, 'BGA_RAP1', 'U14', 'U14_GRP_'+str(idx1)+'_'+str(idx2)+'_MAM_NNE_VDD_1', 1, 'BGA_RAP1', 'U14', 'U14_GRP_'+str(idx1)+'_'+str(idx2)+'_GND_1' , 0., 0., 0.0, 0.1, 0., 0.)

for idx1 in range (0, 2):
    for idx2 in range (4, 5):
        oDoc.ScrPlaceCircuitElement('BGA_port_'+str(idx1)+'_'+str(idx2)+'_Out' , 'BGA_port_Out', 3, 1, 'BGA_RAP1', 'U14', 'U14_GRP_'+str(idx1)+'_'+str(idx2)+'_MAM_NNE_VDD', 1, 'BGA_RAP1', 'U14', 'U14_GRP_'+str(idx1)+'_'+str(idx2)+'_GND' , 0., 0., 0.0, 0.1, 0., 0.)

for idx1 in range (0, 2):
    for idx2 in range (1, 2):
        oDoc.ScrPlaceCircuitElement('BGA_port_'+str(idx1)+'_'+str(idx2)+'_Out' , 'BGA_port_Out', 3, 1, 'BGA_RAP1', 'U14', 'U14_GRP_'+str(idx1)+'_'+str(idx2)+'_MAM_NNE_VDD', 1, 'BGA_RAP1', 'U14', 'U14_GRP_'+str(idx1)+'_'+str(idx2)+'_GND' , 0., 0., 0.0, 0.1, 0., 0.)

for idx1 in range (0, 2):
    for idx2 in range (2, 4):
        oDoc.ScrPlaceCircuitElement('BGA_port_'+str(idx1)+'_'+str(idx2)+'_Out' , 'BGA_port_Out', 3, 1, 'BGA_RAP1', 'U14', 'U14_GRP_'+str(idx1)+'_'+str(idx2)+'_MAM_NNE_VDD', 1, 'BGA_RAP1', 'U14', 'U14_GRP_'+str(idx1)+'_'+str(idx2)+'_GND' , 0., 0., 0.0, 0.1, 0., 0.)


