Here is an example by using the files your provided to do the port reduction.

Look into “run” file for the commands.

Please use HSPICE 2023.12 to do the following steps.

First, we need to use SPUTIL “MAKE_DOT_LIN” to extract/generate a .LIN netlist.
It dumps an “example.sp” (d_example.sp was from my run and for your comparison, they should be identical).

Then modify the content

Reduce the “PORTS incident” (based on your need for the new S-param file) in “.lin” definition
make the “unwanted” port element become “capacitor” instances
Look into “d_example_modif.sp”

 

Run HSPICE on d_example.modif.sp to generate a *.s3p file (My result is in the ./Danny_example_modif for your reference).

Example: reduce an s5p ==> s3p

Step 1: prepare makedotlin.spu, for example

NPORT 5
TSTONEFILE Orig_touchstone.s5p
DATAFORMAT MA
MAKE_DOT_LIN spice_inter.sp

 then run: 
  -> sputil makedotlin.spu

Step 2: Edit spice_inter.sp
+ PORTS=P1 P2 P3 P4 P5
   change to 
+ PORTS=P1 P2 P3  

   replace 
P4   n4 0   port=4   z0=0.1
   with 
XCP4   n4 0  GCM155D70E106ME36_DC0V_125degC $port=4   z0=0.1
   same thing with other ports that are going to be connected with cap.
   for ports DNC, just comment that line, if issue arises, add a small cap, e.g., CP2   n3 0  small_value  $port=3   z0=0.1


  add cap model 
.inc GCM155D70E106ME36_DC0V_125degC_0402_10uF.mod   
 
 
Step 3:  -> hspice acm3_nne_pcb_231221_2.sp -o results/acm3_nne_pcb_231221_s5p_2