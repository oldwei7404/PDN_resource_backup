##### User Input, specify dim of pin group to be defined  
dim1_st = "B"
dim1_ed = "BK"
dim1_step_per_net = 2 

dim2_st = 14
dim2_ed = 50
dim2_step_per_net = 2

##### remove pins from pin group def, to obtain a donut shape pin group, if desired 
is_enable_rm = False  

rm_dim1_st = "M"
rm_dim1_ed = "AM"
rm_dim1_step_per_net = 2 

rm_dim2_st = 20
rm_dim2_ed = 40
rm_dim2_step_per_net = 2

##### End of User Input 

##### Do Check with your layout to make sure dim1_list assumption is valid 
##### WARNING: an invalid value will lead to incomplete pin groups
dim1_list = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "R", "T", "U", "V", "W", "Y", "AA", "AB", "AC", "AD", "AE", "AF", "AG", "AH", "AJ", "AK", "AL", "AM", "AN", "AP", "AR", "AT", "AU", "AV", "AW", "AY", "BA", "BB", "BC", "BD", "BE", "BF", "BG", "BH", "BJ", "BK", "BL", "BM", "BN", "BP", "BR", "BT", "BU", "BV", "BW", "BY", "CA", "CB", "CC", "CD", "CE", "CF", "CG", "CH", "CJ", "CK", "CL", "CM", "CN", "CP", "CR", "CT", "CU", "CV", "CW", "CY"]


##### 
dim1_st_idx = dim1_list.index(dim1_st)
dim1_ed_idx = dim1_list.index(dim1_ed)
print('INFO: dim1 index start: ' + str(dim1_st_idx) + ', end: '+ str(dim1_ed_idx) + '\n')

pinList = []

for i_dim1 in range ( dim1_st_idx, dim1_ed_idx + 1, dim1_step_per_net):
    for i_dim2 in range (dim2_st, dim2_ed + 1, dim2_step_per_net):
        newPin = dim1_list[i_dim1] + str(i_dim2)
        pinList.append( newPin )

print("INFO: pin group list (before rm) : ", pinList)

if is_enable_rm:
    rm_dim1_st_idx = dim1_list.index(rm_dim1_st)
    rm_dim1_ed_idx = dim1_list.index(rm_dim1_ed)
    print('INFO: rm dim1 index start: ' + str(rm_dim1_st_idx) + ', end: '+ str(rm_dim1_ed_idx) + '\n')

    for i_dim1 in range ( rm_dim1_st_idx, rm_dim1_ed_idx + 1, rm_dim1_step_per_net):
        for i_dim2 in range (rm_dim2_st, rm_dim2_ed + 1, rm_dim2_step_per_net):
            newPin = dim1_list[i_dim1] + str(i_dim2)
            #print('##### debug: ' + newPin)
            pinList.remove( newPin )    
            
    print("INFO: pin group list final : ", pinList)




pinGrpPartName = "RefDesFix"
pinGrpRefDes = "DIE_NNE"
pinGrpName = "test_script_new_group_1"
oDoc.ScrCreatePinGroups(pinGrpPartName, pinGrpRefDes, pinList, pinGrpName, False)