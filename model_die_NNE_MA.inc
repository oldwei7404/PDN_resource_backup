
* this is model subcircuit for SoC Die, lumped 

.subckt model_die_lumped_nne_ma 
+ pin_bump ref_gnd C_die=100n R_die_1=1.25m R_die_2=0m R_leak=0.84     *src_I_file=curr_src_file

R_die_1_ 	pin_bump	2	R_die_1
R_die_2_	2		3	R_die_2
C_die_		3		ref_gnd	C_die 

R_leak_		pin_bump	ref_gnd	R_leak	
XcurrSrc	pin_bump	ref_gnd	curr_src_MA   *'src_I_file'

.ends