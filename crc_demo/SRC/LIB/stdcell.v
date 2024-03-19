
//__CDS_SVN_TAG__
// $URL: file:///projects/cdnsfs/svn_repo/ifss_vmgr_flow_proj/trunk/demo/SRC/LIB/stdcell.v $ $Id: stdcell.v 176 2016-04-04 10:36:42Z vpreis $
//__CDS_SVN_TAG__

`timescale 1ns/10ps
`celldefine
  module ADDFHX2 (A, B, CI, CO, S);
   input  A ;
   input  B ;
   input  CI ;
   output CO ;
   output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.085:0.098:0.11,
     tplhl$A$S = 0.15:0.15:0.15,
     tphlh$A$S = 0.15:0.15:0.15,
     tphhl$A$S = 0.089:0.1:0.11,
     tpllh$A$CO = 0.097:0.097:0.097,
     tphhl$A$CO = 0.1:0.1:0.1,
     tpllh$B$S = 0.082:0.095:0.11,
     tplhl$B$S = 0.14:0.15:0.15,
     tphlh$B$S = 0.14:0.15:0.15,
     tphhl$B$S = 0.087:0.099:0.11,
     tpllh$B$CO = 0.092:0.095:0.097,
     tphhl$B$CO = 0.099:0.099:0.099,
     tpllh$CI$S = 0.081:0.094:0.11,
     tplhl$CI$S = 0.14:0.14:0.14,
     tphlh$CI$S = 0.14:0.14:0.14,
     tphhl$CI$S = 0.088:0.098:0.11,
     tpllh$CI$CO = 0.087:0.089:0.091,
     tphhl$CI$CO = 0.094:0.094:0.094;

      // path delays
      (posedge CI *> (S +: !(B^A))) = (tpllh$CI$S, tplhl$CI$S);
      (negedge CI *> (S +: B^A)) = (tphlh$CI$S, tphhl$CI$S);
      (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
      (posedge B *> (S +: CI^!A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: CI^A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: CI^!B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: CI^B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDFHX4 (A, B, CI, CO, S);
   input  A ;
   input  B ;
   input  CI ;
   output CO ;
   output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.083:0.097:0.11,
     tplhl$A$S = 0.16:0.16:0.16,
     tphlh$A$S = 0.16:0.16:0.16,
     tphhl$A$S = 0.087:0.1:0.12,
     tpllh$A$CO = 0.091:0.091:0.092,
     tphhl$A$CO = 0.095:0.095:0.096,
     tpllh$B$S = 0.081:0.095:0.11,
     tplhl$B$S = 0.15:0.16:0.16,
     tphlh$B$S = 0.15:0.16:0.16,
     tphhl$B$S = 0.085:0.099:0.11,
     tpllh$B$CO = 0.086:0.089:0.091,
     tphhl$B$CO = 0.093:0.093:0.093,
     tpllh$CI$S = 0.079:0.093:0.11,
     tplhl$CI$S = 0.15:0.15:0.15,
     tphlh$CI$S = 0.15:0.15:0.15,
     tphhl$CI$S = 0.086:0.097:0.11,
     tpllh$CI$CO = 0.082:0.084:0.086,
     tphhl$CI$CO = 0.088:0.088:0.089;

      // path delays
      (posedge CI *> (S +: !(B^A))) = (tpllh$CI$S, tplhl$CI$S);
      (negedge CI *> (S +: B^A)) = (tphlh$CI$S, tphhl$CI$S);
      (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
      (posedge B *> (S +: CI^!A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: CI^A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: CI^!B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: CI^B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDFHXL (A, B, CI, CO, S);
   input  A ;
   input  B ;
   input  CI ;
   output CO ;
   output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.11:0.12:0.13,
     tplhl$A$S = 0.15:0.16:0.16,
     tphlh$A$S = 0.15:0.16:0.16,
     tphhl$A$S = 0.11:0.12:0.13,
     tpllh$A$CO = 0.12:0.12:0.12,
     tphhl$A$CO = 0.12:0.12:0.12,
     tpllh$B$S = 0.1:0.11:0.12,
     tplhl$B$S = 0.15:0.15:0.16,
     tphlh$B$S = 0.15:0.16:0.16,
     tphhl$B$S = 0.11:0.12:0.13,
     tpllh$B$CO = 0.12:0.12:0.12,
     tphhl$B$CO = 0.12:0.12:0.12,
     tpllh$CI$S = 0.1:0.11:0.12,
     tplhl$CI$S = 0.15:0.15:0.15,
     tphlh$CI$S = 0.15:0.15:0.15,
     tphhl$CI$S = 0.11:0.12:0.12,
     tpllh$CI$CO = 0.11:0.11:0.12,
     tphhl$CI$CO = 0.12:0.12:0.12;

      // path delays
      (posedge CI *> (S +: !(B^A))) = (tpllh$CI$S, tplhl$CI$S);
      (negedge CI *> (S +: B^A)) = (tphlh$CI$S, tphhl$CI$S);
      (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
      (posedge B *> (S +: CI^!A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: CI^A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: CI^!B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: CI^B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDFXL (A, B, CI, CO, S);
   input  A ;
   input  B ;
   input  CI ;
   output CO ;
   output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.13:0.14:0.16,
     tplhl$A$S = 0.18:0.19:0.19,
     tphlh$A$S = 0.19:0.19:0.19,
     tphhl$A$S = 0.13:0.15:0.16,
     tpllh$A$CO = 0.15:0.15:0.15,
     tphhl$A$CO = 0.15:0.15:0.15,
     tpllh$B$S = 0.13:0.14:0.15,
     tplhl$B$S = 0.18:0.18:0.19,
     tphlh$B$S = 0.18:0.19:0.19,
     tphhl$B$S = 0.13:0.14:0.15,
     tpllh$B$CO = 0.14:0.15:0.15,
     tphhl$B$CO = 0.15:0.15:0.15,
     tpllh$CI$S = 0.13:0.14:0.15,
     tplhl$CI$S = 0.18:0.18:0.18,
     tphlh$CI$S = 0.18:0.18:0.18,
     tphhl$CI$S = 0.13:0.14:0.15,
     tpllh$CI$CO = 0.14:0.14:0.14,
     tphhl$CI$CO = 0.14:0.14:0.14;

      // path delays
      (posedge CI *> (S +: !(B^A))) = (tpllh$CI$S, tplhl$CI$S);
      (negedge CI *> (S +: B^A)) = (tphlh$CI$S, tphhl$CI$S);
      (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
      (posedge B *> (S +: CI^!A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: CI^A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: CI^!B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: CI^B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDHX2 (A, B, CO, S);
   input  A ;
   input  B ;
   output CO ;
   output S ;

   and (CO, A, B);
   xor (S, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.086:0.086:0.086,
     tplhl$A$S = 0.1:0.1:0.1,
     tphlh$A$S = 0.1:0.1:0.1,
     tphhl$A$S = 0.089:0.089:0.089,
     tpllh$A$CO = 0.076:0.076:0.076,
     tphhl$A$CO = 0.057:0.057:0.057,
     tpllh$B$S = 0.075:0.075:0.075,
     tplhl$B$S = 0.094:0.094:0.094,
     tphlh$B$S = 0.076:0.076:0.076,
     tphhl$B$S = 0.074:0.074:0.074,
     tpllh$B$CO = 0.073:0.073:0.073,
     tphhl$B$CO = 0.055:0.055:0.055;

      // path delays
      (posedge B *> (S +: !A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: !B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDHXL (A, B, CO, S);
   input  A ;
   input  B ;
   output CO ;
   output S ;

   and (CO, A, B);
   xor (S, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.12:0.12:0.12,
     tplhl$A$S = 0.14:0.14:0.14,
     tphlh$A$S = 0.14:0.14:0.14,
     tphhl$A$S = 0.13:0.13:0.13,
     tpllh$A$CO = 0.11:0.11:0.11,
     tphhl$A$CO = 0.096:0.096:0.096,
     tpllh$B$S = 0.11:0.11:0.11,
     tplhl$B$S = 0.13:0.13:0.13,
     tphlh$B$S = 0.12:0.12:0.12,
     tphhl$B$S = 0.11:0.11:0.11,
     tpllh$B$CO = 0.11:0.11:0.11,
     tphhl$B$CO = 0.095:0.095:0.095;

      // path delays
      (posedge B *> (S +: !A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: !B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND2X4 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.067:0.067:0.067,
     tphhl$A$Y = 0.047:0.047:0.047,
     tpllh$B$Y = 0.065:0.065:0.065,
     tphhl$B$Y = 0.045:0.045:0.045;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND2X6 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.052:0.052:0.052,
     tphhl$A$Y = 0.037:0.037:0.037,
     tpllh$B$Y = 0.05:0.05:0.05,
     tphhl$B$Y = 0.036:0.036:0.036;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND2XL (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.094:0.094:0.094,
     tpllh$B$Y = 0.11:0.11:0.11,
     tphhl$B$Y = 0.093:0.093:0.093;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND3X1 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.12:0.12:0.12,
     tphhl$A$Y = 0.076:0.076:0.076,
     tpllh$B$Y = 0.11:0.11:0.11,
     tphhl$B$Y = 0.075:0.075:0.075,
     tpllh$C$Y = 0.11:0.11:0.11,
     tphhl$C$Y = 0.073:0.073:0.073;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND3X8 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.083:0.083:0.083,
     tphhl$A$Y = 0.043:0.043:0.043,
     tpllh$B$Y = 0.081:0.081:0.081,
     tphhl$B$Y = 0.042:0.042:0.042,
     tpllh$C$Y = 0.077:0.077:0.077,
     tphhl$C$Y = 0.04:0.04:0.04;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND3XL (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.14:0.14:0.14,
     tphhl$A$Y = 0.1:0.1:0.1,
     tpllh$B$Y = 0.13:0.13:0.13,
     tphhl$B$Y = 0.099:0.099:0.099,
     tpllh$C$Y = 0.13:0.13:0.13,
     tphhl$C$Y = 0.097:0.097:0.097;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND4X1 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.15:0.15:0.15,
     tphhl$A$Y = 0.081:0.081:0.081,
     tpllh$B$Y = 0.15:0.15:0.15,
     tphhl$B$Y = 0.079:0.079:0.079,
     tpllh$C$Y = 0.14:0.14:0.14,
     tphhl$C$Y = 0.077:0.077:0.077,
     tpllh$D$Y = 0.13:0.13:0.13,
     tphhl$D$Y = 0.075:0.075:0.075;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND4X4 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.13:0.13:0.13,
     tphhl$A$Y = 0.055:0.055:0.055,
     tpllh$B$Y = 0.13:0.13:0.13,
     tphhl$B$Y = 0.054:0.054:0.054,
     tpllh$C$Y = 0.12:0.12:0.12,
     tphhl$C$Y = 0.053:0.053:0.053,
     tpllh$D$Y = 0.12:0.12:0.12,
     tphhl$D$Y = 0.051:0.051:0.051;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND4X8 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.047:0.047:0.047,
     tpllh$B$Y = 0.11:0.11:0.11,
     tphhl$B$Y = 0.046:0.046:0.046,
     tpllh$C$Y = 0.11:0.11:0.11,
     tphhl$C$Y = 0.044:0.044:0.044,
     tpllh$D$Y = 0.1:0.1:0.1,
     tphhl$D$Y = 0.043:0.043:0.043;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND4XL (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.17:0.17:0.17,
     tphhl$A$Y = 0.11:0.11:0.11,
     tpllh$B$Y = 0.17:0.17:0.17,
     tphhl$B$Y = 0.1:0.1:0.1,
     tpllh$C$Y = 0.16:0.16:0.16,
     tphhl$C$Y = 0.1:0.1:0.1,
     tpllh$D$Y = 0.16:0.16:0.16,
     tphhl$D$Y = 0.1:0.1:0.1;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AO21X1 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (Y, I0_out, B0);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.093:0.093:0.093,
     tphhl$A0$Y = 0.097:0.097:0.097,
     tpllh$A1$Y = 0.091:0.091:0.091,
     tphhl$A1$Y = 0.093:0.093:0.093,
     tpllh$B0$Y = 0.066:0.067:0.068,
     tphhl$B0$Y = 0.076:0.082:0.089;

      // path delays
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AO21X2 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (Y, I0_out, B0);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.085:0.085:0.085,
     tphhl$A0$Y = 0.089:0.089:0.089,
     tpllh$A1$Y = 0.083:0.083:0.083,
     tphhl$A1$Y = 0.085:0.085:0.085,
     tpllh$B0$Y = 0.053:0.054:0.055,
     tphhl$B0$Y = 0.066:0.074:0.081;

      // path delays
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AO21XL (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (Y, I0_out, B0);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.12:0.12:0.12,
     tphhl$A0$Y = 0.12:0.12:0.12,
     tpllh$A1$Y = 0.12:0.12:0.12,
     tphhl$A1$Y = 0.11:0.11:0.11,
     tpllh$B0$Y = 0.093:0.093:0.094,
     tphhl$B0$Y = 0.099:0.1:0.11;

      // path delays
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AO22X1 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (Y, I0_out, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.1:0.1:0.11,
     tphhl$A0$Y = 0.095:0.1:0.11,
     tpllh$A1$Y = 0.099:0.1:0.1,
     tphhl$A1$Y = 0.092:0.099:0.11,
     tpllh$B0$Y = 0.088:0.09:0.092,
     tphhl$B0$Y = 0.083:0.09:0.097,
     tpllh$B1$Y = 0.085:0.087:0.089,
     tphhl$B1$Y = 0.079:0.086:0.093;

      // path delays
      (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AO22X2 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (Y, I0_out, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.093:0.095:0.097,
     tphhl$A0$Y = 0.086:0.094:0.1,
     tpllh$A1$Y = 0.091:0.093:0.095,
     tphhl$A1$Y = 0.083:0.091:0.099,
     tpllh$B0$Y = 0.08:0.082:0.084,
     tphhl$B0$Y = 0.073:0.081:0.09,
     tpllh$B1$Y = 0.078:0.079:0.081,
     tphhl$B1$Y = 0.069:0.078:0.086;

      // path delays
      (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AO22XL (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (Y, I0_out, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.13:0.13:0.13,
     tphhl$A0$Y = 0.12:0.12:0.13,
     tpllh$A1$Y = 0.12:0.13:0.13,
     tphhl$A1$Y = 0.12:0.12:0.13,
     tpllh$B0$Y = 0.11:0.11:0.12,
     tphhl$B0$Y = 0.11:0.11:0.12,
     tpllh$B1$Y = 0.11:0.11:0.11,
     tphhl$B1$Y = 0.1:0.11:0.12;

      // path delays
      (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI211X2 (A0, A1, B0, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  C0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.065:0.065:0.065,
     tphlh$A0$Y = 0.094:0.094:0.094,
     tplhl$A1$Y = 0.063:0.063:0.063,
     tphlh$A1$Y = 0.091:0.091:0.091,
     tplhl$B0$Y = 0.032:0.032:0.032,
     tphlh$B0$Y = 0.07:0.079:0.088,
     tplhl$C0$Y = 0.029:0.029:0.029,
     tphlh$C0$Y = 0.063:0.071:0.079;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI211X4 (A0, A1, B0, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  C0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.045:0.045:0.045,
     tphlh$A0$Y = 0.065:0.065:0.065,
     tplhl$A1$Y = 0.043:0.043:0.043,
     tphlh$A1$Y = 0.061:0.061:0.061,
     tplhl$B0$Y = 0.022:0.022:0.022,
     tphlh$B0$Y = 0.046:0.052:0.059,
     tplhl$C0$Y = 0.019:0.019:0.019,
     tphlh$C0$Y = 0.039:0.044:0.049;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI21X1 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (I1_out, I0_out, B0);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.098:0.098:0.098,
     tphlh$A0$Y = 0.099:0.099:0.099,
     tplhl$A1$Y = 0.096:0.096:0.096,
     tphlh$A1$Y = 0.096:0.096:0.096,
     tplhl$B0$Y = 0.049:0.049:0.049,
     tphlh$B0$Y = 0.067:0.08:0.092;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI21XL (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (I1_out, I0_out, B0);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.15:0.15:0.15,
     tphlh$A0$Y = 0.16:0.16:0.16,
     tplhl$A1$Y = 0.15:0.15:0.15,
     tphlh$A1$Y = 0.15:0.15:0.15,
     tplhl$B0$Y = 0.077:0.078:0.078,
     tphlh$B0$Y = 0.11:0.13:0.15;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI221X4 (A0, A1, B0, B1, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.048:0.049:0.05,
     tphlh$A0$Y = 0.06:0.068:0.075,
     tplhl$A1$Y = 0.046:0.047:0.048,
     tphlh$A1$Y = 0.057:0.064:0.071,
     tplhl$B0$Y = 0.042:0.042:0.042,
     tphlh$B0$Y = 0.052:0.059:0.066,
     tplhl$B1$Y = 0.039:0.04:0.04,
     tphlh$B1$Y = 0.048:0.055:0.062,
     tplhl$C0$Y = 0.019:0.019:0.019,
     tphlh$C0$Y = 0.031:0.042:0.053;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI221XL (A0, A1, B0, B1, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.17:0.17:0.17,
     tphlh$A0$Y = 0.21:0.23:0.26,
     tplhl$A1$Y = 0.16:0.17:0.17,
     tphlh$A1$Y = 0.21:0.23:0.25,
     tplhl$B0$Y = 0.16:0.16:0.16,
     tphlh$B0$Y = 0.2:0.22:0.25,
     tplhl$B1$Y = 0.15:0.15:0.15,
     tphlh$B1$Y = 0.2:0.22:0.24,
     tplhl$C0$Y = 0.079:0.08:0.08,
     tphlh$C0$Y = 0.15:0.19:0.23;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI222XL (A0, A1, B0, B1, C0, C1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   input  C1 ;
   output Y ;

   and (I0_out, C0, C1);
   and (I1_out, A0, A1);
   and (I3_out, B0, B1);
   or  (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.17:0.17:0.18,
     tphlh$A0$Y = 0.18:0.23:0.27,
     tplhl$A1$Y = 0.17:0.17:0.17,
     tphlh$A1$Y = 0.18:0.22:0.26,
     tplhl$B0$Y = 0.16:0.16:0.16,
     tphlh$B0$Y = 0.17:0.22:0.26,
     tplhl$B1$Y = 0.16:0.16:0.16,
     tphlh$B1$Y = 0.17:0.21:0.25,
     tplhl$C0$Y = 0.15:0.15:0.15,
     tphlh$C0$Y = 0.15:0.19:0.24,
     tplhl$C1$Y = 0.15:0.15:0.15,
     tphlh$C1$Y = 0.15:0.19:0.23;

      // path delays
      (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI22X2 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   and (I1_out, A0, A1);
   or  (I2_out, I0_out, I1_out);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.064:0.065:0.066,
     tphlh$A0$Y = 0.052:0.059:0.067,
     tplhl$A1$Y = 0.062:0.063:0.064,
     tphlh$A1$Y = 0.05:0.057:0.064,
     tplhl$B0$Y = 0.054:0.054:0.054,
     tphlh$B0$Y = 0.042:0.049:0.057,
     tplhl$B1$Y = 0.051:0.052:0.052,
     tphlh$B1$Y = 0.04:0.048:0.055;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI22X4 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   and (I1_out, A0, A1);
   or  (I2_out, I0_out, I1_out);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.043:0.044:0.046,
     tphlh$A0$Y = 0.035:0.041:0.046,
     tplhl$A1$Y = 0.041:0.042:0.043,
     tphlh$A1$Y = 0.033:0.038:0.043,
     tplhl$B0$Y = 0.034:0.034:0.035,
     tphlh$B0$Y = 0.027:0.032:0.037,
     tplhl$B1$Y = 0.032:0.032:0.032,
     tphlh$B1$Y = 0.025:0.03:0.035;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI22XL (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   and (I1_out, A0, A1);
   or  (I2_out, I0_out, I1_out);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.16:0.16:0.16,
     tphlh$A0$Y = 0.13:0.15:0.17,
     tplhl$A1$Y = 0.15:0.16:0.16,
     tphlh$A1$Y = 0.13:0.14:0.16,
     tplhl$B0$Y = 0.14:0.15:0.15,
     tphlh$B0$Y = 0.11:0.13:0.16,
     tplhl$B1$Y = 0.14:0.14:0.14,
     tphlh$B1$Y = 0.11:0.13:0.15;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI2BB1X2 (A0N, A1N, B0, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.078:0.078:0.078,
     tphhl$A0N$Y = 0.085:0.085:0.085,
     tpllh$A1N$Y = 0.075:0.075:0.075,
     tphhl$A1N$Y = 0.082:0.082:0.082,
     tplhl$B0$Y = 0.03:0.03:0.03,
     tphlh$B0$Y = 0.053:0.054:0.054;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI2BB1X4 (A0N, A1N, B0, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.059:0.059:0.059,
     tphhl$A0N$Y = 0.073:0.073:0.073,
     tpllh$A1N$Y = 0.057:0.057:0.057,
     tphhl$A1N$Y = 0.07:0.07:0.07,
     tplhl$B0$Y = 0.02:0.02:0.02,
     tphlh$B0$Y = 0.034:0.034:0.035;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI2BB1XL (A0N, A1N, B0, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.16:0.16:0.16,
     tphhl$A0N$Y = 0.11:0.11:0.11,
     tpllh$A1N$Y = 0.16:0.16:0.16,
     tphhl$A1N$Y = 0.11:0.11:0.11,
     tplhl$B0$Y = 0.08:0.08:0.08,
     tphlh$B0$Y = 0.15:0.15:0.15;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI2BB2X2 (A0N, A1N, B0, B1, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   or  (I1_out, A0N, A1N);
   not (I2_out, I1_out);
   or  (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.077:0.084:0.091,
     tphhl$A0N$Y = 0.09:0.091:0.092,
     tpllh$A1N$Y = 0.076:0.083:0.09,
     tphhl$A1N$Y = 0.088:0.089:0.09,
     tplhl$B0$Y = 0.053:0.054:0.054,
     tphlh$B0$Y = 0.041:0.049:0.057,
     tplhl$B1$Y = 0.051:0.051:0.051,
     tphlh$B1$Y = 0.04:0.048:0.055;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI2BB2XL (A0N, A1N, B0, B1, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   or  (I1_out, A0N, A1N);
   not (I2_out, I1_out);
   or  (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.14:0.16:0.18,
     tphhl$A0N$Y = 0.17:0.17:0.17,
     tpllh$A1N$Y = 0.14:0.16:0.18,
     tphhl$A1N$Y = 0.17:0.17:0.17,
     tplhl$B0$Y = 0.15:0.15:0.15,
     tphlh$B0$Y = 0.12:0.14:0.16,
     tplhl$B1$Y = 0.14:0.14:0.14,
     tphlh$B1$Y = 0.11:0.13:0.15;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI31X2 (A0, A1, A2, B0, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   output Y ;

   and (I1_out, A0, A1, A2);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.09:0.09:0.09,
     tphlh$A0$Y = 0.063:0.063:0.063,
     tplhl$A1$Y = 0.088:0.088:0.088,
     tphlh$A1$Y = 0.061:0.061:0.061,
     tplhl$A2$Y = 0.084:0.084:0.084,
     tphlh$A2$Y = 0.059:0.059:0.059,
     tplhl$B0$Y = 0.028:0.028:0.028,
     tphlh$B0$Y = 0.034:0.044:0.054;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI32X2 (A0, A1, A2, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   and (I2_out, A0, A1, A2);
   or  (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.098:0.099:0.1,
     tphlh$A0$Y = 0.055:0.063:0.071,
     tplhl$A1$Y = 0.095:0.097:0.099,
     tphlh$A1$Y = 0.054:0.061:0.069,
     tplhl$A2$Y = 0.091:0.093:0.094,
     tphlh$A2$Y = 0.052:0.059:0.067,
     tplhl$B0$Y = 0.054:0.054:0.054,
     tphlh$B0$Y = 0.038:0.049:0.06,
     tplhl$B1$Y = 0.051:0.052:0.052,
     tphlh$B1$Y = 0.037:0.047:0.058;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI32X4 (A0, A1, A2, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   and (I2_out, A0, A1, A2);
   or  (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.069:0.07:0.072,
     tphlh$A0$Y = 0.039:0.045:0.051,
     tplhl$A1$Y = 0.066:0.068:0.07,
     tphlh$A1$Y = 0.038:0.043:0.048,
     tplhl$A2$Y = 0.062:0.064:0.066,
     tphlh$A2$Y = 0.036:0.041:0.046,
     tplhl$B0$Y = 0.035:0.035:0.035,
     tphlh$B0$Y = 0.025:0.032:0.04,
     tplhl$B1$Y = 0.032:0.032:0.033,
     tphlh$B1$Y = 0.023:0.03:0.037;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI32XL (A0, A1, A2, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   and (I2_out, A0, A1, A2);
   or  (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.23:0.24:0.24,
     tphlh$A0$Y = 0.13:0.15:0.17,
     tplhl$A1$Y = 0.23:0.23:0.23,
     tphlh$A1$Y = 0.13:0.15:0.17,
     tplhl$A2$Y = 0.23:0.23:0.23,
     tphlh$A2$Y = 0.13:0.15:0.16,
     tplhl$B0$Y = 0.14:0.14:0.14,
     tphlh$B0$Y = 0.1:0.13:0.16,
     tplhl$B1$Y = 0.14:0.14:0.14,
     tphlh$B1$Y = 0.1:0.13:0.15;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI33X1 (A0, A1, A2, B0, B1, B2, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   input  B2 ;
   output Y ;

   and (I1_out, B0, B1, B2);
   and (I3_out, A0, A1, A2);
   or  (I4_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.16:0.16:0.17,
     tphlh$A0$Y = 0.083:0.1:0.12,
     tplhl$A1$Y = 0.16:0.16:0.17,
     tphlh$A1$Y = 0.082:0.099:0.12,
     tplhl$A2$Y = 0.15:0.16:0.16,
     tphlh$A2$Y = 0.079:0.096:0.11,
     tplhl$B0$Y = 0.14:0.14:0.14,
     tphlh$B0$Y = 0.068:0.086:0.1,
     tplhl$B1$Y = 0.14:0.14:0.14,
     tphlh$B1$Y = 0.066:0.084:0.1,
     tplhl$B2$Y = 0.13:0.13:0.13,
     tphlh$B2$Y = 0.064:0.081:0.098;

      // path delays
      (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI33X2 (A0, A1, A2, B0, B1, B2, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   input  B2 ;
   output Y ;

   and (I1_out, B0, B1, B2);
   and (I3_out, A0, A1, A2);
   or  (I4_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.1:0.11:0.11,
     tphlh$A0$Y = 0.055:0.067:0.078,
     tplhl$A1$Y = 0.1:0.11:0.11,
     tphlh$A1$Y = 0.053:0.064:0.076,
     tplhl$A2$Y = 0.098:0.1:0.1,
     tphlh$A2$Y = 0.052:0.063:0.074,
     tplhl$B0$Y = 0.084:0.084:0.084,
     tphlh$B0$Y = 0.041:0.053:0.065,
     tplhl$B1$Y = 0.081:0.082:0.082,
     tphlh$B1$Y = 0.04:0.051:0.063,
     tplhl$B2$Y = 0.077:0.077:0.077,
     tphlh$B2$Y = 0.038:0.049:0.06;

      // path delays
      (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI33X4 (A0, A1, A2, B0, B1, B2, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   input  B2 ;
   output Y ;

   and (I1_out, B0, B1, B2);
   and (I3_out, A0, A1, A2);
   or  (I4_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.075:0.079:0.083,
     tphlh$A0$Y = 0.04:0.049:0.058,
     tplhl$A1$Y = 0.073:0.077:0.08,
     tphlh$A1$Y = 0.038:0.047:0.056,
     tplhl$A2$Y = 0.069:0.072:0.076,
     tphlh$A2$Y = 0.037:0.045:0.053,
     tplhl$B0$Y = 0.056:0.056:0.057,
     tphlh$B0$Y = 0.028:0.037:0.045,
     tplhl$B1$Y = 0.054:0.054:0.054,
     tphlh$B1$Y = 0.026:0.034:0.043,
     tplhl$B2$Y = 0.049:0.049:0.05,
     tphlh$B2$Y = 0.025:0.032:0.04;

      // path delays
      (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module BUFX12 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.033:0.033:0.033,
     tphhl$A$Y = 0.034:0.034:0.034;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module BUFX16 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.031:0.031:0.031,
     tphhl$A$Y = 0.032:0.032:0.032;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module BUFX2 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.05:0.05:0.05,
     tphhl$A$Y = 0.052:0.052:0.052;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module BUFX20 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.031:0.031:0.031,
     tphhl$A$Y = 0.032:0.032:0.032;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module BUFX3 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.041:0.041:0.041,
     tphhl$A$Y = 0.042:0.042:0.042;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module BUFX4 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.042:0.042:0.042,
     tphhl$A$Y = 0.043:0.043:0.043;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKAND2X2 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.056:0.056:0.056,
     tphhl$A$Y = 0.06:0.06:0.06,
     tpllh$B$Y = 0.054:0.054:0.054,
     tphhl$B$Y = 0.056:0.056:0.056;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKAND2X6 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.038:0.038:0.038,
     tphhl$A$Y = 0.041:0.041:0.041,
     tpllh$B$Y = 0.036:0.036:0.036,
     tphhl$B$Y = 0.038:0.038:0.038;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKBUFX12 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.033:0.033:0.033,
     tphhl$A$Y = 0.034:0.034:0.034;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKBUFX16 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.031:0.031:0.031,
     tphhl$A$Y = 0.032:0.032:0.032;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKBUFX2 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.05:0.05:0.05,
     tphhl$A$Y = 0.052:0.052:0.052;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKBUFX20 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.031:0.031:0.031,
     tphhl$A$Y = 0.032:0.032:0.032;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKBUFX4 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.042:0.042:0.042,
     tphhl$A$Y = 0.043:0.043:0.043;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKBUFX6 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.032:0.032:0.032,
     tphhl$A$Y = 0.034:0.034:0.034;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKBUFX8 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.034:0.034:0.034,
     tphhl$A$Y = 0.036:0.036:0.036;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKINVX1 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.048:0.048:0.048,
     tphlh$A$Y = 0.047:0.047:0.047;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKINVX12 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.0099:0.0099:0.0099,
     tphlh$A$Y = 0.0096:0.0096:0.0096;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKINVX16 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.0089:0.0089:0.0089,
     tphlh$A$Y = 0.0085:0.0085:0.0085;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKINVX2 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.027:0.027:0.027,
     tphlh$A$Y = 0.026:0.026:0.026;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKINVX20 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.0085:0.0085:0.0085,
     tphlh$A$Y = 0.0082:0.0082:0.0082;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKINVX3 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.02:0.02:0.02,
     tphlh$A$Y = 0.02:0.02:0.02;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKINVX4 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.017:0.017:0.017,
     tphlh$A$Y = 0.016:0.016:0.016;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKINVX6 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.014:0.014:0.014,
     tphlh$A$Y = 0.013:0.013:0.013;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKMX2X12 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.13:0.13:0.13,
     tphhl$A$Y = 0.14:0.14:0.14,
     tpllh$B$Y = 0.13:0.13:0.13,
     tphhl$B$Y = 0.14:0.14:0.14,
     tpllh$S0$Y = 0.13:0.13:0.13,
     tplhl$S0$Y = 0.15:0.15:0.15,
     tphlh$S0$Y = 0.14:0.14:0.14,
     tphhl$S0$Y = 0.14:0.14:0.14;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKXOR2X1 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.1:0.1:0.1,
     tplhl$A$Y = 0.12:0.12:0.12,
     tphlh$A$Y = 0.12:0.12:0.12,
     tphhl$A$Y = 0.11:0.11:0.11,
     tpllh$B$Y = 0.091:0.091:0.091,
     tplhl$B$Y = 0.11:0.11:0.11,
     tphlh$B$Y = 0.092:0.092:0.092,
     tphhl$B$Y = 0.091:0.091:0.091;

      // path delays
      (posedge B *> (Y +: !A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: !B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKXOR2X4 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.1:0.1:0.1,
     tplhl$A$Y = 0.11:0.11:0.11,
     tphlh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.11:0.11:0.11,
     tpllh$B$Y = 0.077:0.077:0.077,
     tplhl$B$Y = 0.099:0.099:0.099,
     tphlh$B$Y = 0.085:0.085:0.085,
     tphhl$B$Y = 0.086:0.086:0.086;

      // path delays
      (posedge B *> (Y +: !A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: !B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFHQX1 (CK, D, Q);
   input  CK ;
   input  D ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tminpwh$CK = 0.052:0.15:0.15,
     tminpwl$CK = 0.052:0.1:0.1,
     tsetup_negedge$D$CK = 0.0063:0.0063:0.0063,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.038:0.038:0.038,
     thold_posedge$D$CK = -0.012:-0.012:-0.012;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFHQX2 (CK, D, Q);
   input  CK ;
   input  D ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.054:0.13:0.13,
     tminpwl$CK = 0.054:0.11:0.11,
     tsetup_negedge$D$CK = 0.012:0.012:0.012,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.037:0.037:0.037,
     thold_posedge$D$CK = -0.012:-0.012:-0.012;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

    endspecify

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFNSRX2 (CKN, D, Q, QN, RN, SN);
   input  CKN ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I13_out, RN, SN);
   not (I16_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I16_out, SN);
   not (I18_out, D);
   not (I19_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I18_out, I19_out);

    specify
      // delay parameters
      specparam
	tphlh$CKN$Q = 0.16:0.16:0.16,
     tphhl$CKN$Q = 0.14:0.14:0.14,
     tphlh$CKN$QN = 0.16:0.16:0.16,
     tphhl$CKN$QN = 0.18:0.18:0.18,
     tphhl$RN$Q = 0.18:0.19:0.19,
     tphlh$RN$QN = 0.2:0.21:0.22,
     tplhl$SN$Q = 0.16:0.17:0.17,
     tphlh$SN$Q = 0.12:0.13:0.13,
     tpllh$SN$QN = 0.18:0.19:0.2,
     tphhl$SN$QN = 0.15:0.15:0.15,
     tminpwh$CKN = 0.059:0.13:0.13,
     tminpwl$CKN = 0.063:0.16:0.16,
     tminpwl$RN = 0.067:0.22:0.22,
     tminpwl$SN = 0.023:0.15:0.15,
     tsetup_negedge$D$CKN = 0.081:0.081:0.081,
     thold_negedge$D$CKN = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CKN = 0.056:0.056:0.056,
     thold_posedge$D$CKN = 0.031:0.031:0.031,
     trec$RN$CKN = 0.05:0.05:0.05,
     trem$RN$CKN = 0.0063:0.0063:0.0063,
     trec$RN$SN = 0.081:0.081:0.081,
     trec$SN$CKN = 0.044:0.044:0.044,
     trem$SN$CKN = 0.012:0.012:0.012;

      // path delays
      (negedge CKN *> (QN -: D)) = (tphlh$CKN$QN, tphhl$CKN$QN);
      (negedge CKN *> (Q +: D)) = (tphlh$CKN$Q, tphhl$CKN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
      $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
      $recovery(posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CKN, NOTIFIER);
      $removal (posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CKN, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CKN, NOTIFIER);
      $removal (posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CKN, NOTIFIER);
      $width(posedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CKN, 0, NOTIFIER);
      $width(negedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CKN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify 

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFQX1 (CK, D, Q);
   input  CK ;
   input  D ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tminpwh$CK = 0.05:0.15:0.15,
     tminpwl$CK = 0.053:0.1:0.1,
     tsetup_negedge$D$CK = 0.019:0.019:0.019,
     thold_negedge$D$CK = 0.019:0.019:0.019,
     tsetup_posedge$D$CK = 0.037:0.037:0.037,
     thold_posedge$D$CK = -0.019:-0.019:-0.019;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFQX2 (CK, D, Q);
   input  CK ;
   input  D ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.054:0.13:0.13,
     tminpwl$CK = 0.053:0.1:0.1,
     tsetup_negedge$D$CK = 0.019:0.019:0.019,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.019:-0.019:-0.019;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFQX4 (CK, D, Q);
   input  CK ;
   input  D ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.12:0.12:0.12,
     tminpwh$CK = 0.06:0.12:0.12,
     tminpwl$CK = 0.054:0.1:0.1,
     tsetup_negedge$D$CK = 0.019:0.019:0.019,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.012:-0.012:-0.012;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFRHQX2 (CK, D, Q, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (N30, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I5_out, RN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tphhl$RN$Q = 0.059:0.059:0.059,
     tminpwh$CK = 0.054:0.14:0.14,
     tminpwl$CK = 0.056:0.11:0.11,
     tminpwl$RN = 0.021:0.08:0.08,
     tsetup_negedge$D$CK = 0.0062:0.0062:0.0062,
     thold_negedge$D$CK = 0.031:0.031:0.031,
     tsetup_posedge$D$CK = 0.037:0.037:0.037,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = -0.038:-0.038:-0.038,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D == 1'b0, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFRX1 (CK, D, Q, QN, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (N30, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I7_out, RN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.18:0.18:0.18,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tpllh$CK$QN = 0.18:0.18:0.18,
     tplhl$CK$QN = 0.19:0.19:0.19,
     tphhl$RN$Q = 0.086:0.086:0.087,
     tphlh$RN$QN = 0.099:0.099:0.099,
     tminpwh$CK = 0.051:0.18:0.18,
     tminpwl$CK = 0.052:0.11:0.11,
     tminpwl$RN = 0.024:0.099:0.099,
     tsetup_negedge$D$CK = 0.019:0.019:0.019,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = -0.038:-0.038:-0.038,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D == 1'b0, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFRX4 (CK, D, Q, QN, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (N30, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I7_out, RN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.046:0.046:0.046,
     tphlh$RN$QN = 0.071:0.071:0.071,
     tminpwh$CK = 0.058:0.16:0.16,
     tminpwl$CK = 0.049:0.1:0.1,
     tminpwl$RN = 0.019:0.092:0.092,
     tsetup_negedge$D$CK = 0.019:0.019:0.019,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = -0.031:-0.031:-0.031,
     trem$RN$CK = 0.05:0.05:0.05;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D == 1'b0, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFRXL (CK, D, Q, QN, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (N30, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I7_out, RN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.2:0.2:0.2,
     tplhl$CK$Q = 0.19:0.19:0.19,
     tpllh$CK$QN = 0.2:0.2:0.2,
     tplhl$CK$QN = 0.2:0.2:0.2,
     tphhl$RN$Q = 0.11:0.11:0.11,
     tphlh$RN$QN = 0.12:0.12:0.12,
     tminpwh$CK = 0.051:0.2:0.2,
     tminpwl$CK = 0.053:0.11:0.11,
     tminpwl$RN = 0.022:0.12:0.12,
     tsetup_negedge$D$CK = 0.012:0.012:0.012,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = -0.037:-0.037:-0.037,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D == 1'b0, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSHQX2 (CK, D, Q, SN);
   input  CK ;
   input  D ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (N35, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I5_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tphlh$SN$Q = 0.099:0.1:0.1,
     tminpwh$CK = 0.052:0.14:0.14,
     tminpwl$CK = 0.053:0.12:0.12,
     tminpwl$SN = 0.017:0.1:0.1,
     tsetup_negedge$D$CK = 0.037:0.037:0.037,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.012:-0.012:-0.012,
     trec$SN$CK = 0:0:0,
     trem$SN$CK = 0.038:0.038:0.038;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSHQX4 (CK, D, Q, SN);
   input  CK ;
   input  D ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (N35, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I5_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tphlh$SN$Q = 0.096:0.096:0.096,
     tminpwh$CK = 0.059:0.14:0.14,
     tminpwl$CK = 0.054:0.12:0.12,
     tminpwl$SN = 0.015:0.096:0.096,
     tsetup_negedge$D$CK = 0.038:0.038:0.038,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.038:0.038:0.038,
     thold_posedge$D$CK = -0.012:-0.012:-0.012,
     trec$SN$CK = 0:0:0,
     trem$SN$CK = 0.037:0.037:0.037;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSHQX8 (CK, D, Q, SN);
   input  CK ;
   input  D ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (N35, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I5_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tphlh$SN$Q = 0.1:0.1:0.1,
     tminpwh$CK = 0.064:0.14:0.14,
     tminpwl$CK = 0.051:0.12:0.12,
     tminpwl$SN = 0.017:0.1:0.1,
     tsetup_negedge$D$CK = 0.044:0.044:0.044,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.012:-0.012:-0.012,
     trec$SN$CK = 0.0062:0.0062:0.0062,
     trem$SN$CK = 0.031:0.031:0.031;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSRHQX1 (CK, D, Q, RN, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   not (I6_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I6_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I10_out, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I13_out, SN);
   not (I15_out, D);
   not (I16_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I15_out, I16_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tphhl$RN$Q = 0.18:0.19:0.19,
     tplhl$SN$Q = 0.16:0.16:0.17,
     tphlh$SN$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.058:0.16:0.16,
     tminpwl$CK = 0.054:0.13:0.13,
     tminpwl$RN = 0.062:0.19:0.19,
     tminpwl$SN = 0.019:0.13:0.13,
     tsetup_negedge$D$CK = 0.037:0.037:0.037,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.069:0.069:0.069,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = 0.062:0.062:0.062,
     trem$RN$CK = -0.012:-0.012:-0.012,
     trec$RN$SN = 0.069:0.069:0.069,
     trec$SN$CK = 0.0063:0.0063:0.0063,
     trem$SN$CK = 0.037:0.037:0.037;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSRHQX2 (CK, D, Q, RN, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   not (I6_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I6_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I10_out, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I13_out, SN);
   not (I15_out, D);
   not (I16_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I15_out, I16_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tphhl$RN$Q = 0.17:0.17:0.18,
     tplhl$SN$Q = 0.15:0.15:0.16,
     tphlh$SN$Q = 0.11:0.11:0.12,
     tminpwh$CK = 0.057:0.15:0.15,
     tminpwl$CK = 0.053:0.13:0.13,
     tminpwl$RN = 0.06:0.18:0.18,
     tminpwl$SN = 0.019:0.12:0.12,
     tsetup_negedge$D$CK = 0.037:0.037:0.037,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.069:0.069:0.069,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = 0.063:0.063:0.063,
     trem$RN$CK = -0.012:-0.012:-0.012,
     trec$RN$SN = 0.069:0.075:0.075,
     trec$SN$CK = 0.0062:0.0062:0.0062,
     trem$SN$CK = 0.038:0.038:0.038;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSRX1 (CK, D, Q, QN, RN, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I12_out, RN, SN);
   not (I15_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I15_out, SN);
   not (I17_out, D);
   not (I18_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I17_out, I18_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.17:0.17:0.17,
     tpllh$CK$QN = 0.18:0.18:0.18,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.19:0.2:0.21,
     tphlh$RN$QN = 0.2:0.21:0.22,
     tplhl$SN$Q = 0.18:0.18:0.19,
     tphlh$SN$Q = 0.14:0.14:0.15,
     tpllh$SN$QN = 0.19:0.2:0.2,
     tphhl$SN$QN = 0.16:0.16:0.16,
     tminpwh$CK = 0.051:0.18:0.18,
     tminpwl$CK = 0.048:0.12:0.12,
     tminpwl$RN = 0.06:0.22:0.22,
     tminpwl$SN = 0.022:0.16:0.16,
     tsetup_negedge$D$CK = 0.056:0.056:0.056,
     thold_negedge$D$CK = 0.019:0.019:0.019,
     tsetup_posedge$D$CK = 0.088:0.088:0.088,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = 0.075:0.075:0.075,
     trem$RN$CK = -0.019:-0.019:-0.019,
     trec$RN$SN = 0.075:0.081:0.081,
     trec$SN$CK = 0.025:0.025:0.025,
     trem$SN$CK = 0.025:0.025:0.025;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSRXL (CK, D, Q, QN, RN, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I12_out, RN, SN);
   not (I15_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I15_out, SN);
   not (I17_out, D);
   not (I18_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I17_out, I18_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.18:0.18:0.18,
     tplhl$CK$Q = 0.2:0.2:0.2,
     tpllh$CK$QN = 0.21:0.21:0.21,
     tplhl$CK$QN = 0.19:0.19:0.19,
     tphhl$RN$Q = 0.22:0.22:0.23,
     tphlh$RN$QN = 0.23:0.23:0.24,
     tplhl$SN$Q = 0.2:0.21:0.22,
     tphlh$SN$Q = 0.17:0.17:0.17,
     tpllh$SN$QN = 0.21:0.22:0.23,
     tphhl$SN$QN = 0.18:0.18:0.18,
     tminpwh$CK = 0.052:0.21:0.21,
     tminpwl$CK = 0.05:0.13:0.13,
     tminpwl$RN = 0.059:0.24:0.24,
     tminpwl$SN = 0.022:0.18:0.18,
     tsetup_negedge$D$CK = 0.05:0.05:0.05,
     thold_negedge$D$CK = 0.019:0.019:0.019,
     tsetup_posedge$D$CK = 0.081:0.081:0.081,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = 0.069:0.069:0.069,
     trem$RN$CK = -0.012:-0.012:-0.012,
     trec$RN$SN = 0.075:0.081:0.081,
     trec$SN$CK = 0.019:0.019:0.019,
     trem$SN$CK = 0.031:0.031:0.031;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFTRX2 (CK, D, Q, QN, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_D, D, RN);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   not (I8_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I7_out, I8_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.048:0.16:0.16,
     tminpwl$CK = 0.049:0.085:0.085,
     tsetup_negedge$D$CK = 0.025:0.025:0.025,
     thold_negedge$D$CK = 0.0063:0.0063:0.0063,
     tsetup_negedge$RN$CK = 0.025:0.025:0.025,
     thold_negedge$RN$CK = 0.0063:0.0063:0.0063,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$RN$CK = 0.075:0.075:0.075,
     thold_posedge$RN$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (QN -: RN&D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: RN&D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFX1 (CK, D, Q, QN);
   input  CK ;
   input  D ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tpllh$CK$QN = 0.17:0.17:0.17,
     tplhl$CK$QN = 0.16:0.16:0.16,
     tminpwh$CK = 0.05:0.17:0.17,
     tminpwl$CK = 0.052:0.1:0.1,
     tsetup_negedge$D$CK = 0.019:0.019:0.019,
     thold_negedge$D$CK = 0.019:0.019:0.019,
     tsetup_posedge$D$CK = 0.038:0.038:0.038,
     thold_posedge$D$CK = -0.019:-0.019:-0.019;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFX2 (CK, D, Q, QN);
   input  CK ;
   input  D ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.047:0.16:0.16,
     tminpwl$CK = 0.046:0.096:0.096,
     tsetup_negedge$D$CK = 0.019:0.019:0.019,
     thold_negedge$D$CK = 0.019:0.019:0.019,
     tsetup_posedge$D$CK = 0.037:0.037:0.037,
     thold_posedge$D$CK = -0.019:-0.019:-0.019;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DLY1X4 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.095:0.095:0.095,
     tphhl$A$Y = 0.094:0.094:0.094;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DLY2X4 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.17:0.17:0.17,
     tphhl$A$Y = 0.17:0.17:0.17;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DLY3X4 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.24:0.24:0.24,
     tphhl$A$Y = 0.24:0.24:0.24;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFHQX2 (CK, D, E, Q);
   input  CK ;
   input  D ;
   input  E ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D);
   and (D_EQ_0_AN_E_EQ_1, I6_out, E);

   specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.047:0.13:0.13,
     tminpwl$CK = 0.047:0.089:0.089,
     tsetup_negedge$D$CK = 0.056:0.056:0.056,
     thold_negedge$D$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$E$CK = 0.025:0.025:0.025,
     thold_negedge$E$CK = 0.012:0.012:0.012,
     tsetup_posedge$D$CK = 0.081:0.081:0.081,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$E$CK = 0.075:0.075:0.075,
     thold_posedge$E$CK = -0.05:-0.05:-0.05;
      
      // path delays
      (posedge CK *> (Q +: E?D:!QBINT)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFTRX1 (CK, D, E, Q, QN, RN);
   input  CK ;
   input  D ;
   input  E ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, QBINT);
   not (I5_out, I4_out);
   and (I0_D, I2_out, I5_out, RN);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I14_out, D);
   not (I15_out, E);
   and (D_EQ_0_AN_E_EQ_0, I14_out, I15_out);
   and (D_EQ_1_AN_E_EQ_1, D, E);
   and (E_EQ_1_AN_RN_EQ_1, E, RN);
   not (I19_out, D);
   not (I20_out, E);
   not (I22_out, RN);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0, I19_out, I20_out, I22_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tpllh$CK$QN = 0.17:0.17:0.17,
     tplhl$CK$QN = 0.16:0.16:0.16,
     tminpwh$CK = 0.053:0.17:0.17,
     tminpwl$CK = 0.055:0.1:0.1,
     tsetup_negedge$D$CK = 0.075:0.075:0.075,
     thold_negedge$D$CK = -0.037:-0.037:-0.037,
     tsetup_negedge$E$CK = 0.069:0.088:0.088,
     thold_negedge$E$CK = -0.081:-0.05:-0.05,
     tsetup_negedge$RN$CK = 0.069:0.069:0.069,
     thold_negedge$RN$CK = -0.031:-0.031:-0.031,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$E$CK = 0.062:0.14:0.14,
     thold_posedge$E$CK = -0.12:-0.044:-0.044,
     thold_posedge$RN$CK = -0.12:-0.12:-0.12,
     tsetup_posedge$RN$CK = 0.15:0.15:0.15;

      // path delays
      (posedge CK *> (QN -: RN&(!(QBINT&!E)&!(E&!D)))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: RN&(!(QBINT&!E)&!(E&!D)))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& RN == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D_EQ_0_AN_E_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& RN == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D_EQ_1_AN_E_EQ_1 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFTRX4 (CK, D, E, Q, QN, RN);
   input  CK ;
   input  D ;
   input  E ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, QBINT);
   not (I5_out, I4_out);
   and (I0_D, I2_out, I5_out, RN);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I14_out, D);
   not (I15_out, E);
   and (D_EQ_0_AN_E_EQ_0, I14_out, I15_out);
   and (D_EQ_1_AN_E_EQ_1, D, E);
   and (E_EQ_1_AN_RN_EQ_1, E, RN);
   not (I19_out, D);
   not (I20_out, E);
   not (I22_out, RN);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0, I19_out, I20_out, I22_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.16:0.16:0.16,
     tminpwh$CK = 0.065:0.16:0.16,
     tminpwl$CK = 0.055:0.1:0.1,
     tsetup_negedge$D$CK = 0.075:0.075:0.075,
     thold_negedge$D$CK = -0.031:-0.031:-0.031,
     tsetup_negedge$E$CK = 0.062:0.081:0.081,
     thold_negedge$E$CK = -0.069:-0.044:-0.044,
     tsetup_negedge$RN$CK = 0.069:0.069:0.069,
     thold_negedge$RN$CK = -0.025:-0.025:-0.025,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.075:-0.075:-0.075,
     tsetup_posedge$E$CK = 0.062:0.14:0.14,
     thold_posedge$E$CK = -0.12:-0.044:-0.044,
     thold_posedge$RN$CK = -0.12:-0.12:-0.12,
     tsetup_posedge$RN$CK = 0.14:0.14:0.14;

      // path delays
      (posedge CK *> (QN -: RN&(!(QBINT&!E)&!(E&!D)))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: RN&(!(QBINT&!E)&!(E&!D)))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& RN == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D_EQ_0_AN_E_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& RN == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D_EQ_1_AN_E_EQ_1 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFX1 (CK, D, E, Q, QN);
   input  CK ;
   input  D ;
   input  E ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   and (D_EQ_0_AN_E_EQ_1, I8_out, E);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.045:0.16:0.16,
     tminpwl$CK = 0.044:0.087:0.087,
     tsetup_negedge$D$CK = 0.075:0.075:0.075,
     thold_negedge$D$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$E$CK = 0.031:0.031:0.031,
     thold_negedge$E$CK = 0.0063:0.0063:0.0063,


     tsetup_posedge$D$CK = 0.094:0.094:0.094,
     thold_posedge$D$CK = -0.062:-0.062:-0.062,
     tsetup_posedge$E$CK = 0.087:0.087:0.087,
      thold_posedge$E$CK = -0.062:-0.062:-0.062;
       


      // path delays
      (posedge CK *> (QN -: E?D:!QBINT)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: E?D:!QBINT)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFX4 (CK, D, E, Q, QN);
   input  CK ;
   input  D ;
   input  E ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   and (D_EQ_0_AN_E_EQ_1, I8_out, E);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.15:0.15:0.15,
     tplhl$CK$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.052:0.15:0.15,
     tminpwl$CK = 0.046:0.089:0.089,
     tsetup_negedge$D$CK = 0.075:0.075:0.075,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$E$CK = 0.025:0.025:0.025,
     thold_negedge$E$CK = 0.0062:0.0062:0.0062,


     tsetup_posedge$D$CK = 0.094:0.094:0.094,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$E$CK = 0.087:0.087:0.087,
      thold_posedge$E$CK = -0.063:-0.063:-0.063;
       


      // path delays
      (posedge CK *> (QN -: E?D:!QBINT)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: E?D:!QBINT)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module HOLDX1 (Y);
   inout  Y ;

   buf (weak1, strong0) (Y, Y);


endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module INVX1 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.048:0.048:0.048,
     tphlh$A$Y = 0.047:0.047:0.047;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module INVX12 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.01:0.01:0.01,
     tphlh$A$Y = 0.0096:0.0096:0.0096;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module INVX2 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.027:0.027:0.027,
     tphlh$A$Y = 0.026:0.026:0.026;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module INVX3 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.02:0.02:0.02,
     tphlh$A$Y = 0.02:0.02:0.02;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MDFFHQX8 (CK, D0, D1, Q, S0);
   input  CK ;
   input  D0 ;
   input  D1 ;
   input  S0 ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D0, D1, S0);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D0);
   and (D0_EQ_0_AN_D1_EQ_1, I5_out, D1);
   not (I7_out, D1);
   and (D0_EQ_1_AN_D1_EQ_0, D0, I7_out);
   not (I9_out, D0);
   not (I10_out, D1);
   not (I12_out, S0);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.066:0.13:0.13,
     tminpwl$CK = 0.053:0.096:0.096,
     tsetup_negedge$D0$CK = 0.044:0.044:0.044,
     thold_negedge$D0$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_negedge$D1$CK = 0.044:0.044:0.044,
     thold_negedge$D1$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_negedge$S0$CK = 0.081:0.081:0.081,
     thold_negedge$S0$CK = -0.05:-0.05:-0.05,


     tsetup_posedge$D0$CK = 0.069:0.069:0.069,
     thold_posedge$D0$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$D1$CK = 0.069:0.069:0.069,
     thold_posedge$D1$CK = -0.037:-0.037:-0.037,
     tsetup_posedge$S0$CK = 0.056:0.056:0.056,
      thold_posedge$S0$CK = -0.012:-0.012:-0.012;
       


      // path delays
      (posedge CK *> (Q +: S0?D1:D0)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D0, posedge CK &&& S0 == 1'b0, tsetup_negedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b0, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
      $setup(negedge D1, posedge CK &&& S0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(posedge D0, posedge CK &&& S0 == 1'b0, tsetup_posedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b0, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
      $setup(posedge D1, posedge CK &&& S0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $width(posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX2X1 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.095:0.095:0.095,
     tphhl$A$Y = 0.098:0.098:0.098,
     tpllh$B$Y = 0.095:0.095:0.095,
     tphhl$B$Y = 0.099:0.099:0.099,
     tpllh$S0$Y = 0.088:0.088:0.088,
     tplhl$S0$Y = 0.11:0.11:0.11,
     tphlh$S0$Y = 0.11:0.11:0.11,
     tphhl$S0$Y = 0.091:0.091:0.091;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX2X2 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.086:0.086:0.086,
     tphhl$A$Y = 0.089:0.089:0.089,
     tpllh$B$Y = 0.086:0.086:0.086,
     tphhl$B$Y = 0.091:0.091:0.091,
     tpllh$S0$Y = 0.079:0.079:0.079,
     tplhl$S0$Y = 0.1:0.1:0.1,
     tphlh$S0$Y = 0.098:0.098:0.098,
     tphhl$S0$Y = 0.083:0.083:0.083;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX2X4 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.082:0.082:0.082,
     tphhl$A$Y = 0.086:0.086:0.086,
     tpllh$B$Y = 0.081:0.081:0.081,
     tphhl$B$Y = 0.086:0.086:0.086,
     tpllh$S0$Y = 0.075:0.075:0.075,
     tplhl$S0$Y = 0.097:0.097:0.097,
     tphlh$S0$Y = 0.095:0.095:0.095,
     tphhl$S0$Y = 0.08:0.08:0.08;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX2X6 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.092:0.092:0.092,
     tphhl$A$Y = 0.098:0.098:0.098,
     tpllh$B$Y = 0.092:0.092:0.092,
     tphhl$B$Y = 0.099:0.099:0.099,
     tpllh$S0$Y = 0.086:0.086:0.086,
     tplhl$S0$Y = 0.11:0.11:0.11,
     tphlh$S0$Y = 0.1:0.1:0.1,
     tphhl$S0$Y = 0.092:0.092:0.092;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX2XL (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.12:0.12:0.12,
     tphhl$A$Y = 0.12:0.12:0.12,
     tpllh$B$Y = 0.12:0.12:0.12,
     tphhl$B$Y = 0.12:0.12:0.12,
     tpllh$S0$Y = 0.11:0.11:0.11,
     tplhl$S0$Y = 0.13:0.13:0.13,
     tphlh$S0$Y = 0.13:0.13:0.13,
     tphhl$S0$Y = 0.11:0.11:0.11;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX3X1 (A, B, C, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (Y, I0_out, C, S1);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.14:0.14:0.14,
     tphhl$A$Y = 0.14:0.14:0.14,
     tpllh$B$Y = 0.14:0.14:0.14,
     tphhl$B$Y = 0.15:0.15:0.15,
     tpllh$C$Y = 0.093:0.093:0.093,
     tphhl$C$Y = 0.097:0.097:0.097,
     tpllh$S0$Y = 0.13:0.13:0.13,
     tplhl$S0$Y = 0.16:0.16:0.16,
     tphlh$S0$Y = 0.15:0.15:0.15,
     tphhl$S0$Y = 0.14:0.14:0.14,
     tpllh$S1$Y = 0.087:0.087:0.087,
     tplhl$S1$Y = 0.11:0.11:0.11,
     tphlh$S1$Y = 0.1:0.1:0.1,
     tphhl$S1$Y = 0.1:0.1:0.1;

      // path delays
      (posedge S1 *> (Y +: C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: S0?B:A)) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: S1?C:B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: S1?C:A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX3X2 (A, B, C, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (Y, I0_out, C, S1);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.13:0.13:0.13,
     tphhl$A$Y = 0.14:0.14:0.14,
     tpllh$B$Y = 0.13:0.13:0.13,
     tphhl$B$Y = 0.14:0.14:0.14,
     tpllh$C$Y = 0.085:0.085:0.085,
     tphhl$C$Y = 0.089:0.089:0.089,
     tpllh$S0$Y = 0.12:0.12:0.12,
     tplhl$S0$Y = 0.15:0.15:0.15,
     tphlh$S0$Y = 0.14:0.14:0.14,
     tphhl$S0$Y = 0.13:0.13:0.13,
     tpllh$S1$Y = 0.078:0.078:0.078,
     tplhl$S1$Y = 0.099:0.099:0.099,
     tphlh$S1$Y = 0.094:0.094:0.094,
     tphhl$S1$Y = 0.096:0.096:0.096;

      // path delays
      (posedge S1 *> (Y +: C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: S0?B:A)) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: S1?C:B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: S1?C:A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX3X4 (A, B, C, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (Y, I0_out, C, S1);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.15:0.15:0.15,
     tphhl$A$Y = 0.16:0.16:0.16,
     tpllh$B$Y = 0.15:0.15:0.15,
     tphhl$B$Y = 0.16:0.16:0.16,
     tpllh$C$Y = 0.074:0.074:0.074,
     tphhl$C$Y = 0.078:0.078:0.078,
     tpllh$S0$Y = 0.14:0.14:0.14,
     tplhl$S0$Y = 0.17:0.17:0.17,
     tphlh$S0$Y = 0.16:0.16:0.16,
     tphhl$S0$Y = 0.15:0.15:0.15,
     tpllh$S1$Y = 0.067:0.067:0.067,
     tplhl$S1$Y = 0.09:0.09:0.09,
     tphlh$S1$Y = 0.11:0.11:0.11,
     tphhl$S1$Y = 0.11:0.11:0.11;

      // path delays
      (posedge S1 *> (Y +: C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: S0?B:A)) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: S1?C:B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: S1?C:A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX4X4 (A, B, C, D, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (Y, I1_out, I0_out, S1);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.16:0.16:0.16,
     tphhl$A$Y = 0.16:0.16:0.16,
     tpllh$B$Y = 0.15:0.15:0.15,
     tphhl$B$Y = 0.16:0.16:0.16,
     tpllh$C$Y = 0.16:0.16:0.16,
     tphhl$C$Y = 0.17:0.17:0.17,
     tpllh$D$Y = 0.16:0.16:0.16,
     tphhl$D$Y = 0.17:0.17:0.17,
     tpllh$S0$Y = 0.15:0.15:0.15,
     tplhl$S0$Y = 0.18:0.18:0.19,
     tphlh$S0$Y = 0.17:0.18:0.18,
     tphhl$S0$Y = 0.16:0.16:0.16,
     tpllh$S1$Y = 0.098:0.098:0.098,
     tplhl$S1$Y = 0.11:0.11:0.11,
     tphlh$S1$Y = 0.11:0.11:0.11,
     tphhl$S1$Y = 0.11:0.11:0.11;

      // path delays
      (posedge S1 *> (Y +: S0?D:C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: S0?B:A)) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: S1?D:B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: S1?C:A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI2X1 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.098:0.098:0.098,
     tphlh$A$Y = 0.098:0.098:0.098,
     tplhl$B$Y = 0.097:0.097:0.097,
     tphlh$B$Y = 0.098:0.098:0.098,
     tpllh$S0$Y = 0.11:0.11:0.11,
     tplhl$S0$Y = 0.091:0.091:0.091,
     tphlh$S0$Y = 0.091:0.091:0.091,
     tphhl$S0$Y = 0.11:0.11:0.11;

      // path delays
      (posedge S0 *> (Y +: !B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI2X6 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.093:0.093:0.093,
     tphlh$A$Y = 0.095:0.095:0.095,
     tplhl$B$Y = 0.093:0.093:0.093,
     tphlh$B$Y = 0.096:0.096:0.096,
     tpllh$S0$Y = 0.11:0.11:0.11,
     tplhl$S0$Y = 0.086:0.086:0.086,
     tphlh$S0$Y = 0.088:0.088:0.088,
     tphhl$S0$Y = 0.1:0.1:0.1;

      // path delays
      (posedge S0 *> (Y +: !B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI2XL (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.15:0.15:0.15,
     tphlh$A$Y = 0.15:0.15:0.15,
     tplhl$B$Y = 0.15:0.15:0.15,
     tphlh$B$Y = 0.15:0.15:0.15,
     tpllh$S0$Y = 0.17:0.17:0.17,
     tplhl$S0$Y = 0.14:0.14:0.14,
     tphlh$S0$Y = 0.15:0.15:0.15,
     tphhl$S0$Y = 0.16:0.16:0.16;

      // path delays
      (posedge S0 *> (Y +: !B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI3X1 (A, B, C, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (I1_out, I0_out, C, S1);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.14:0.14:0.14,
     tphlh$A$Y = 0.14:0.14:0.14,
     tplhl$B$Y = 0.14:0.14:0.14,
     tphlh$B$Y = 0.14:0.14:0.14,
     tplhl$C$Y = 0.12:0.12:0.12,
     tphlh$C$Y = 0.11:0.11:0.11,
     tpllh$S0$Y = 0.15:0.15:0.15,
     tplhl$S0$Y = 0.13:0.13:0.13,
     tphlh$S0$Y = 0.13:0.13:0.13,
     tphhl$S0$Y = 0.15:0.15:0.15,
     tpllh$S1$Y = 0.093:0.093:0.093,
     tplhl$S1$Y = 0.11:0.11:0.11,
     tphlh$S1$Y = 0.11:0.11:0.11,
     tphhl$S1$Y = 0.096:0.096:0.096;

      // path delays
      (posedge S1 *> (Y +: !C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: !(S0?B:A))) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: !(S1?C:B))) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !(S1?C:A))) = (tphlh$S0$Y, tphhl$S0$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI3X4 (A, B, C, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (I1_out, I0_out, C, S1);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.13:0.13:0.13,
     tphlh$A$Y = 0.13:0.13:0.13,
     tplhl$B$Y = 0.13:0.13:0.13,
     tphlh$B$Y = 0.13:0.13:0.13,
     tplhl$C$Y = 0.1:0.1:0.1,
     tphlh$C$Y = 0.098:0.098:0.098,
     tpllh$S0$Y = 0.14:0.14:0.14,
     tplhl$S0$Y = 0.12:0.12:0.12,
     tphlh$S0$Y = 0.12:0.12:0.12,
     tphhl$S0$Y = 0.14:0.14:0.14,
     tpllh$S1$Y = 0.075:0.075:0.075,
     tplhl$S1$Y = 0.095:0.095:0.095,
     tphlh$S1$Y = 0.092:0.092:0.092,
     tphhl$S1$Y = 0.078:0.078:0.078;

      // path delays
      (posedge S1 *> (Y +: !C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: !(S0?B:A))) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: !(S1?C:B))) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !(S1?C:A))) = (tphlh$S0$Y, tphhl$S0$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI4X2 (A, B, C, D, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (I2_out, I1_out, I0_out, S1);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.14:0.14:0.14,
     tphlh$A$Y = 0.14:0.14:0.14,
     tplhl$B$Y = 0.14:0.14:0.14,
     tphlh$B$Y = 0.14:0.14:0.14,
     tplhl$C$Y = 0.15:0.15:0.15,
     tphlh$C$Y = 0.15:0.15:0.15,
     tplhl$D$Y = 0.15:0.15:0.15,
     tphlh$D$Y = 0.15:0.15:0.15,
     tpllh$S0$Y = 0.16:0.16:0.17,
     tplhl$S0$Y = 0.14:0.14:0.14,
     tphlh$S0$Y = 0.13:0.14:0.14,
     tphhl$S0$Y = 0.16:0.17:0.17,
     tpllh$S1$Y = 0.086:0.086:0.086,
     tplhl$S1$Y = 0.11:0.11:0.11,
     tphlh$S1$Y = 0.11:0.11:0.11,
     tphhl$S1$Y = 0.089:0.089:0.089;

      // path delays
      (posedge S1 *> (Y +: !(S0?D:C))) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: !(S0?B:A))) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: !(S1?D:B))) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !(S1?C:A))) = (tphlh$S0$Y, tphhl$S0$Y);
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI4XL (A, B, C, D, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (I2_out, I1_out, I0_out, S1);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.16:0.16:0.16,
     tphlh$A$Y = 0.16:0.16:0.16,
     tplhl$B$Y = 0.16:0.16:0.16,
     tphlh$B$Y = 0.17:0.17:0.17,
     tplhl$C$Y = 0.16:0.16:0.16,
     tphlh$C$Y = 0.16:0.16:0.16,
     tplhl$D$Y = 0.16:0.16:0.16,
     tphlh$D$Y = 0.16:0.16:0.16,
     tpllh$S0$Y = 0.18:0.18:0.18,
     tplhl$S0$Y = 0.15:0.16:0.16,
     tphlh$S0$Y = 0.15:0.16:0.16,
     tphhl$S0$Y = 0.18:0.18:0.19,
     tpllh$S1$Y = 0.11:0.11:0.11,
     tplhl$S1$Y = 0.13:0.13:0.13,
     tphlh$S1$Y = 0.13:0.13:0.13,
     tphhl$S1$Y = 0.11:0.11:0.11;

      // path delays
      (posedge S1 *> (Y +: !(S0?D:C))) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: !(S0?B:A))) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: !(S1?D:B))) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !(S1?C:A))) = (tphlh$S0$Y, tphhl$S0$Y);
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND2BX1 (AN, B, Y);
   input  AN ;
   input  B ;
   output Y ;

   not (I0_out, AN);
   and (I1_out, I0_out, B);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.067:0.067:0.067,
     tphhl$AN$Y = 0.11:0.11:0.11,
     tplhl$B$Y = 0.088:0.088:0.088,
     tphlh$B$Y = 0.049:0.049:0.049;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND2BX2 (AN, B, Y);
   input  AN ;
   input  B ;
   output Y ;

   not (I0_out, AN);
   and (I1_out, I0_out, B);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.055:0.055:0.055,
     tphhl$AN$Y = 0.077:0.077:0.077,
     tplhl$B$Y = 0.05:0.05:0.05,
     tphlh$B$Y = 0.029:0.029:0.029;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND2BXL (AN, B, Y);
   input  AN ;
   input  B ;
   output Y ;

   not (I0_out, AN);
   and (I1_out, I0_out, B);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.094:0.094:0.094,
     tphhl$AN$Y = 0.16:0.16:0.16,
     tplhl$B$Y = 0.14:0.14:0.14,
     tphlh$B$Y = 0.079:0.079:0.079;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND2X6 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.028:0.028:0.028,
     tphlh$A$Y = 0.016:0.016:0.016,
     tplhl$B$Y = 0.025:0.025:0.025,
     tphlh$B$Y = 0.015:0.015:0.015;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND3BX4 (AN, B, C, Y);
   input  AN ;
   input  B ;
   input  C ;
   output Y ;

   not (I0_out, AN);
   and (I2_out, I0_out, B, C);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.051:0.051:0.051,
     tphhl$AN$Y = 0.081:0.081:0.081,
     tplhl$B$Y = 0.052:0.052:0.052,
     tphlh$B$Y = 0.021:0.021:0.021,
     tplhl$C$Y = 0.047:0.047:0.047,
     tphlh$C$Y = 0.019:0.019:0.019;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND3BXL (AN, B, C, Y);
   input  AN ;
   input  B ;
   input  C ;
   output Y ;

   not (I0_out, AN);
   and (I2_out, I0_out, B, C);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.098:0.098:0.098,
     tphhl$AN$Y = 0.23:0.23:0.23,
     tplhl$B$Y = 0.21:0.21:0.21,
     tphlh$B$Y = 0.082:0.082:0.082,
     tplhl$C$Y = 0.21:0.21:0.21,
     tphlh$C$Y = 0.081:0.081:0.081;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND3X1 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.14:0.14:0.14,
     tphlh$A$Y = 0.052:0.052:0.052,
     tplhl$B$Y = 0.13:0.13:0.13,
     tphlh$B$Y = 0.051:0.051:0.051,
     tplhl$C$Y = 0.13:0.13:0.13,
     tphlh$C$Y = 0.05:0.05:0.05;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND3X4 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.054:0.054:0.054,
     tphlh$A$Y = 0.022:0.022:0.022,
     tplhl$B$Y = 0.052:0.052:0.052,
     tphlh$B$Y = 0.021:0.021:0.021,
     tplhl$C$Y = 0.047:0.047:0.047,
     tphlh$C$Y = 0.019:0.019:0.019;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND3X6 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.046:0.046:0.046,
     tphlh$A$Y = 0.018:0.018:0.018,
     tplhl$B$Y = 0.043:0.043:0.043,
     tphlh$B$Y = 0.017:0.017:0.017,
     tplhl$C$Y = 0.039:0.039:0.039,
     tphlh$C$Y = 0.016:0.016:0.016;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND3XL (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.21:0.21:0.21,
     tphlh$A$Y = 0.083:0.083:0.083,
     tplhl$B$Y = 0.21:0.21:0.21,
     tphlh$B$Y = 0.082:0.082:0.082,
     tplhl$C$Y = 0.21:0.21:0.21,
     tphlh$C$Y = 0.08:0.08:0.08;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4BBX2 (AN, BN, C, D, Y);
   input  AN ;
   input  BN ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   and (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.06:0.06:0.06,
     tphhl$AN$Y = 0.15:0.15:0.15,
     tpllh$BN$Y = 0.062:0.062:0.062,
     tphhl$BN$Y = 0.15:0.15:0.15,
     tplhl$C$Y = 0.11:0.11:0.11,
     tphlh$C$Y = 0.033:0.033:0.033,
     tplhl$D$Y = 0.1:0.1:0.1,
     tphlh$D$Y = 0.03:0.03:0.03;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4BBXL (AN, BN, C, D, Y);
   input  AN ;
   input  BN ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   not (I1_out, BN);
   and (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.1:0.1:0.1,
     tphhl$AN$Y = 0.3:0.3:0.3,
     tpllh$BN$Y = 0.1:0.1:0.1,
     tphhl$BN$Y = 0.3:0.3:0.3,
     tplhl$C$Y = 0.28:0.28:0.28,
     tphlh$C$Y = 0.084:0.084:0.084,
     tplhl$D$Y = 0.28:0.28:0.28,
     tphlh$D$Y = 0.082:0.082:0.082;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4X2 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.12:0.12:0.12,
     tphlh$A$Y = 0.035:0.035:0.035,
     tplhl$B$Y = 0.11:0.11:0.11,
     tphlh$B$Y = 0.034:0.034:0.034,
     tplhl$C$Y = 0.11:0.11:0.11,
     tphlh$C$Y = 0.033:0.033:0.033,
     tplhl$D$Y = 0.1:0.1:0.1,
     tphlh$D$Y = 0.032:0.032:0.032;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4X6 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.075:0.075:0.075,
     tphlh$A$Y = 0.021:0.021:0.021,
     tplhl$B$Y = 0.071:0.071:0.071,
     tphlh$B$Y = 0.02:0.02:0.02,
     tplhl$C$Y = 0.065:0.065:0.065,
     tphlh$C$Y = 0.019:0.019:0.019,
     tplhl$D$Y = 0.055:0.055:0.055,
     tphlh$D$Y = 0.017:0.017:0.017;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR2BX1 (AN, B, Y);
   input  AN ;
   input  B ;
   output Y ;

   not (I0_out, AN);
   or  (I1_out, I0_out, B);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.11:0.11:0.11,
     tphhl$AN$Y = 0.068:0.068:0.068,
     tplhl$B$Y = 0.049:0.049:0.049,
     tphlh$B$Y = 0.089:0.089:0.089;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR2BX2 (AN, B, Y);
   input  AN ;
   input  B ;
   output Y ;

   not (I0_out, AN);
   or  (I1_out, I0_out, B);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.077:0.077:0.077,
     tphhl$AN$Y = 0.058:0.058:0.058,
     tplhl$B$Y = 0.029:0.029:0.029,
     tphlh$B$Y = 0.05:0.05:0.05;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR2BX4 (AN, B, Y);
   input  AN ;
   input  B ;
   output Y ;

   not (I0_out, AN);
   or  (I1_out, I0_out, B);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.073:0.073:0.073,
     tphhl$AN$Y = 0.064:0.064:0.064,
     tplhl$B$Y = 0.018:0.018:0.018,
     tphlh$B$Y = 0.03:0.03:0.03;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR2BXL (AN, B, Y);
   input  AN ;
   input  B ;
   output Y ;

   not (I0_out, AN);
   or  (I1_out, I0_out, B);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.16:0.16:0.16,
     tphhl$AN$Y = 0.094:0.094:0.094,
     tplhl$B$Y = 0.078:0.078:0.078,
     tphlh$B$Y = 0.15:0.15:0.15;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR2X1 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.051:0.051:0.051,
     tphlh$A$Y = 0.092:0.092:0.092,
     tplhl$B$Y = 0.049:0.049:0.049,
     tphlh$B$Y = 0.088:0.088:0.088;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR2X2 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.03:0.03:0.03,
     tphlh$A$Y = 0.052:0.052:0.052,
     tplhl$B$Y = 0.029:0.029:0.029,
     tphlh$B$Y = 0.049:0.049:0.049;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR2X4 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.02:0.02:0.02,
     tphlh$A$Y = 0.033:0.033:0.033,
     tplhl$B$Y = 0.018:0.018:0.018,
     tphlh$B$Y = 0.03:0.03:0.03;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR2X6 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.017:0.017:0.017,
     tphlh$A$Y = 0.026:0.026:0.026,
     tplhl$B$Y = 0.015:0.015:0.015,
     tphlh$B$Y = 0.023:0.023:0.023;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR2XL (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.079:0.079:0.079,
     tphlh$A$Y = 0.15:0.15:0.15,
     tplhl$B$Y = 0.077:0.077:0.077,
     tphlh$B$Y = 0.15:0.15:0.15;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR3BX1 (AN, B, C, Y);
   input  AN ;
   input  B ;
   input  C ;
   output Y ;

   not (I0_out, AN);
   or  (I2_out, I0_out, B, C);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.16:0.16:0.16,
     tphhl$AN$Y = 0.071:0.071:0.071,
     tplhl$B$Y = 0.052:0.052:0.052,
     tphlh$B$Y = 0.14:0.14:0.14,
     tplhl$C$Y = 0.05:0.05:0.05,
     tphlh$C$Y = 0.13:0.13:0.13;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR3BX2 (AN, B, C, Y);
   input  AN ;
   input  B ;
   input  C ;
   output Y ;

   not (I0_out, AN);
   or  (I2_out, I0_out, B, C);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.11:0.11:0.11,
     tphhl$AN$Y = 0.064:0.064:0.064,
     tplhl$B$Y = 0.032:0.032:0.032,
     tphlh$B$Y = 0.082:0.082:0.082,
     tplhl$C$Y = 0.03:0.03:0.03,
     tphlh$C$Y = 0.075:0.075:0.075;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR3BXL (AN, B, C, Y);
   input  AN ;
   input  B ;
   input  C ;
   output Y ;

   not (I0_out, AN);
   or  (I2_out, I0_out, B, C);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.24:0.24:0.24,
     tphhl$AN$Y = 0.098:0.098:0.098,
     tplhl$B$Y = 0.081:0.081:0.081,
     tphlh$B$Y = 0.22:0.22:0.22,
     tplhl$C$Y = 0.079:0.079:0.079,
     tphlh$C$Y = 0.22:0.22:0.22;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR3X1 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.054:0.054:0.054,
     tphlh$A$Y = 0.14:0.14:0.14,
     tplhl$B$Y = 0.052:0.052:0.052,
     tphlh$B$Y = 0.14:0.14:0.14,
     tplhl$C$Y = 0.05:0.05:0.05,
     tphlh$C$Y = 0.13:0.13:0.13;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4BBX2 (AN, BN, C, D, Y);
   input  AN ;
   input  BN ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   or  (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.15:0.15:0.15,
     tphhl$AN$Y = 0.062:0.062:0.062,
     tpllh$BN$Y = 0.15:0.15:0.15,
     tphhl$BN$Y = 0.064:0.064:0.064,
     tplhl$C$Y = 0.033:0.033:0.033,
     tphlh$C$Y = 0.11:0.11:0.11,
     tplhl$D$Y = 0.029:0.029:0.029,
     tphlh$D$Y = 0.098:0.098:0.098;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4BBX4 (AN, BN, C, D, Y);
   input  AN ;
   input  BN ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   or  (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.11:0.11:0.11,
     tphhl$AN$Y = 0.052:0.052:0.052,
     tpllh$BN$Y = 0.11:0.11:0.11,
     tphhl$BN$Y = 0.052:0.052:0.052,
     tplhl$C$Y = 0.022:0.022:0.022,
     tphlh$C$Y = 0.074:0.074:0.074,
     tplhl$D$Y = 0.02:0.02:0.02,
     tphlh$D$Y = 0.059:0.059:0.059;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4BBXL (AN, BN, C, D, Y);
   input  AN ;
   input  BN ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   not (I1_out, BN);
   or  (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.32:0.32:0.32,
     tphhl$AN$Y = 0.1:0.1:0.1,
     tpllh$BN$Y = 0.32:0.32:0.32,
     tphhl$BN$Y = 0.1:0.1:0.1,
     tplhl$C$Y = 0.082:0.082:0.082,
     tphlh$C$Y = 0.3:0.3:0.3,
     tplhl$D$Y = 0.08:0.08:0.08,
     tphlh$D$Y = 0.29:0.29:0.29;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4X2 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.035:0.035:0.035,
     tphlh$A$Y = 0.12:0.12:0.12,
     tplhl$B$Y = 0.034:0.034:0.034,
     tphlh$B$Y = 0.12:0.12:0.12,
     tplhl$C$Y = 0.032:0.032:0.032,
     tphlh$C$Y = 0.11:0.11:0.11,
     tplhl$D$Y = 0.031:0.031:0.031,
     tphlh$D$Y = 0.098:0.098:0.098;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4X6 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.022:0.022:0.022,
     tphlh$A$Y = 0.075:0.075:0.075,
     tplhl$B$Y = 0.021:0.021:0.021,
     tphlh$B$Y = 0.071:0.071:0.071,
     tplhl$C$Y = 0.02:0.02:0.02,
     tphlh$C$Y = 0.062:0.062:0.062,
     tplhl$D$Y = 0.017:0.017:0.017,
     tphlh$D$Y = 0.047:0.047:0.047;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OA21X1 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (Y, I0_out, B0);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.094:0.094:0.094,
     tphhl$A0$Y = 0.098:0.098:0.098,
     tpllh$A1$Y = 0.088:0.088:0.088,
     tphhl$A1$Y = 0.094:0.094:0.094,
     tpllh$B0$Y = 0.073:0.08:0.087,
     tphhl$B0$Y = 0.068:0.069:0.071;

      // path delays
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OA22X1 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (Y, I0_out, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.091:0.099:0.11,
     tphhl$A0$Y = 0.1:0.11:0.11,
     tpllh$A1$Y = 0.087:0.094:0.1,
     tphhl$A1$Y = 0.1:0.1:0.11,
     tpllh$B0$Y = 0.081:0.089:0.097,
     tphhl$B0$Y = 0.092:0.095:0.099,
     tpllh$B1$Y = 0.076:0.083:0.09,
     tphhl$B1$Y = 0.088:0.091:0.094;

      // path delays
      (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OA22X2 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (Y, I0_out, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.08:0.089:0.098,
     tphhl$A0$Y = 0.096:0.099:0.1,
     tpllh$A1$Y = 0.076:0.085:0.093,
     tphhl$A1$Y = 0.093:0.096:0.099,
     tpllh$B0$Y = 0.07:0.079:0.088,
     tphhl$B0$Y = 0.085:0.088:0.09,
     tpllh$B1$Y = 0.065:0.073:0.082,
     tphhl$B1$Y = 0.081:0.084:0.086;

      // path delays
      (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI211X2 (A0, A1, B0, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  C0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.096:0.096:0.096,
     tphlh$A0$Y = 0.065:0.065:0.065,
     tplhl$A1$Y = 0.09:0.09:0.09,
     tphlh$A1$Y = 0.062:0.062:0.062,
     tplhl$B0$Y = 0.071:0.081:0.091,
     tphlh$B0$Y = 0.032:0.032:0.032,
     tplhl$C0$Y = 0.065:0.075:0.084,
     tphlh$C0$Y = 0.029:0.029:0.029;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI211X4 (A0, A1, B0, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  C0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.067:0.067:0.067,
     tphlh$A0$Y = 0.045:0.045:0.045,
     tplhl$A1$Y = 0.061:0.061:0.061,
     tphlh$A1$Y = 0.042:0.042:0.042,
     tplhl$B0$Y = 0.047:0.055:0.063,
     tphlh$B0$Y = 0.021:0.021:0.021,
     tplhl$C0$Y = 0.042:0.049:0.056,
     tphlh$C0$Y = 0.019:0.019:0.019;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI21X4 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (I1_out, I0_out, B0);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.04:0.04:0.04,
     tphlh$A0$Y = 0.039:0.039:0.039,
     tplhl$A1$Y = 0.037:0.037:0.037,
     tphlh$A1$Y = 0.036:0.036:0.036,
     tplhl$B0$Y = 0.024:0.03:0.036,
     tphlh$B0$Y = 0.018:0.018:0.018;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI21XL (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (I1_out, I0_out, B0);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.15:0.15:0.15,
     tphlh$A0$Y = 0.16:0.16:0.16,
     tplhl$A1$Y = 0.15:0.15:0.15,
     tphlh$A1$Y = 0.15:0.15:0.15,
     tplhl$B0$Y = 0.11:0.13:0.15,
     tphlh$B0$Y = 0.079:0.079:0.079;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI221XL (A0, A1, B0, B1, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.2:0.22:0.25,
     tphlh$A0$Y = 0.17:0.17:0.17,
     tplhl$A1$Y = 0.2:0.22:0.24,
     tphlh$A1$Y = 0.17:0.17:0.17,
     tplhl$B0$Y = 0.19:0.22:0.24,
     tphlh$B0$Y = 0.16:0.16:0.16,
     tplhl$B1$Y = 0.19:0.21:0.23,
     tphlh$B1$Y = 0.16:0.16:0.16,
     tplhl$C0$Y = 0.14:0.18:0.23,
     tphlh$C0$Y = 0.082:0.082:0.082;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI222X2 (A0, A1, B0, B1, C0, C1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   input  C1 ;
   output Y ;

   or  (I0_out, C0, C1);
   or  (I1_out, A0, A1);
   or  (I3_out, B0, B1);
   and (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.075:0.096:0.12,
     tphlh$A0$Y = 0.07:0.072:0.074,
     tplhl$A1$Y = 0.071:0.092:0.11,
     tphlh$A1$Y = 0.067:0.069:0.07,
     tplhl$B0$Y = 0.069:0.091:0.11,
     tphlh$B0$Y = 0.065:0.066:0.067,
     tplhl$B1$Y = 0.065:0.085:0.11,
     tphlh$B1$Y = 0.062:0.063:0.063,
     tplhl$C0$Y = 0.058:0.078:0.099,
     tphlh$C0$Y = 0.058:0.058:0.058,
     tplhl$C1$Y = 0.054:0.074:0.094,
     tphlh$C1$Y = 0.055:0.055:0.055;

      // path delays
      (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI222X4 (A0, A1, B0, B1, C0, C1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   input  C1 ;
   output Y ;

   or  (I0_out, C0, C1);
   or  (I1_out, A0, A1);
   or  (I3_out, B0, B1);
   and (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.054:0.071:0.088,
     tphlh$A0$Y = 0.049:0.051:0.052,
     tplhl$A1$Y = 0.05:0.066:0.082,
     tphlh$A1$Y = 0.046:0.048:0.049,
     tplhl$B0$Y = 0.048:0.065:0.082,
     tphlh$B0$Y = 0.044:0.045:0.046,
     tplhl$B1$Y = 0.044:0.059:0.075,
     tphlh$B1$Y = 0.041:0.042:0.043,
     tplhl$C0$Y = 0.038:0.054:0.069,
     tphlh$C0$Y = 0.038:0.038:0.038,
     tplhl$C1$Y = 0.034:0.049:0.064,
     tphlh$C1$Y = 0.035:0.035:0.035;

      // path delays
      (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI22X1 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   or  (I1_out, A0, A1);
   and (I2_out, I0_out, I1_out);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.083:0.096:0.11,
     tphlh$A0$Y = 0.1:0.1:0.1,
     tplhl$A1$Y = 0.079:0.091:0.1,
     tphlh$A1$Y = 0.098:0.099:0.1,
     tplhl$B0$Y = 0.073:0.087:0.1,
     tphlh$B0$Y = 0.095:0.095:0.095,
     tplhl$B1$Y = 0.069:0.083:0.097,
     tphlh$B1$Y = 0.091:0.091:0.092;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI22X2 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   or  (I1_out, A0, A1);
   and (I2_out, I0_out, I1_out);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.051:0.059:0.067,
     tphlh$A0$Y = 0.062:0.062:0.063,
     tplhl$A1$Y = 0.048:0.056:0.064,
     tphlh$A1$Y = 0.059:0.059:0.06,
     tplhl$B0$Y = 0.043:0.052:0.06,
     tphlh$B0$Y = 0.055:0.055:0.055,
     tplhl$B1$Y = 0.041:0.049:0.057,
     tphlh$B1$Y = 0.052:0.052:0.052;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI2BB1X2 (A0N, A1N, B0, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.081:0.081:0.081,
     tphhl$A0N$Y = 0.08:0.08:0.08,
     tpllh$A1N$Y = 0.078:0.078:0.078,
     tphhl$A1N$Y = 0.078:0.078:0.078,
     tplhl$B0$Y = 0.053:0.053:0.054,
     tphlh$B0$Y = 0.029:0.029:0.029;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI2BB2X1 (A0N, A1N, B0, B1, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   and (I1_out, A0N, A1N);
   not (I2_out, I1_out);
   and (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.12:0.12:0.12,
     tphhl$A0N$Y = 0.1:0.11:0.13,
     tpllh$A1N$Y = 0.12:0.12:0.12,
     tphhl$A1N$Y = 0.099:0.11:0.12,
     tplhl$B0$Y = 0.073:0.087:0.1,
     tphlh$B0$Y = 0.094:0.094:0.095,
     tplhl$B1$Y = 0.069:0.083:0.097,
     tphlh$B1$Y = 0.091:0.091:0.091;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI2BB2XL (A0N, A1N, B0, B1, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   and (I1_out, A0N, A1N);
   not (I2_out, I1_out);
   and (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.18:0.18:0.18,
     tphhl$A0N$Y = 0.14:0.16:0.18,
     tpllh$A1N$Y = 0.18:0.18:0.18,
     tphhl$A1N$Y = 0.14:0.16:0.18,
     tplhl$B0$Y = 0.11:0.13:0.15,
     tphlh$B0$Y = 0.15:0.15:0.15,
     tplhl$B1$Y = 0.11:0.13:0.15,
     tphlh$B1$Y = 0.15:0.15:0.15;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI31XL (A0, A1, A2, B0, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   output Y ;

   or  (I1_out, A0, A1, A2);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.16:0.16:0.16,
     tphlh$A0$Y = 0.24:0.24:0.24,
     tplhl$A1$Y = 0.15:0.15:0.15,
     tphlh$A1$Y = 0.23:0.23:0.23,
     tplhl$A2$Y = 0.15:0.15:0.15,
     tphlh$A2$Y = 0.23:0.23:0.23,
     tplhl$B0$Y = 0.096:0.12:0.15,
     tphlh$B0$Y = 0.079:0.079:0.08;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI32XL (A0, A1, A2, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   or  (I2_out, A0, A1, A2);
   and (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.13:0.15:0.17,
     tphlh$A0$Y = 0.25:0.25:0.25,
     tplhl$A1$Y = 0.13:0.15:0.17,
     tphlh$A1$Y = 0.24:0.24:0.24,
     tplhl$A2$Y = 0.12:0.14:0.16,
     tphlh$A2$Y = 0.23:0.24:0.24,
     tplhl$B0$Y = 0.1:0.13:0.16,
     tphlh$B0$Y = 0.15:0.15:0.15,
     tplhl$B1$Y = 0.098:0.13:0.15,
     tphlh$B1$Y = 0.15:0.15:0.15;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI33X1 (A0, A1, A2, B0, B1, B2, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   input  B2 ;
   output Y ;

   or  (I1_out, B0, B1, B2);
   or  (I3_out, A0, A1, A2);
   and (I4_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.083:0.1:0.12,
     tphlh$A0$Y = 0.16:0.16:0.16,
     tplhl$A1$Y = 0.08:0.099:0.12,
     tphlh$A1$Y = 0.16:0.16:0.16,
     tplhl$A2$Y = 0.076:0.094:0.11,
     tphlh$A2$Y = 0.15:0.15:0.16,
     tplhl$B0$Y = 0.07:0.091:0.11,
     tphlh$B0$Y = 0.15:0.15:0.15,
     tplhl$B1$Y = 0.068:0.088:0.11,
     tphlh$B1$Y = 0.14:0.14:0.14,
     tplhl$B2$Y = 0.064:0.083:0.1,
     tphlh$B2$Y = 0.14:0.14:0.14;

      // path delays
      (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI33X2 (A0, A1, A2, B0, B1, B2, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   input  B2 ;
   output Y ;

   or  (I1_out, B0, B1, B2);
   or  (I3_out, A0, A1, A2);
   and (I4_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.056:0.07:0.083,
     tphlh$A0$Y = 0.11:0.11:0.11,
     tplhl$A1$Y = 0.053:0.066:0.078,
     tphlh$A1$Y = 0.1:0.1:0.11,
     tplhl$A2$Y = 0.049:0.061:0.074,
     tphlh$A2$Y = 0.094:0.097:0.099,
     tplhl$B0$Y = 0.043:0.057:0.072,
     tphlh$B0$Y = 0.088:0.088:0.088,
     tplhl$B1$Y = 0.041:0.054:0.068,
     tphlh$B1$Y = 0.085:0.085:0.085,
     tplhl$B2$Y = 0.038:0.051:0.063,
     tphlh$B2$Y = 0.078:0.078:0.079;

      // path delays
      (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI33XL (A0, A1, A2, B0, B1, B2, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   input  B2 ;
   output Y ;

   or  (I1_out, B0, B1, B2);
   or  (I3_out, A0, A1, A2);
   and (I4_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.13:0.15:0.18,
     tphlh$A0$Y = 0.25:0.26:0.26,
     tplhl$A1$Y = 0.12:0.15:0.17,
     tphlh$A1$Y = 0.25:0.25:0.26,
     tplhl$A2$Y = 0.12:0.14:0.17,
     tphlh$A2$Y = 0.24:0.25:0.25,
     tplhl$B0$Y = 0.11:0.14:0.17,
     tphlh$B0$Y = 0.23:0.23:0.23,
     tplhl$B1$Y = 0.1:0.13:0.16,
     tphlh$B1$Y = 0.23:0.23:0.23,
     tplhl$B2$Y = 0.1:0.13:0.16,
     tphlh$B2$Y = 0.22:0.22:0.22;

      // path delays
      (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR2XL (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.095:0.095:0.095,
     tphhl$A$Y = 0.11:0.11:0.11,
     tpllh$B$Y = 0.093:0.093:0.093,
     tphhl$B$Y = 0.11:0.11:0.11;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR3X2 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.061:0.061:0.061,
     tphhl$A$Y = 0.12:0.12:0.12,
     tpllh$B$Y = 0.059:0.059:0.059,
     tphhl$B$Y = 0.11:0.11:0.11,
     tpllh$C$Y = 0.056:0.056:0.056,
     tphhl$C$Y = 0.11:0.11:0.11;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR3X4 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.05:0.05:0.05,
     tphhl$A$Y = 0.1:0.1:0.1,
     tpllh$B$Y = 0.048:0.048:0.048,
     tphhl$B$Y = 0.099:0.099:0.099,
     tpllh$C$Y = 0.046:0.046:0.046,
     tphhl$C$Y = 0.093:0.093:0.093;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR4X4 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.053:0.053:0.053,
     tphhl$A$Y = 0.14:0.14:0.14,
     tpllh$B$Y = 0.052:0.052:0.052,
     tphhl$B$Y = 0.13:0.13:0.13,
     tpllh$C$Y = 0.049:0.049:0.049,
     tphhl$C$Y = 0.13:0.13:0.13,
     tpllh$D$Y = 0.046:0.046:0.046,
     tphhl$D$Y = 0.12:0.12:0.12;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR4X6 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.043:0.043:0.043,
     tphhl$A$Y = 0.11:0.11:0.11,
     tpllh$B$Y = 0.042:0.042:0.042,
     tphhl$B$Y = 0.11:0.11:0.11,
     tpllh$C$Y = 0.039:0.039:0.039,
     tphhl$C$Y = 0.1:0.1:0.1,
     tpllh$D$Y = 0.037:0.037:0.037,
     tphhl$D$Y = 0.09:0.09:0.09;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR4X8 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.045:0.045:0.045,
     tphhl$A$Y = 0.12:0.12:0.12,
     tpllh$B$Y = 0.044:0.044:0.044,
     tphhl$B$Y = 0.12:0.12:0.12,
     tpllh$C$Y = 0.042:0.042:0.042,
     tphhl$C$Y = 0.11:0.11:0.11,
     tpllh$D$Y = 0.04:0.04:0.04,
     tphhl$D$Y = 0.1:0.1:0.1;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR4XL (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.18:0.18:0.18,
     tpllh$B$Y = 0.1:0.1:0.1,
     tphhl$B$Y = 0.17:0.17:0.17,
     tpllh$C$Y = 0.1:0.1:0.1,
     tphhl$C$Y = 0.17:0.17:0.17,
     tpllh$D$Y = 0.099:0.099:0.099,
     tphhl$D$Y = 0.16:0.16:0.16;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFHQX8 (CK, D, Q, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I5_out, SI);
   not (I7_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I7_out);
   not (I9_out, D);
   not (I10_out, SE);
   not (I12_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.066:0.13:0.13,
     tminpwl$CK = 0.053:0.096:0.096,
     tsetup_negedge$D$CK = 0.044:0.044:0.044,
     thold_negedge$D$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_negedge$SE$CK = 0.081:0.081:0.081,
     thold_negedge$SE$CK = -0.05:-0.05:-0.05,


     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$D$CK = 0.069:0.069:0.069,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.056:0.056:0.056,
     thold_posedge$SE$CK = -0.012:-0.012:-0.012,


     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.037:-0.037:-0.037;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFNSRX2 (CKN, D, Q, QN, RN, SE, SI, SN);
   input  CKN ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   not (I14_out, SE);
   not (I16_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I13_out, I14_out, I16_out);
   not (I18_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I18_out, SN);
   not (I21_out, D);
   not (I23_out, SE);
   not (I25_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I21_out, RN, I23_out, I25_out, SN);
   not (I28_out, D);
   not (I29_out, SE);
   not (I31_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I28_out, I29_out, I31_out, SN);
   not (I34_out, D);
   not (I35_out, RN);
   not (I37_out, SE);
   not (I39_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I34_out, I35_out, I37_out, I39_out);

    specify
      // delay parameters
      specparam
	tphlh$CKN$Q = 0.15:0.15:0.15,
     tphhl$CKN$Q = 0.13:0.13:0.13,
     tphlh$CKN$QN = 0.16:0.16:0.16,
     tphhl$CKN$QN = 0.18:0.18:0.18,
     tphhl$RN$Q = 0.18:0.18:0.19,
     tphlh$RN$QN = 0.2:0.2:0.21,
     tplhl$SN$Q = 0.16:0.16:0.17,
     tphlh$SN$Q = 0.12:0.13:0.13,
     tpllh$SN$QN = 0.18:0.18:0.19,
     tphhl$SN$QN = 0.15:0.15:0.15,
     tminpwh$CKN = 0.05:0.11:0.11,
     tminpwl$CKN = 0.053:0.16:0.16,
     tminpwl$RN = 0.059:0.21:0.21,
     tminpwl$SN = 0.02:0.15:0.15,
     tsetup_negedge$D$CKN = 0.13:0.13:0.13,
     thold_negedge$D$CKN = -0.063:-0.063:-0.063,
     tsetup_negedge$SE$CKN = 0.12:0.12:0.12,
     thold_negedge$SE$CKN = -0.056:-0.031:-0.031,
     tsetup_negedge$SI$CKN = 0.13:0.13:0.13,
     thold_negedge$SI$CKN = -0.062:-0.062:-0.062,
     tsetup_posedge$D$CKN = 0.11:0.11:0.11,
     thold_posedge$D$CKN = -0.019:-0.019:-0.019,
     tsetup_posedge$SE$CKN = 0.1:0.14:0.14,
     thold_posedge$SE$CKN = -0.075:-0.013:-0.013,
     tsetup_posedge$SI$CKN = 0.11:0.11:0.11,
     thold_posedge$SI$CKN = -0.019:-0.019:-0.019,
     trec$RN$CKN = 0.044:0.044:0.044,
     trem$RN$CKN = 0.00000000022:0.00000000022:0.00000000022,
     trec$RN$SN = 0.075:0.081:0.081,
     trec$SN$CKN = 0.044:0.044:0.044,
     trem$SN$CKN = 0.013:0.013:0.013;

      // path delays
      (negedge CKN *> (QN -: SE?SI:D)) = (tphlh$CKN$QN, tphhl$CKN$QN);
      (negedge CKN *> (Q +: SE?SI:D)) = (tphlh$CKN$Q, tphhl$CKN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
      $setup(negedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CKN,  NOTIFIER);
      $setup(negedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CKN,  NOTIFIER);
      $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
      $setup(posedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CKN,  NOTIFIER);
      $setup(posedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CKN,  NOTIFIER);
      $recovery(posedge RN, negedge CKN &&& SN == 1'b1, trec$RN$CKN, NOTIFIER);
      $removal (posedge RN, negedge CKN &&& SN == 1'b1, trem$RN$CKN, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, negedge CKN &&& RN == 1'b1, trec$SN$CKN, NOTIFIER);
      $removal (posedge SN, negedge CKN &&& RN == 1'b1, trem$SN$CKN, NOTIFIER);
      $width(posedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CKN, 0, NOTIFIER);
      $width(negedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CKN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFNSRXL (CKN, D, Q, QN, RN, SE, SI, SN);
   input  CKN ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   not (I14_out, SE);
   not (I16_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I13_out, I14_out, I16_out);
   not (I18_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I18_out, SN);
   not (I21_out, D);
   not (I23_out, SE);
   not (I25_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I21_out, RN, I23_out, I25_out, SN);
   not (I28_out, D);
   not (I29_out, SE);
   not (I31_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I28_out, I29_out, I31_out, SN);
   not (I34_out, D);
   not (I35_out, RN);
   not (I37_out, SE);
   not (I39_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I34_out, I35_out, I37_out, I39_out);

    specify
      // delay parameters
      specparam
	tphlh$CKN$Q = 0.2:0.2:0.2,
     tphhl$CKN$Q = 0.18:0.18:0.18,
     tphlh$CKN$QN = 0.19:0.19:0.19,
     tphhl$CKN$QN = 0.21:0.21:0.21,
     tphhl$RN$Q = 0.22:0.23:0.23,
     tphlh$RN$QN = 0.23:0.23:0.24,
     tplhl$SN$Q = 0.21:0.21:0.21,
     tphlh$SN$Q = 0.17:0.17:0.17,
     tpllh$SN$QN = 0.22:0.22:0.22,
     tphhl$SN$QN = 0.18:0.18:0.18,
     tminpwh$CKN = 0.05:0.11:0.11,
     tminpwl$CKN = 0.054:0.19:0.19,
     tminpwl$RN = 0.058:0.24:0.24,
     tminpwl$SN = 0.02:0.18:0.18,
     tsetup_negedge$D$CKN = 0.12:0.12:0.12,
     thold_negedge$D$CKN = -0.063:-0.063:-0.063,
     tsetup_negedge$SE$CKN = 0.11:0.11:0.11,
     thold_negedge$SE$CKN = -0.056:-0.031:-0.031,
     tsetup_negedge$SI$CKN = 0.12:0.12:0.12,
     thold_negedge$SI$CKN = -0.062:-0.062:-0.062,
     tsetup_posedge$D$CKN = 0.094:0.094:0.094,
     thold_posedge$D$CKN = -0.019:-0.019:-0.019,
     tsetup_posedge$SE$CKN = 0.087:0.12:0.12,
     thold_posedge$SE$CKN = -0.069:-0.012:-0.012,
     tsetup_posedge$SI$CKN = 0.094:0.094:0.094,
     thold_posedge$SI$CKN = -0.019:-0.019:-0.019,
     trec$RN$CKN = 0.038:0.038:0.038,
     trem$RN$CKN = -0.000000000055:-0.000000000055:-0.000000000055,
     trec$RN$SN = 0.075:0.081:0.081,
     trec$SN$CKN = 0.031:0.031:0.031,
     trem$SN$CKN = 0.012:0.012:0.012;

      // path delays
      (negedge CKN *> (QN -: SE?SI:D)) = (tphlh$CKN$QN, tphhl$CKN$QN);
      (negedge CKN *> (Q +: SE?SI:D)) = (tphlh$CKN$Q, tphhl$CKN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
      $setup(negedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CKN,  NOTIFIER);
      $setup(negedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CKN,  NOTIFIER);
      $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
      $setup(posedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CKN,  NOTIFIER);
      $setup(posedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CKN,  NOTIFIER);
      $recovery(posedge RN, negedge CKN &&& SN == 1'b1, trec$RN$CKN, NOTIFIER);
      $removal (posedge RN, negedge CKN &&& SN == 1'b1, trem$RN$CKN, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, negedge CKN &&& RN == 1'b1, trec$SN$CKN, NOTIFIER);
      $removal (posedge SN, negedge CKN &&& RN == 1'b1, trem$SN$CKN, NOTIFIER);
      $width(posedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CKN, 0, NOTIFIER);
      $width(negedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CKN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFQX1 (CK, D, Q, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I5_out, SI);
   not (I7_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I7_out);
   not (I9_out, D);
   not (I10_out, SE);
   not (I12_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tminpwh$CK = 0.046:0.14:0.14,
     tminpwl$CK = 0.049:0.09:0.09,
     tsetup_negedge$D$CK = 0.063:0.063:0.063,
     thold_negedge$D$CK = -0.013:-0.013:-0.013,
     tsetup_negedge$SE$CK = 0.094:0.094:0.094,
     thold_negedge$SE$CK = -0.062:-0.062:-0.062,


     tsetup_negedge$SI$CK = 0.062:0.062:0.062,
     thold_negedge$SI$CK = -0.013:-0.013:-0.013,
     tsetup_posedge$D$CK = 0.081:0.081:0.081,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$SE$CK = 0.069:0.069:0.069,
     thold_posedge$SE$CK = -0.025:-0.025:-0.025,


     tsetup_posedge$SI$CK = 0.081:0.081:0.081,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFRHQX1 (CK, D, Q, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (N30, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I7_out, D);
   and (D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1, I7_out, SE, SI);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I10_out);
   not (I12_out, D);
   not (I14_out, SE);
   not (I16_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0, I12_out, RN, I14_out, I16_out);
   not (I18_out, D);
   not (I19_out, SE);
   not (I21_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I18_out, I19_out, I21_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.16:0.16:0.16,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tphhl$RN$Q = 0.075:0.075:0.075,
     tminpwh$CK = 0.053:0.15:0.15,
     tminpwl$CK = 0.055:0.098:0.098,
     tminpwl$RN = 0.018:0.08:0.08,
     tsetup_negedge$D$CK = 0.044:0.044:0.044,
     thold_negedge$D$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_negedge$SE$CK = 0.037:0.088:0.088,
     thold_negedge$SE$CK = -0.056:0.0062:0.0062,
     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.000000000086:-0.000000000086:-0.000000000086,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.056:0.069:0.069,
     thold_posedge$SE$CK = -0.037:-0.012:-0.012,
     tsetup_posedge$SI$CK = 0.075:0.075:0.075,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$RN$CK = -0.037:-0.037:-0.037,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFRHQX4 (CK, D, Q, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (N30, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I7_out, D);
   and (D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1, I7_out, SE, SI);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I10_out);
   not (I12_out, D);
   not (I14_out, SE);
   not (I16_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0, I12_out, RN, I14_out, I16_out);
   not (I18_out, D);
   not (I19_out, SE);
   not (I21_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I18_out, I19_out, I21_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tphhl$RN$Q = 0.041:0.041:0.041,
     tminpwh$CK = 0.06:0.13:0.13,
     tminpwl$CK = 0.056:0.1:0.1,
     tminpwl$RN = 0.017:0.087:0.087,
     tsetup_negedge$D$CK = 0.038:0.038:0.038,
     thold_negedge$D$CK = 0.0062:0.0062:0.0062,
     tsetup_negedge$SE$CK = 0.031:0.094:0.094,
     thold_negedge$SE$CK = -0.056:0.012:0.012,
     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.00000000009:-0.00000000009:-0.00000000009,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.056:0.069:0.069,
     thold_posedge$SE$CK = -0.038:-0.013:-0.013,
     tsetup_posedge$SI$CK = 0.075:0.075:0.075,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$RN$CK = -0.037:-0.037:-0.037,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFRX1 (CK, D, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (N30, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I9_out, D);
   and (D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1, I9_out, SE, SI);
   not (I12_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I12_out);
   not (I14_out, D);
   not (I16_out, SE);
   not (I18_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0, I14_out, RN, I16_out, I18_out);
   not (I20_out, D);
   not (I21_out, SE);
   not (I23_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I20_out, I21_out, I23_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.17:0.17:0.17,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tpllh$CK$QN = 0.17:0.17:0.17,
     tplhl$CK$QN = 0.19:0.19:0.19,
     tphhl$RN$Q = 0.086:0.086:0.086,
     tphlh$RN$QN = 0.098:0.098:0.098,
     tminpwh$CK = 0.052:0.17:0.17,
     tminpwl$CK = 0.054:0.097:0.097,
     tminpwl$RN = 0.024:0.098:0.098,
     tsetup_negedge$D$CK = 0.062:0.062:0.062,
     thold_negedge$D$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$SE$CK = 0.056:0.1:0.1,
     thold_negedge$SE$CK = -0.063:-0.0062:-0.0062,
     tsetup_negedge$SI$CK = 0.063:0.063:0.063,
     thold_negedge$SI$CK = -0.012:-0.012:-0.012,
     tsetup_posedge$D$CK = 0.088:0.088:0.088,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.069:0.081:0.081,
     thold_posedge$SE$CK = -0.05:-0.019:-0.019,
     tsetup_posedge$SI$CK = 0.087:0.087:0.087,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056,
     trec$RN$CK = -0.038:-0.038:-0.038,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFRX2 (CK, D, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (N30, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I9_out, D);
   and (D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1, I9_out, SE, SI);
   not (I12_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I12_out);
   not (I14_out, D);
   not (I16_out, SE);
   not (I18_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0, I14_out, RN, I16_out, I18_out);
   not (I20_out, D);
   not (I21_out, SE);
   not (I23_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I20_out, I21_out, I23_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.062:0.063:0.063,
     tphlh$RN$QN = 0.084:0.085:0.085,
     tminpwh$CK = 0.052:0.16:0.16,
     tminpwl$CK = 0.053:0.094:0.094,
     tminpwl$RN = 0.023:0.085:0.085,
     tsetup_negedge$D$CK = 0.062:0.062:0.062,
     thold_negedge$D$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$SE$CK = 0.056:0.1:0.1,
     thold_negedge$SE$CK = -0.063:-0.0062:-0.0062,
     tsetup_negedge$SI$CK = 0.063:0.063:0.063,
     thold_negedge$SI$CK = -0.013:-0.013:-0.013,
     tsetup_posedge$D$CK = 0.088:0.088:0.088,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$SE$CK = 0.075:0.081:0.081,
     thold_posedge$SE$CK = -0.044:-0.019:-0.019,
     tsetup_posedge$SI$CK = 0.088:0.088:0.088,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05,
     trec$RN$CK = -0.037:-0.037:-0.037,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFRXL (CK, D, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (N30, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I9_out, D);
   and (D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1, I9_out, SE, SI);
   not (I12_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I12_out);
   not (I14_out, D);
   not (I16_out, SE);
   not (I18_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0, I14_out, RN, I16_out, I18_out);
   not (I20_out, D);
   not (I21_out, SE);
   not (I23_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I20_out, I21_out, I23_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.2:0.2:0.2,
     tplhl$CK$Q = 0.19:0.19:0.19,
     tpllh$CK$QN = 0.2:0.2:0.2,
     tplhl$CK$QN = 0.21:0.21:0.21,
     tphhl$RN$Q = 0.11:0.11:0.11,
     tphlh$RN$QN = 0.12:0.12:0.12,
     tminpwh$CK = 0.052:0.2:0.2,
     tminpwl$CK = 0.055:0.098:0.098,
     tminpwl$RN = 0.022:0.12:0.12,
     tsetup_negedge$D$CK = 0.062:0.062:0.062,
     thold_negedge$D$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$SE$CK = 0.056:0.1:0.1,
     thold_negedge$SE$CK = -0.062:-0.0063:-0.0063,
     tsetup_negedge$SI$CK = 0.063:0.063:0.063,
     thold_negedge$SI$CK = -0.012:-0.012:-0.012,
     tsetup_posedge$D$CK = 0.088:0.088:0.088,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.069:0.081:0.081,
     thold_posedge$SE$CK = -0.05:-0.019:-0.019,
     tsetup_posedge$SI$CK = 0.088:0.088:0.088,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056,
     trec$RN$CK = -0.037:-0.037:-0.037,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSHQX1 (CK, D, Q, SE, SI, SN);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N30, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D);
   not (I7_out, SE);
   not (I9_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I6_out, I7_out, I9_out);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I12_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I12_out, SN);
   not (I14_out, D);
   not (I15_out, SE);
   not (I17_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I14_out, I15_out, I17_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tphlh$SN$Q = 0.11:0.11:0.11,
     tminpwh$CK = 0.052:0.16:0.16,
     tminpwl$CK = 0.054:0.11:0.11,
     tminpwl$SN = 0.015:0.11:0.11,
     tsetup_negedge$D$CK = 0.062:0.062:0.062,
     thold_negedge$D$CK = -0.0063:-0.0063:-0.0063,
     tsetup_negedge$SE$CK = 0.056:0.087:0.087,
     thold_negedge$SE$CK = -0.062:0.00000000015:0.00000000015,
     tsetup_negedge$SI$CK = 0.062:0.062:0.062,
     thold_negedge$SI$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.063:0.081:0.081,
     thold_posedge$SE$CK = -0.038:-0.019:-0.019,
     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$SN$CK = -0.0062:-0.0062:-0.0062,
     trem$SN$CK = 0.044:0.044:0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSRHQX1 (CK, D, Q, RN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, D);
   not (I11_out, SE);
   not (I13_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I10_out, I11_out, I13_out);
   not (I15_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I15_out, SN);
   not (I18_out, D);
   not (I20_out, SE);
   not (I22_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I18_out, RN, I20_out, I22_out, SN);
   not (I25_out, D);
   not (I26_out, SE);
   not (I28_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I25_out, I26_out, I28_out, SN);
   not (I31_out, D);
   not (I32_out, RN);
   not (I34_out, SE);
   not (I36_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I31_out, I32_out, I34_out, I36_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.18:0.19:0.19,
     tplhl$SN$Q = 0.16:0.17:0.17,
     tphlh$SN$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.064:0.17:0.17,
     tminpwl$CK = 0.06:0.12:0.12,
     tminpwl$RN = 0.061:0.19:0.19,
     tminpwl$SN = 0.019:0.13:0.13,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_negedge$SE$CK = 0.063:0.11:0.11,
     thold_negedge$SE$CK = -0.056:0.0063:0.0063,
     tsetup_negedge$SI$CK = 0.069:0.069:0.069,
     thold_negedge$SI$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$D$CK = 0.1:0.1:0.1,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.081:0.094:0.094,
     thold_posedge$SE$CK = -0.037:-0.013:-0.013,
     tsetup_posedge$SI$CK = 0.1:0.1:0.1,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$RN$CK = 0.062:0.062:0.062,
     trem$RN$CK = -0.0063:-0.0063:-0.0063,
     trec$RN$SN = 0.069:0.075:0.075,
     trec$SN$CK = 0:0:0,
     trem$SN$CK = 0.044:0.044:0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSRHQX2 (CK, D, Q, RN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, D);
   not (I11_out, SE);
   not (I13_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I10_out, I11_out, I13_out);
   not (I15_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I15_out, SN);
   not (I18_out, D);
   not (I20_out, SE);
   not (I22_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I18_out, RN, I20_out, I22_out, SN);
   not (I25_out, D);
   not (I26_out, SE);
   not (I28_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I25_out, I26_out, I28_out, SN);
   not (I31_out, D);
   not (I32_out, RN);
   not (I34_out, SE);
   not (I36_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I31_out, I32_out, I34_out, I36_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tphhl$RN$Q = 0.17:0.17:0.18,
     tplhl$SN$Q = 0.15:0.15:0.16,
     tphlh$SN$Q = 0.11:0.12:0.12,
     tminpwh$CK = 0.065:0.16:0.16,
     tminpwl$CK = 0.06:0.12:0.12,
     tminpwl$RN = 0.062:0.18:0.18,
     tminpwl$SN = 0.019:0.12:0.12,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = 0.0000000004:0.0000000004:0.0000000004,
     tsetup_negedge$SE$CK = 0.062:0.11:0.11,
     thold_negedge$SE$CK = -0.056:0.0063:0.0063,
     tsetup_negedge$SI$CK = 0.069:0.069:0.069,
     thold_negedge$SI$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$D$CK = 0.1:0.1:0.1,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.081:0.094:0.094,
     thold_posedge$SE$CK = -0.037:-0.012:-0.012,
     tsetup_posedge$SI$CK = 0.1:0.1:0.1,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$RN$CK = 0.062:0.062:0.062,
     trem$RN$CK = -0.012:-0.012:-0.012,
     trec$RN$SN = 0.069:0.075:0.075,
     trec$SN$CK = 0:0:0,
     trem$SN$CK = 0.044:0.044:0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSRHQX4 (CK, D, Q, RN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, D);
   not (I11_out, SE);
   not (I13_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I10_out, I11_out, I13_out);
   not (I15_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I15_out, SN);
   not (I18_out, D);
   not (I20_out, SE);
   not (I22_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I18_out, RN, I20_out, I22_out, SN);
   not (I25_out, D);
   not (I26_out, SE);
   not (I28_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I25_out, I26_out, I28_out, SN);
   not (I31_out, D);
   not (I32_out, RN);
   not (I34_out, SE);
   not (I36_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I31_out, I32_out, I34_out, I36_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tphhl$RN$Q = 0.16:0.17:0.17,
     tplhl$SN$Q = 0.14:0.15:0.15,
     tphlh$SN$Q = 0.11:0.11:0.11,
     tminpwh$CK = 0.07:0.15:0.15,
     tminpwl$CK = 0.057:0.12:0.12,
     tminpwl$RN = 0.062:0.17:0.17,
     tminpwl$SN = 0.02:0.11:0.11,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_negedge$SE$CK = 0.062:0.12:0.12,
     thold_negedge$SE$CK = -0.056:0.0063:0.0063,
     tsetup_negedge$SI$CK = 0.069:0.069:0.069,
     thold_negedge$SI$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$D$CK = 0.1:0.1:0.1,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.087:0.094:0.094,
     thold_posedge$SE$CK = -0.038:-0.019:-0.019,
     tsetup_posedge$SI$CK = 0.1:0.1:0.1,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$RN$CK = 0.069:0.069:0.069,
     trem$RN$CK = -0.012:-0.012:-0.012,
     trec$RN$SN = 0.075:0.081:0.081,
     trec$SN$CK = 0.0063:0.0063:0.0063,
     trem$SN$CK = 0.038:0.038:0.038;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSRX1 (CK, D, Q, QN, RN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   not (I13_out, SE);
   not (I15_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I12_out, I13_out, I15_out);
   not (I17_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I17_out, SN);
   not (I20_out, D);
   not (I22_out, SE);
   not (I24_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I20_out, RN, I22_out, I24_out, SN);
   not (I27_out, D);
   not (I28_out, SE);
   not (I30_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I27_out, I28_out, I30_out, SN);
   not (I33_out, D);
   not (I34_out, RN);
   not (I36_out, SE);
   not (I38_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I33_out, I34_out, I36_out, I38_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.16:0.16:0.16,
     tplhl$CK$Q = 0.17:0.17:0.17,
     tpllh$CK$QN = 0.18:0.18:0.18,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.19:0.2:0.2,
     tphlh$RN$QN = 0.21:0.21:0.21,
     tplhl$SN$Q = 0.18:0.18:0.18,
     tphlh$SN$Q = 0.14:0.14:0.15,
     tpllh$SN$QN = 0.19:0.19:0.2,
     tphhl$SN$QN = 0.16:0.16:0.16,
     tminpwh$CK = 0.054:0.18:0.18,
     tminpwl$CK = 0.052:0.11:0.11,
     tminpwl$RN = 0.059:0.21:0.21,
     tminpwl$SN = 0.02:0.16:0.16,
     tsetup_negedge$D$CK = 0.094:0.094:0.094,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.087:0.12:0.12,
     thold_negedge$SE$CK = -0.063:-0.012:-0.012,
     tsetup_negedge$SI$CK = 0.094:0.094:0.094,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.1:0.11:0.11,
     thold_posedge$SE$CK = -0.05:-0.025:-0.025,
     tsetup_posedge$SI$CK = 0.11:0.11:0.11,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056,
     trec$RN$CK = 0.062:0.062:0.062,
     trem$RN$CK = -0.013:-0.013:-0.013,
     trec$RN$SN = 0.069:0.075:0.075,
     trec$SN$CK = 0.012:0.012:0.012,
     trem$SN$CK = 0.025:0.025:0.025;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSRX4 (CK, D, Q, QN, RN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   not (I13_out, SE);
   not (I15_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I12_out, I13_out, I15_out);
   not (I17_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I17_out, SN);
   not (I20_out, D);
   not (I22_out, SE);
   not (I24_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I20_out, RN, I22_out, I24_out, SN);
   not (I27_out, D);
   not (I28_out, SE);
   not (I30_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I27_out, I28_out, I30_out, SN);
   not (I33_out, D);
   not (I34_out, RN);
   not (I36_out, SE);
   not (I38_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I33_out, I34_out, I36_out, I38_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tpllh$CK$QN = 0.17:0.17:0.17,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.17:0.18:0.19,
     tphlh$RN$QN = 0.2:0.21:0.22,
     tplhl$SN$Q = 0.15:0.16:0.17,
     tphlh$SN$Q = 0.12:0.12:0.12,
     tpllh$SN$QN = 0.18:0.19:0.2,
     tphhl$SN$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.067:0.17:0.17,
     tminpwl$CK = 0.06:0.13:0.13,
     tminpwl$RN = 0.066:0.22:0.22,
     tminpwl$SN = 0.024:0.15:0.15,
     tsetup_negedge$D$CK = 0.11:0.11:0.11,
     thold_negedge$D$CK = -0.013:-0.013:-0.013,
     tsetup_negedge$SE$CK = 0.11:0.16:0.16,
     thold_negedge$SE$CK = -0.069:-0.0062:-0.0062,
     tsetup_negedge$SI$CK = 0.11:0.11:0.11,
     thold_negedge$SI$CK = -0.013:-0.013:-0.013,
     tsetup_posedge$D$CK = 0.14:0.14:0.14,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.12:0.14:0.14,
     thold_posedge$SE$CK = -0.05:-0.025:-0.025,
     tsetup_posedge$SI$CK = 0.14:0.14:0.14,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056,
     trec$RN$CK = 0.081:0.081:0.081,
     trem$RN$CK = -0.019:-0.019:-0.019,
     trec$RN$SN = 0.087:0.088:0.088,
     trec$SN$CK = 0.025:0.025:0.025,
     trem$SN$CK = 0.025:0.025:0.025;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSX1 (CK, D, Q, QN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   not (I9_out, SE);
   not (I11_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I8_out, I9_out, I11_out);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I14_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I14_out, SN);
   not (I16_out, D);
   not (I17_out, SE);
   not (I19_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I16_out, I17_out, I19_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tpllh$CK$QN = 0.18:0.18:0.18,
     tplhl$CK$QN = 0.16:0.16:0.16,
     tphlh$SN$Q = 0.13:0.13:0.13,
     tphhl$SN$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.049:0.18:0.18,
     tminpwl$CK = 0.052:0.11:0.11,
     tminpwl$SN = 0.019:0.15:0.15,
     tsetup_negedge$D$CK = 0.094:0.094:0.094,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.088:0.1:0.1,
     thold_negedge$SE$CK = -0.062:-0.013:-0.013,
     tsetup_negedge$SI$CK = 0.094:0.094:0.094,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.094:0.094:0.094,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$SE$CK = 0.081:0.1:0.1,
     thold_posedge$SE$CK = -0.044:-0.025:-0.025,
     tsetup_posedge$SI$CK = 0.087:0.087:0.087,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05,
     trec$SN$CK = 0.012:0.012:0.012,
     trem$SN$CK = 0.031:0.031:0.031;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (0, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSXL (CK, D, Q, QN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   not (I9_out, SE);
   not (I11_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I8_out, I9_out, I11_out);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I14_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I14_out, SN);
   not (I16_out, D);
   not (I17_out, SE);
   not (I19_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I16_out, I17_out, I19_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.17:0.17:0.17,
     tplhl$CK$Q = 0.19:0.19:0.19,
     tpllh$CK$QN = 0.2:0.2:0.2,
     tplhl$CK$QN = 0.18:0.18:0.18,
     tphlh$SN$Q = 0.16:0.16:0.16,
     tphhl$SN$QN = 0.17:0.17:0.17,
     tminpwh$CK = 0.049:0.2:0.2,
     tminpwl$CK = 0.051:0.11:0.11,
     tminpwl$SN = 0.019:0.17:0.17,
     tsetup_negedge$D$CK = 0.094:0.094:0.094,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.087:0.1:0.1,
     thold_negedge$SE$CK = -0.063:-0.012:-0.012,
     tsetup_negedge$SI$CK = 0.094:0.094:0.094,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.094:0.094:0.094,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.081:0.1:0.1,
     thold_posedge$SE$CK = -0.05:-0.025:-0.025,
     tsetup_posedge$SI$CK = 0.087:0.087:0.087,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056,
     trec$SN$CK = 0.013:0.013:0.013,
     trem$SN$CK = 0.031:0.031:0.031;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (0, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFTRX1 (CK, D, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_out, D, RN);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   not (I9_out, RN);
   and (D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1, I8_out, I9_out, SI);
   not (I13_out, SI);
   and (D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0, D, RN, I13_out);
   not (I15_out, SE);
   and (D_EQ_1_AN_SE_EQ_0, D, I15_out);
   not (I17_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I17_out);
   not (I19_out, D);
   not (I20_out, RN);
   not (I22_out, SE);
   not (I24_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I19_out, I20_out, I22_out, I24_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.046:0.16:0.16,
     tminpwl$CK = 0.049:0.091:0.091,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$RN$CK = 0.069:0.069:0.069,
     thold_negedge$RN$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.1:0.1:0.1,
     thold_negedge$SE$CK = -0.062:-0.062:-0.062,


     tsetup_negedge$SI$CK = 0.063:0.063:0.063,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.087:-0.087:-0.087,
     tsetup_posedge$RN$CK = 0.13:0.13:0.13,
     thold_posedge$RN$CK = -0.087:-0.087:-0.087,
     tsetup_posedge$SE$CK = 0.075:0.075:0.075,
     thold_posedge$SE$CK = -0.025:-0.025:-0.025,


     tsetup_posedge$SI$CK = 0.081:0.081:0.081,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (QN -: SE?SI:(RN&D))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(RN&D))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFTRX2 (CK, D, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_out, D, RN);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   not (I9_out, RN);
   and (D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1, I8_out, I9_out, SI);
   not (I13_out, SI);
   and (D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0, D, RN, I13_out);
   not (I15_out, SE);
   and (D_EQ_1_AN_SE_EQ_0, D, I15_out);
   not (I17_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I17_out);
   not (I19_out, D);
   not (I20_out, RN);
   not (I22_out, SE);
   not (I24_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I19_out, I20_out, I22_out, I24_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.049:0.16:0.16,
     tminpwl$CK = 0.051:0.093:0.093,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$RN$CK = 0.069:0.069:0.069,
     thold_negedge$RN$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.1:0.1:0.1,
     thold_negedge$SE$CK = -0.056:-0.056:-0.056,


     tsetup_negedge$SI$CK = 0.063:0.063:0.063,
     thold_negedge$SI$CK = -0.013:-0.013:-0.013,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$RN$CK = 0.13:0.13:0.13,
     thold_posedge$RN$CK = -0.088:-0.088:-0.088,
     tsetup_posedge$SE$CK = 0.075:0.075:0.075,
     thold_posedge$SE$CK = -0.025:-0.025:-0.025,


     tsetup_posedge$SI$CK = 0.081:0.081:0.081,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (QN -: SE?SI:(RN&D))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(RN&D))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFTRX4 (CK, D, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_out, D, RN);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   not (I9_out, RN);
   and (D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1, I8_out, I9_out, SI);
   not (I13_out, SI);
   and (D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0, D, RN, I13_out);
   not (I15_out, SE);
   and (D_EQ_1_AN_SE_EQ_0, D, I15_out);
   not (I17_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I17_out);
   not (I19_out, D);
   not (I20_out, RN);
   not (I22_out, SE);
   not (I24_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I19_out, I20_out, I22_out, I24_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.12:0.12:0.12,
     tpllh$CK$QN = 0.15:0.15:0.15,
     tplhl$CK$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.053:0.15:0.15,
     tminpwl$CK = 0.045:0.088:0.088,
     tsetup_negedge$D$CK = 0.075:0.075:0.075,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$RN$CK = 0.075:0.075:0.075,
     thold_negedge$RN$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.11:0.11:0.11,
     thold_negedge$SE$CK = -0.063:-0.063:-0.063,


     tsetup_negedge$SI$CK = 0.069:0.069:0.069,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.14:0.14:0.14,
     thold_posedge$D$CK = -0.087:-0.087:-0.087,
     tsetup_posedge$RN$CK = 0.14:0.14:0.14,
     thold_posedge$RN$CK = -0.087:-0.087:-0.087,
     tsetup_posedge$SE$CK = 0.088:0.088:0.088,
     thold_posedge$SE$CK = -0.031:-0.031:-0.031,


     tsetup_posedge$SI$CK = 0.094:0.094:0.094,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056;

      // path delays
      (posedge CK *> (QN -: SE?SI:(RN&D))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(RN&D))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFTRXL (CK, D, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_out, D, RN);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   not (I9_out, RN);
   and (D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1, I8_out, I9_out, SI);
   not (I13_out, SI);
   and (D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0, D, RN, I13_out);
   not (I15_out, SE);
   and (D_EQ_1_AN_SE_EQ_0, D, I15_out);
   not (I17_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I17_out);
   not (I19_out, D);
   not (I20_out, RN);
   not (I22_out, SE);
   not (I24_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I19_out, I20_out, I22_out, I24_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.16:0.16:0.16,
     tplhl$CK$Q = 0.18:0.18:0.18,
     tpllh$CK$QN = 0.19:0.19:0.19,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tminpwh$CK = 0.046:0.19:0.19,
     tminpwl$CK = 0.049:0.09:0.09,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$RN$CK = 0.069:0.069:0.069,
     thold_negedge$RN$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$SE$CK = 0.1:0.1:0.1,
     thold_negedge$SE$CK = -0.063:-0.063:-0.063,


     tsetup_negedge$SI$CK = 0.063:0.063:0.063,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.087:-0.087:-0.087,
     tsetup_posedge$RN$CK = 0.12:0.12:0.12,
     thold_posedge$RN$CK = -0.087:-0.087:-0.087,
     tsetup_posedge$SE$CK = 0.075:0.075:0.075,
     thold_posedge$SE$CK = -0.031:-0.031:-0.031,


     tsetup_posedge$SI$CK = 0.081:0.081:0.081,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (QN -: SE?SI:(RN&D))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(RN&D))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SE_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFX1 (CK, D, Q, QN, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I7_out, SI);
   not (I9_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I9_out);
   not (I11_out, D);
   not (I12_out, SE);
   not (I14_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I11_out, I12_out, I14_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.046:0.16:0.16,
     tminpwl$CK = 0.049:0.091:0.091,
     tsetup_negedge$D$CK = 0.062:0.062:0.062,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.094:0.094:0.094,
     thold_negedge$SE$CK = -0.063:-0.063:-0.063,


     tsetup_negedge$SI$CK = 0.063:0.063:0.063,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.081:0.081:0.081,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$SE$CK = 0.069:0.069:0.069,
     thold_posedge$SE$CK = -0.025:-0.025:-0.025,


     tsetup_posedge$SI$CK = 0.081:0.081:0.081,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFHQX2 (CK, D, E, Q, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I7_out, D);
   not (I8_out, E);
   not (I10_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0, I7_out, I8_out, I10_out);
   not (I12_out, D);
   not (I13_out, E);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1, I12_out, I13_out, SI);
   not (I16_out, D);
   and (D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1, I16_out, E, SI);
   not (I20_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0, D, E, I20_out);
   not (I22_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I22_out);
   not (I24_out, D);
   not (I25_out, E);
   not (I28_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0, I24_out, I25_out, SE, I28_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.048:0.13:0.13,
     tminpwl$CK = 0.048:0.092:0.092,
     tsetup_negedge$D$CK = 0.094:0.094:0.094,
     thold_negedge$D$CK = -0.031:-0.031:-0.031,
     tsetup_negedge$E$CK = 0.063:0.11:0.11,
     thold_negedge$E$CK = -0.1:-0.025:-0.025,
     thold_negedge$SE$CK = -0.0062:-0.0062:-0.0062,


     tsetup_negedge$SE$CK = 0.094:0.094:0.094,
     tsetup_negedge$SI$CK = 0.05:0.05:0.05,
     thold_negedge$SI$CK = -0.012:-0.012:-0.012,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$E$CK = 0.11:0.11:0.11,
     thold_posedge$E$CK = -0.094:-0.087:-0.087,
     tsetup_posedge$SE$CK = 0.069:0.069:0.069,

     thold_posedge$SE$CK = -0.025:-0.025:-0.025,

     tsetup_posedge$SI$CK = 0.075:0.075:0.075,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (Q +: SE?SI:(E?D:!QBINT))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFHQX8 (CK, D, E, Q, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I7_out, D);
   not (I8_out, E);
   not (I10_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0, I7_out, I8_out, I10_out);
   not (I12_out, D);
   not (I13_out, E);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1, I12_out, I13_out, SI);
   not (I16_out, D);
   and (D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1, I16_out, E, SI);
   not (I20_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0, D, E, I20_out);
   not (I22_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I22_out);
   not (I24_out, D);
   not (I25_out, E);
   not (I28_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0, I24_out, I25_out, SE, I28_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.063:0.13:0.13,
     tminpwl$CK = 0.048:0.098:0.098,
     tsetup_negedge$D$CK = 0.094:0.094:0.094,
     thold_negedge$D$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$E$CK = 0.056:0.1:0.1,
     thold_negedge$E$CK = -0.094:-0.019:-0.019,
     thold_negedge$SE$CK = -0.00000000019:-0.00000000019:-0.00000000019,

     tsetup_negedge$SE$CK = 0.094:0.094:0.094,

     tsetup_negedge$SI$CK = 0.05:0.05:0.05,
     thold_negedge$SI$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$E$CK = 0.11:0.12:0.12,
     thold_posedge$E$CK = -0.087:-0.087:-0.087,
     tsetup_posedge$SE$CK = 0.069:0.069:0.069,

     thold_posedge$SE$CK = -0.019:-0.019:-0.019,

     tsetup_posedge$SI$CK = 0.075:0.075:0.075,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:(E?D:!QBINT))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFTRX2 (CK, D, E, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, QBINT);
   not (I5_out, I4_out);
   and (I7_out, I2_out, I5_out, RN);
   udp_mux2 (I0_D, I7_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I15_out, D);
   not (I16_out, E);
   not (I18_out, RN);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1, I15_out, I16_out, I18_out, SI);
   not (I21_out, D);
   not (I22_out, E);
   not (I25_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0, I21_out, I22_out, RN, I25_out);
   not (I29_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0, D, E, RN, I29_out);
   not (I31_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I31_out);
   not (I34_out, SE);
   and (E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0, E, RN, I34_out);
   not (I36_out, D);
   not (I37_out, E);
   not (I39_out, RN);
   not (I41_out, SE);
   not (I43_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I36_out, I37_out, I39_out, I41_out, I43_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.051:0.16:0.16,
     tminpwl$CK = 0.052:0.096:0.096,
     tsetup_negedge$D$CK = 0.13:0.13:0.13,
     thold_negedge$D$CK = -0.087:-0.087:-0.087,
     tsetup_negedge$E$CK = 0.12:0.15:0.15,
     thold_negedge$E$CK = -0.14:-0.1:-0.1,
     tsetup_negedge$RN$CK = 0.12:0.12:0.12,
     thold_negedge$RN$CK = -0.075:-0.075:-0.075,
     tsetup_negedge$SE$CK = 0.094:0.094:0.094,
     thold_negedge$SE$CK = -0.062:-0.062:-0.062,


     tsetup_negedge$SI$CK = 0.062:0.062:0.062,
     thold_negedge$SI$CK = -0.012:-0.012:-0.012,
     tsetup_posedge$D$CK = 0.19:0.19:0.19,
     thold_posedge$D$CK = -0.14:-0.14:-0.14,
     tsetup_posedge$E$CK = 0.12:0.21:0.21,
     thold_posedge$E$CK = -0.19:-0.11:-0.11,
     tsetup_posedge$RN$CK = 0.22:0.22:0.22,
     thold_posedge$RN$CK = -0.19:-0.19:-0.19,
     tsetup_posedge$SE$CK = 0.069:0.069:0.069,
     thold_posedge$SE$CK = -0.019:-0.019:-0.019,


     tsetup_posedge$SI$CK = 0.081:0.081:0.081,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (QN -: SE?SI:(RN&(!(QBINT&!E)&!(E&!D))))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(RN&(!(QBINT&!E)&!(E&!D))))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& SE == 1'b0, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& SE == 1'b0, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFTRX4 (CK, D, E, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, QBINT);
   not (I5_out, I4_out);
   and (I7_out, I2_out, I5_out, RN);
   udp_mux2 (I0_D, I7_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I15_out, D);
   not (I16_out, E);
   not (I18_out, RN);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1, I15_out, I16_out, I18_out, SI);
   not (I21_out, D);
   not (I22_out, E);
   not (I25_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0, I21_out, I22_out, RN, I25_out);
   not (I29_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0, D, E, RN, I29_out);
   not (I31_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I31_out);
   not (I34_out, SE);
   and (E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0, E, RN, I34_out);
   not (I36_out, D);
   not (I37_out, E);
   not (I39_out, RN);
   not (I41_out, SE);
   not (I43_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I36_out, I37_out, I39_out, I41_out, I43_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.15:0.15:0.15,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.058:0.15:0.15,
     tminpwl$CK = 0.053:0.096:0.096,
     tsetup_negedge$D$CK = 0.14:0.14:0.14,
     thold_negedge$D$CK = -0.088:-0.088:-0.088,
     tsetup_negedge$E$CK = 0.13:0.16:0.16,
     thold_negedge$E$CK = -0.14:-0.11:-0.11,
     tsetup_negedge$RN$CK = 0.12:0.12:0.12,
     thold_negedge$RN$CK = -0.075:-0.075:-0.075,
     tsetup_negedge$SE$CK = 0.094:0.094:0.094,
     thold_negedge$SE$CK = -0.063:-0.063:-0.063,


     tsetup_negedge$SI$CK = 0.062:0.062:0.062,
     thold_negedge$SI$CK = -0.012:-0.012:-0.012,
     tsetup_posedge$D$CK = 0.2:0.2:0.2,
     thold_posedge$D$CK = -0.14:-0.14:-0.14,
     tsetup_posedge$E$CK = 0.13:0.22:0.22,
     thold_posedge$E$CK = -0.2:-0.11:-0.11,
     tsetup_posedge$RN$CK = 0.23:0.23:0.23,
     thold_posedge$RN$CK = -0.19:-0.19:-0.19,
     tsetup_posedge$SE$CK = 0.075:0.075:0.075,
     thold_posedge$SE$CK = -0.019:-0.019:-0.019,


     tsetup_posedge$SI$CK = 0.087:0.087:0.087,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (QN -: SE?SI:(RN&(!(QBINT&!E)&!(E&!D))))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(RN&(!(QBINT&!E)&!(E&!D))))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& SE == 1'b0, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& SE == 1'b0, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFTRXL (CK, D, E, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, QBINT);
   not (I5_out, I4_out);
   and (I7_out, I2_out, I5_out, RN);
   udp_mux2 (I0_D, I7_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I15_out, D);
   not (I16_out, E);
   not (I18_out, RN);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1, I15_out, I16_out, I18_out, SI);
   not (I21_out, D);
   not (I22_out, E);
   not (I25_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0, I21_out, I22_out, RN, I25_out);
   not (I29_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0, D, E, RN, I29_out);
   not (I31_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I31_out);
   not (I34_out, SE);
   and (E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0, E, RN, I34_out);
   not (I36_out, D);
   not (I37_out, E);
   not (I39_out, RN);
   not (I41_out, SE);
   not (I43_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I36_out, I37_out, I39_out, I41_out, I43_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.18:0.18:0.18,
     tplhl$CK$Q = 0.19:0.19:0.2,
     tpllh$CK$QN = 0.2:0.2:0.2,
     tplhl$CK$QN = 0.19:0.19:0.19,
     tminpwh$CK = 0.044:0.2:0.2,
     tminpwl$CK = 0.045:0.089:0.089,
     tsetup_negedge$D$CK = 0.13:0.13:0.13,
     thold_negedge$D$CK = -0.087:-0.087:-0.087,
     tsetup_negedge$E$CK = 0.12:0.13:0.13,
     thold_negedge$E$CK = -0.12:-0.1:-0.1,
     tsetup_negedge$RN$CK = 0.12:0.12:0.12,
     thold_negedge$RN$CK = -0.075:-0.075:-0.075,
     tsetup_negedge$SE$CK = 0.11:0.11:0.11,
     thold_negedge$SE$CK = -0.075:-0.075:-0.075,


     tsetup_negedge$SI$CK = 0.069:0.069:0.069,
     thold_negedge$SI$CK = -0.025:-0.025:-0.025,
     tsetup_posedge$D$CK = 0.17:0.17:0.17,
     thold_posedge$D$CK = -0.13:-0.13:-0.13,
     tsetup_posedge$E$CK = 0.12:0.19:0.19,
     thold_posedge$E$CK = -0.17:-0.1:-0.1,
     tsetup_posedge$RN$CK = 0.2:0.2:0.2,
     thold_posedge$RN$CK = -0.17:-0.17:-0.17,
     tsetup_posedge$SE$CK = 0.088:0.088:0.088,
     thold_posedge$SE$CK = -0.038:-0.038:-0.038,


     tsetup_posedge$SI$CK = 0.088:0.088:0.088,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056;

      // path delays
      (posedge CK *> (QN -: SE?SI:(RN&(!(QBINT&!E)&!(E&!D))))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(RN&(!(QBINT&!E)&!(E&!D))))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& SE == 1'b0, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& SE == 1'b0, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFX2 (CK, D, E, Q, QN, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, NET536);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (NET536, N30);
   not (Q, NET536);
   buf (QN, NET536);
   not (I9_out, D);
   not (I10_out, E);
   not (I12_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);
   not (I14_out, D);
   not (I15_out, E);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1, I14_out, I15_out, SI);
   not (I18_out, D);
   and (D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1, I18_out, E, SI);
   not (I22_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0, D, E, I22_out);
   not (I24_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I24_out);
   not (I26_out, D);
   not (I27_out, E);
   not (I30_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0, I26_out, I27_out, SE, I30_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tpllh$CK$QN = 0.17:0.17:0.17,
     tplhl$CK$QN = 0.16:0.16:0.16,
     tminpwh$CK = 0.049:0.17:0.17,
     tminpwl$CK = 0.049:0.096:0.096,
     tsetup_negedge$D$CK = 0.12:0.12:0.12,
     thold_negedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_negedge$E$CK = 0.088:0.12:0.12,
     thold_negedge$E$CK = -0.11:-0.037:-0.037,
     thold_negedge$SE$CK = -0.013:-0.013:-0.013,

     tsetup_negedge$SE$CK = 0.11:0.11:0.11,

     tsetup_negedge$SI$CK = 0.069:0.069:0.069,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.15:0.15:0.15,
     thold_posedge$D$CK = -0.1:-0.1:-0.1,
     tsetup_posedge$E$CK = 0.14:0.14:0.14,
     thold_posedge$E$CK = -0.12:-0.11:-0.11,
     tsetup_posedge$SE$CK = 0.087:0.087:0.087,

     thold_posedge$SE$CK = -0.031:-0.031:-0.031,

     tsetup_posedge$SI$CK = 0.094:0.094:0.094,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056;

      // path delays
      (posedge CK *> (QN -: SE?SI:(E?D:!NET536))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(E?D:!NET536))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFXL (CK, D, E, Q, QN, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, NET536);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (NET536, N30);
   not (Q, NET536);
   buf (QN, NET536);
   not (I9_out, D);
   not (I10_out, E);
   not (I12_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);
   not (I14_out, D);
   not (I15_out, E);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1, I14_out, I15_out, SI);
   not (I18_out, D);
   and (D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1, I18_out, E, SI);
   not (I22_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0, D, E, I22_out);
   not (I24_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I24_out);
   not (I26_out, D);
   not (I27_out, E);
   not (I30_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0, I26_out, I27_out, SE, I30_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.17:0.17:0.17,
     tplhl$CK$Q = 0.18:0.18:0.18,
     tpllh$CK$QN = 0.2:0.2:0.2,
     tplhl$CK$QN = 0.19:0.19:0.19,
     tminpwh$CK = 0.046:0.2:0.2,
     tminpwl$CK = 0.047:0.093:0.093,
     tsetup_negedge$D$CK = 0.14:0.14:0.14,
     thold_negedge$D$CK = -0.062:-0.062:-0.062,
     tsetup_negedge$E$CK = 0.1:0.13:0.13,
     thold_negedge$E$CK = -0.12:-0.056:-0.056,
     thold_negedge$SE$CK = -0.025:-0.025:-0.025,

     tsetup_negedge$SE$CK = 0.11:0.11:0.11,

     tsetup_negedge$SI$CK = 0.075:0.075:0.075,
     thold_negedge$SI$CK = -0.025:-0.025:-0.025,
     tsetup_posedge$D$CK = 0.16:0.16:0.16,
     thold_posedge$D$CK = -0.11:-0.11:-0.11,
     tsetup_posedge$E$CK = 0.14:0.15:0.15,
     thold_posedge$E$CK = -0.12:-0.12:-0.12,
     tsetup_posedge$SE$CK = 0.088:0.088:0.088,

     thold_posedge$SE$CK = -0.037:-0.037:-0.037,

     tsetup_posedge$SI$CK = 0.094:0.094:0.094,
     thold_posedge$SI$CK = -0.062:-0.062:-0.062;

      // path delays
      (posedge CK *> (QN -: SE?SI:(E?D:!NET536))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(E?D:!NET536))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SMDFFHQX1 (CK, D0, D1, Q, S0, SE, SI);
   input  CK ;
   input  D0 ;
   input  D1 ;
   input  S0 ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_out, D0, D1, S0);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D0);
   not (I7_out, D1);
   not (I9_out, S0);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1, I6_out, I7_out, I9_out, SI);
   not (I12_out, D0);
   not (I15_out, SI);
   and (D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0, I12_out, D1, S0, I15_out);
   not (I17_out, SE);
   and (S0_EQ_1_AN_SE_EQ_0, S0, I17_out);
   not (I19_out, S0);
   not (I20_out, SE);
   and (S0_EQ_0_AN_SE_EQ_0, I19_out, I20_out);
   not (I22_out, D0);
   not (I23_out, D1);
   not (I25_out, S0);
   not (I27_out, SE);
   not (I29_out, SI);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I22_out, I23_out, I25_out, I27_out, I29_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tminpwh$CK = 0.049:0.15:0.15,
     tminpwl$CK = 0.052:0.098:0.098,
     tsetup_negedge$D0$CK = 0.088:0.088:0.088,
     thold_negedge$D0$CK = -0.031:-0.031:-0.031,
     tsetup_negedge$D1$CK = 0.088:0.088:0.088,
     thold_negedge$D1$CK = -0.031:-0.031:-0.031,
     tsetup_negedge$S0$CK = 0.081:0.12:0.12,
     thold_negedge$S0$CK = -0.094:-0.025:-0.025,
     tsetup_negedge$SE$CK = 0.088:0.088:0.088,
     thold_negedge$SE$CK = -0.05:-0.05:-0.05,


     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$D0$CK = 0.11:0.11:0.11,
     thold_posedge$D0$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$D1$CK = 0.11:0.11:0.11,
     thold_posedge$D1$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$S0$CK = 0.1:0.11:0.11,
     thold_posedge$S0$CK = -0.075:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.056:0.056:0.056,
     thold_posedge$SE$CK = -0.019:-0.019:-0.019,


     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:(S0?D1:D0))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
      $setup(negedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& SE == 1'b0, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
      $setup(posedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& SE == 1'b0, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SMDFFHQX2 (CK, D0, D1, Q, S0, SE, SI);
   input  CK ;
   input  D0 ;
   input  D1 ;
   input  S0 ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_out, D0, D1, S0);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D0);
   not (I7_out, D1);
   not (I9_out, S0);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1, I6_out, I7_out, I9_out, SI);
   not (I12_out, D0);
   not (I15_out, SI);
   and (D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0, I12_out, D1, S0, I15_out);
   not (I17_out, SE);
   and (S0_EQ_1_AN_SE_EQ_0, S0, I17_out);
   not (I19_out, S0);
   not (I20_out, SE);
   and (S0_EQ_0_AN_SE_EQ_0, I19_out, I20_out);
   not (I22_out, D0);
   not (I23_out, D1);
   not (I25_out, S0);
   not (I27_out, SE);
   not (I29_out, SI);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I22_out, I23_out, I25_out, I27_out, I29_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.05:0.13:0.13,
     tminpwl$CK = 0.051:0.098:0.098,
     tsetup_negedge$D0$CK = 0.087:0.087:0.087,
     thold_negedge$D0$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$D1$CK = 0.087:0.087:0.087,
     thold_negedge$D1$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$S0$CK = 0.081:0.13:0.13,
     thold_negedge$S0$CK = -0.094:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.087:0.087:0.087,
     thold_negedge$SE$CK = -0.05:-0.05:-0.05,


     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$D0$CK = 0.12:0.12:0.12,
     thold_posedge$D0$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$D1$CK = 0.12:0.12:0.12,
     thold_posedge$D1$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$S0$CK = 0.1:0.11:0.11,
     thold_posedge$S0$CK = -0.075:-0.037:-0.037,
     tsetup_posedge$SE$CK = 0.056:0.056:0.056,
     thold_posedge$SE$CK = -0.019:-0.019:-0.019,


     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:(S0?D1:D0))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
      $setup(negedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& SE == 1'b0, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
      $setup(posedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& SE == 1'b0, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SMDFFHQX4 (CK, D0, D1, Q, S0, SE, SI);
   input  CK ;
   input  D0 ;
   input  D1 ;
   input  S0 ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_out, D0, D1, S0);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D0);
   not (I7_out, D1);
   not (I9_out, S0);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1, I6_out, I7_out, I9_out, SI);
   not (I12_out, D0);
   not (I15_out, SI);
   and (D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0, I12_out, D1, S0, I15_out);
   not (I17_out, SE);
   and (S0_EQ_1_AN_SE_EQ_0, S0, I17_out);
   not (I19_out, S0);
   not (I20_out, SE);
   and (S0_EQ_0_AN_SE_EQ_0, I19_out, I20_out);
   not (I22_out, D0);
   not (I23_out, D1);
   not (I25_out, S0);
   not (I27_out, SE);
   not (I29_out, SI);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I22_out, I23_out, I25_out, I27_out, I29_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.12:0.12:0.12,
     tminpwh$CK = 0.057:0.12:0.12,
     tminpwl$CK = 0.054:0.1:0.1,
     tsetup_negedge$D0$CK = 0.081:0.081:0.081,
     thold_negedge$D0$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$D1$CK = 0.088:0.088:0.088,
     thold_negedge$D1$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$S0$CK = 0.075:0.12:0.12,
     thold_negedge$S0$CK = -0.087:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.087:0.087:0.087,
     thold_negedge$SE$CK = -0.05:-0.05:-0.05,


     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.000000000027:-0.000000000027:-0.000000000027,
     tsetup_posedge$D0$CK = 0.11:0.11:0.11,
     thold_posedge$D0$CK = -0.075:-0.075:-0.075,
     tsetup_posedge$D1$CK = 0.11:0.11:0.11,
     thold_posedge$D1$CK = -0.075:-0.075:-0.075,
     tsetup_posedge$S0$CK = 0.1:0.11:0.11,
     thold_posedge$S0$CK = -0.069:-0.037:-0.037,
     tsetup_posedge$SE$CK = 0.056:0.056:0.056,
     thold_posedge$SE$CK = -0.013:-0.013:-0.013,


     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.037:-0.037:-0.037;

      // path delays
      (posedge CK *> (Q +: SE?SI:(S0?D1:D0))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
      $setup(negedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& SE == 1'b0, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
      $setup(posedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& SE == 1'b0, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SMDFFHQX8 (CK, D0, D1, Q, S0, SE, SI);
   input  CK ;
   input  D0 ;
   input  D1 ;
   input  S0 ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_out, D0, D1, S0);
   udp_mux2 (I0_D, I0_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D0);
   not (I7_out, D1);
   not (I9_out, S0);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1, I6_out, I7_out, I9_out, SI);
   not (I12_out, D0);
   not (I15_out, SI);
   and (D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0, I12_out, D1, S0, I15_out);
   not (I17_out, SE);
   and (S0_EQ_1_AN_SE_EQ_0, S0, I17_out);
   not (I19_out, S0);
   not (I20_out, SE);
   and (S0_EQ_0_AN_SE_EQ_0, I19_out, I20_out);
   not (I22_out, D0);
   not (I23_out, D1);
   not (I25_out, S0);
   not (I27_out, SE);
   not (I29_out, SI);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I22_out, I23_out, I25_out, I27_out, I29_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.066:0.13:0.13,
     tminpwl$CK = 0.053:0.1:0.1,
     tsetup_negedge$D0$CK = 0.088:0.088:0.088,
     thold_negedge$D0$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$D1$CK = 0.088:0.088:0.088,
     thold_negedge$D1$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$S0$CK = 0.081:0.13:0.13,
     thold_negedge$S0$CK = -0.087:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.088:0.088:0.088,
     thold_negedge$SE$CK = -0.05:-0.05:-0.05,


     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$D0$CK = 0.12:0.12:0.12,
     thold_posedge$D0$CK = -0.075:-0.075:-0.075,
     tsetup_posedge$D1$CK = 0.12:0.12:0.12,
     thold_posedge$D1$CK = -0.075:-0.075:-0.075,
     tsetup_posedge$S0$CK = 0.1:0.11:0.11,
     thold_posedge$S0$CK = -0.069:-0.031:-0.031,
     tsetup_posedge$SE$CK = 0.056:0.056:0.056,
     thold_posedge$SE$CK = -0.012:-0.012:-0.012,

 
     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.037:-0.037:-0.037;

      // path delays
      (posedge CK *> (Q +: SE?SI:(S0?D1:D0))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
      $setup(negedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& SE == 1'b0, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D0, posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_0_AN_SE_EQ_0 == 1'b1, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
      $setup(posedge D1, posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& SE == 1'b0, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1_AN_S0_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TBUFX16 (A, OE, Y);
   input  A ;
   input  OE ;
   output Y ;

   bufif1 (Y, A, OE);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.045:0.045:0.045,
     tphhl$A$Y = 0.04:0.04:0.04,
     tpzh$OE$Y = 0.042:0.042:0.042,
     tpzl$OE$Y = 0.062:0.062:0.062,
     tplz$OE$Y = 0.05:0.05:0.05,
     tphz$OE$Y = 0.025:0.025:0.025;

      // path delays
      (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TBUFX3 (A, OE, Y);
   input  A ;
   input  OE ;
   output Y ;

   bufif1 (Y, A, OE);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.056:0.056:0.056,
     tphhl$A$Y = 0.05:0.05:0.05,
     tpzh$OE$Y = 0.053:0.053:0.053,
     tpzl$OE$Y = 0.061:0.061:0.061,
     tplz$OE$Y = 0.034:0.034:0.034,
     tphz$OE$Y = 0.021:0.021:0.021;

      // path delays
      (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TBUFX6 (A, OE, Y);
   input  A ;
   input  OE ;
   output Y ;

   bufif1 (Y, A, OE);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.047:0.047:0.047,
     tphhl$A$Y = 0.044:0.044:0.044,
     tpzh$OE$Y = 0.044:0.044:0.044,
     tpzl$OE$Y = 0.063:0.063:0.063,
     tplz$OE$Y = 0.045:0.045:0.045,
     tphz$OE$Y = 0.021:0.021:0.021;

      // path delays
      (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TBUFX8 (A, OE, Y);
   input  A ;
   input  OE ;
   output Y ;

   bufif1 (Y, A, OE);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.048:0.048:0.048,
     tphhl$A$Y = 0.045:0.045:0.045,
     tpzh$OE$Y = 0.045:0.045:0.045,
     tpzl$OE$Y = 0.064:0.064:0.064,
     tplz$OE$Y = 0.047:0.047:0.047,
     tphz$OE$Y = 0.024:0.024:0.024;

      // path delays
      (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TBUFXL (A, OE, Y);
   input  A ;
   input  OE ;
   output Y ;

   bufif1 (Y, A, OE);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.1:0.1:0.1,
     tpzh$OE$Y = 0.11:0.11:0.11,
     tpzl$OE$Y = 0.11:0.11:0.11,
     tplz$OE$Y = 0.029:0.029:0.029,
     tphz$OE$Y = 0.017:0.017:0.017;

      // path delays
      (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TIELO (Y);
   output Y ;

   buf (Y, 'B0);


endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNCAX12 (CK, E, ECK);
   input  CK ;
   input  E ;
   output ECK ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (EINT, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, EINT);
   and (ECK, CK, EINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.12:0.12:0.12,
     tphhl$CK$ECK = 0.11:0.11:0.11,
     tminpwl$CK = 0.097:0.13:0.13,
     tsetup_negedge$E$CK = 0.0062:0.0062:0.0062,
     thold_negedge$E$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$E$CK = 0.037:0.037:0.037,
     thold_posedge$E$CK = -0.031:-0.031:-0.031;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(negedge CK &&& E == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNCAX2 (CK, E, ECK);
   input  CK ;
   input  E ;
   output ECK ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (EINT, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, EINT);
   and (ECK, CK, EINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.12:0.12:0.12,
     tphhl$CK$ECK = 0.098:0.098:0.099,
     tminpwl$CK = 0.066:0.099:0.099,
     tsetup_negedge$E$CK = 0.013:0.013:0.013,
     thold_negedge$E$CK = -0.0062:-0.0062:-0.0062,
     tsetup_posedge$E$CK = 0.031:0.031:0.031,
     thold_posedge$E$CK = -0.025:-0.025:-0.025;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(negedge CK &&& E == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNCAX20 (CK, E, ECK);
   input  CK ;
   input  E ;
   output ECK ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (EINT, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, EINT);
   and (ECK, CK, EINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.14:0.14:0.14,
     tphhl$CK$ECK = 0.12:0.12:0.12,
     tminpwl$CK = 0.12:0.15:0.15,
     tsetup_negedge$E$CK = 0.0063:0.0063:0.0063,
     thold_negedge$E$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$E$CK = 0.044:0.044:0.044,
     thold_posedge$E$CK = -0.037:-0.037:-0.037;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(negedge CK &&& E == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNCAX6 (CK, E, ECK);
   input  CK ;
   input  E ;
   output ECK ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (EINT, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, EINT);
   and (ECK, CK, EINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.11:0.11:0.11,
     tphhl$CK$ECK = 0.093:0.094:0.094,
     tminpwl$CK = 0.085:0.12:0.12,
     tsetup_negedge$E$CK = 0.012:0.012:0.012,
     thold_negedge$E$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$E$CK = 0.037:0.037:0.037,
     thold_posedge$E$CK = -0.031:-0.031:-0.031;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(negedge CK &&& E == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNSRX4 (D, GN, Q, QN, RN, SN);
   input  D ;
   input  GN ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, GN);
   and (I0_ENABLE, I0_out, RN);
   not (I0_SET, SN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (N5, QINT);
   buf (Q, QINT);
   not (QN, QINT);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I13_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.12:0.12:0.12,
     tphhl$D$Q = 0.14:0.14:0.14,
     tplhl$D$QN = 0.11:0.11:0.11,
     tphlh$D$QN = 0.13:0.13:0.13,
     tphlh$GN$Q = 0.19:0.19:0.19,
     tphhl$GN$Q = 0.2:0.2:0.2,
     tphlh$GN$QN = 0.19:0.19:0.19,
     tphhl$GN$QN = 0.18:0.18:0.18,
     tpllh$RN$Q = 0.18:0.18:0.18,
     tphhl$RN$Q = 0.15:0.17:0.18,
     tplhl$RN$QN = 0.17:0.17:0.17,
     tphlh$RN$QN = 0.14:0.16:0.17,
     tplhl$SN$Q = 0.086:0.087:0.087,
     tphlh$SN$Q = 0.062:0.062:0.062,
     tpllh$SN$QN = 0.079:0.079:0.079,
     tphhl$SN$QN = 0.053:0.053:0.053,
     tminpwl$GN = 0.095:0.2:0.2,
     tminpwl$RN = 0.047:0.15:0.15,
     tminpwl$SN = 0.023:0.1:0.1,
     tsetup_negedge$D$GN = 0.056:0.056:0.056,
     thold_negedge$D$GN = -0.031:-0.031:-0.031,
     tsetup_posedge$D$GN = 0.031:0.031:0.031,
     thold_posedge$D$GN = -0.012:-0.012:-0.012,
     tsetup_posedge$RN$GN = 0.088:0.088:0.088,
     thold_posedge$RN$GN = -0.075:-0.075:-0.075,
     trec$SN$GN = -0.0062:-0.0062:-0.0062,
     trem$SN$GN = 0.038:0.038:0.038,
     trec$SN$RN = 0.019:0.019:0.019,
     trem$SN$RN = 0.012:0.012:0.012;

      // path delays
      (posedge RN *> (QN -: 1'b1)) = (0, tplhl$RN$QN);
      (posedge RN *> (Q +: 1'b1)) = (tpllh$RN$Q, 0);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
      (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$GN, NOTIFIER);
      $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$GN,  NOTIFIER);
      $setup(posedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$GN, NOTIFIER);
      $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$GN,  NOTIFIER);
      $setup(posedge RN, posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$GN, NOTIFIER);
      $hold (posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$GN,  NOTIFIER);
      $recovery(posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$GN, NOTIFIER);
      $removal (posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$GN, NOTIFIER);
      $recovery(posedge SN, posedge RN &&& GN == 1'b1, trec$SN$RN, NOTIFIER);
      $removal (posedge SN, posedge RN &&& GN == 1'b1, trem$SN$RN, NOTIFIER);
      $width(negedge GN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$GN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNSRXL (D, GN, Q, QN, RN, SN);
   input  D ;
   input  GN ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, GN);
   and (I0_ENABLE, I0_out, RN);
   not (I0_SET, SN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (N5, QINT);
   buf (Q, QINT);
   not (QN, QINT);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I13_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.16:0.16:0.16,
     tphhl$D$Q = 0.18:0.18:0.18,
     tplhl$D$QN = 0.15:0.15:0.15,
     tphlh$D$QN = 0.17:0.17:0.17,
     tphlh$GN$Q = 0.22:0.22:0.22,
     tphhl$GN$Q = 0.22:0.22:0.22,
     tphlh$GN$QN = 0.22:0.22:0.22,
     tphhl$GN$QN = 0.21:0.21:0.21,
     tpllh$RN$Q = 0.21:0.21:0.21,
     tphhl$RN$Q = 0.19:0.2:0.22,
     tplhl$RN$QN = 0.2:0.2:0.2,
     tphlh$RN$QN = 0.18:0.2:0.21,
     tplhl$SN$Q = 0.14:0.14:0.14,
     tphlh$SN$Q = 0.12:0.12:0.12,
     tpllh$SN$QN = 0.13:0.13:0.13,
     tphhl$SN$QN = 0.11:0.11:0.11,
     tminpwl$GN = 0.075:0.22:0.22,
     tminpwl$RN = 0.038:0.19:0.19,
     tminpwl$SN = 0.02:0.12:0.12,
     tsetup_negedge$D$GN = 0.037:0.037:0.037,
     thold_negedge$D$GN = -0.025:-0.025:-0.025,
     tsetup_posedge$D$GN = 0.013:0.013:0.013,
     thold_posedge$D$GN = 0:0:0,
     tsetup_posedge$RN$GN = 0.069:0.069:0.069,
     thold_posedge$RN$GN = -0.056:-0.056:-0.056,
     trec$SN$GN = -0.012:-0.012:-0.012,
     trem$SN$GN = 0.031:0.031:0.031,
     trec$SN$RN = 0.0062:0.0062:0.0062,
     trem$SN$RN = 0.012:0.012:0.012;

      // path delays
      (posedge RN *> (QN -: 1'b1)) = (0, tplhl$RN$QN);
      (posedge RN *> (Q +: 1'b1)) = (tpllh$RN$Q, 0);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
      (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$GN, NOTIFIER);
      $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$GN,  NOTIFIER);
      $setup(posedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$GN, NOTIFIER);
      $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$GN,  NOTIFIER);
      $setup(posedge RN, posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$GN, NOTIFIER);
      $hold (posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$GN,  NOTIFIER);
      $recovery(posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$GN, NOTIFIER);
      $removal (posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$GN, NOTIFIER);
      $recovery(posedge SN, posedge RN &&& GN == 1'b1, trec$SN$RN, NOTIFIER);
      $removal (posedge SN, posedge RN &&& GN == 1'b1, trem$SN$RN, NOTIFIER);
      $width(negedge GN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$GN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNTSCAX16 (CK, E, ECK, SE);
   input  CK ;
   input  E ;
   input  SE ;
   output ECK ;
   reg 	  NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (EINT, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N5, EINT);
   and (ECK, CK, EINT);
   not (I6_out, E);
   not (I7_out, SE);
   and (E_EQ_0_AN_SE_EQ_0, I6_out, I7_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.13:0.13:0.13,
     tphhl$CK$ECK = 0.11:0.11:0.11,
     tminpwl$CK = 0.088:0.13:0.13,
     tsetup_negedge$E$CK = 0.05:0.05:0.05,
     thold_negedge$E$CK = -0.044:-0.044:-0.044,
     tsetup_negedge$SE$CK = 0.05:0.05:0.05,
     thold_negedge$SE$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$E$CK = 0.05:0.05:0.05,
     thold_posedge$E$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.05:0.05:0.05,
     thold_posedge$SE$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $width(negedge CK &&& E_EQ_0_AN_SE_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNTSCAX4 (CK, E, ECK, SE);
   input  CK ;
   input  E ;
   input  SE ;
   output ECK ;
   reg 	  NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (EINT, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N5, EINT);
   and (ECK, CK, EINT);
   not (I6_out, E);
   not (I7_out, SE);
   and (E_EQ_0_AN_SE_EQ_0, I6_out, I7_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.11:0.11:0.11,
     tphhl$CK$ECK = 0.097:0.097:0.097,
     tminpwl$CK = 0.063:0.099:0.099,
     tsetup_negedge$E$CK = 0.044:0.044:0.044,
     thold_negedge$E$CK = -0.037:-0.037:-0.037,
     tsetup_negedge$SE$CK = 0.05:0.05:0.05,
     thold_negedge$SE$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$E$CK = 0.044:0.044:0.044,
     thold_posedge$E$CK = -0.037:-0.037:-0.037,
     tsetup_posedge$SE$CK = 0.044:0.044:0.044,
     thold_posedge$SE$CK = -0.038:-0.038:-0.038;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $width(negedge CK &&& E_EQ_0_AN_SE_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNTSCAX8 (CK, E, ECK, SE);
   input  CK ;
   input  E ;
   input  SE ;
   output ECK ;
   reg 	  NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (EINT, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N5, EINT);
   and (ECK, CK, EINT);
   not (I6_out, E);
   not (I7_out, SE);
   and (E_EQ_0_AN_SE_EQ_0, I6_out, I7_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.11:0.11:0.11,
     tphhl$CK$ECK = 0.098:0.098:0.098,
     tminpwl$CK = 0.071:0.11:0.11,
     tsetup_negedge$E$CK = 0.05:0.05:0.05,
     thold_negedge$E$CK = -0.044:-0.044:-0.044,
     tsetup_negedge$SE$CK = 0.05:0.05:0.05,
     thold_negedge$SE$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$E$CK = 0.044:0.044:0.044,
     thold_posedge$E$CK = -0.037:-0.037:-0.037,
     tsetup_posedge$SE$CK = 0.044:0.044:0.044,
     thold_posedge$SE$CK = -0.037:-0.037:-0.037;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $width(negedge CK &&& E_EQ_0_AN_SE_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNX2 (D, GN, Q, QN);
   input  D ;
   input  GN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, GN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, QINT);
   buf (Q, QINT);
   not (QN, QINT);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.12:0.12:0.12,
     tphhl$D$Q = 0.12:0.12:0.12,
     tplhl$D$QN = 0.11:0.11:0.11,
     tphlh$D$QN = 0.11:0.11:0.11,
     tphlh$GN$Q = 0.14:0.14:0.14,
     tphhl$GN$Q = 0.15:0.15:0.15,
     tphlh$GN$QN = 0.15:0.15:0.15,
     tphhl$GN$QN = 0.13:0.13:0.13,
     tminpwl$GN = 0.052:0.15:0.15,
     tsetup_negedge$D$GN = 0.031:0.031:0.031,
     thold_negedge$D$GN = -0.013:-0.013:-0.013,
     tsetup_posedge$D$GN = 0.05:0.05:0.05,
     thold_posedge$D$GN = -0.031:-0.031:-0.031;

      // path delays
      (negedge GN *> (QN -: D)) = (tphlh$GN$QN, tphhl$GN$QN);
      (negedge GN *> (Q +: D)) = (tphlh$GN$Q, tphhl$GN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, posedge GN, tsetup_negedge$D$GN, NOTIFIER);
      $hold (posedge GN, negedge D, thold_negedge$D$GN,  NOTIFIER);
      $setup(posedge D, posedge GN, tsetup_posedge$D$GN, NOTIFIER);
      $hold (posedge GN, posedge D, thold_posedge$D$GN,  NOTIFIER);
      $width(negedge GN &&& D == 1'b0, tminpwl$GN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNXL (D, GN, Q, QN);
   input  D ;
   input  GN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, GN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, QINT);
   buf (Q, QINT);
   not (QN, QINT);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.16:0.16:0.16,
     tphhl$D$Q = 0.16:0.16:0.16,
     tplhl$D$QN = 0.15:0.15:0.15,
     tphlh$D$QN = 0.15:0.15:0.15,
     tphlh$GN$Q = 0.18:0.18:0.18,
     tphhl$GN$Q = 0.19:0.19:0.19,
     tphlh$GN$QN = 0.18:0.18:0.18,
     tphhl$GN$QN = 0.17:0.17:0.17,
     tminpwl$GN = 0.049:0.19:0.19,
     tsetup_negedge$D$GN = 0.025:0.025:0.025,
     thold_negedge$D$GN = -0.012:-0.012:-0.012,
     tsetup_posedge$D$GN = 0.044:0.044:0.044,
     thold_posedge$D$GN = -0.031:-0.031:-0.031;

      // path delays
      (negedge GN *> (QN -: D)) = (tphlh$GN$QN, tphhl$GN$QN);
      (negedge GN *> (Q +: D)) = (tphlh$GN$Q, tphhl$GN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, posedge GN, tsetup_negedge$D$GN, NOTIFIER);
      $hold (posedge GN, negedge D, thold_negedge$D$GN,  NOTIFIER);
      $setup(posedge D, posedge GN, tsetup_posedge$D$GN, NOTIFIER);
      $hold (posedge GN, posedge D, thold_posedge$D$GN,  NOTIFIER);
      $width(negedge GN &&& D == 1'b0, tminpwl$GN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATSRX2 (D, G, Q, QN, RN, SN);
   input  D ;
   input  G ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_ENABLE, G, RN);
   not (I0_SET, SN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (N5, QINT);
   buf (Q, QINT);
   not (QN, QINT);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I12_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.13:0.13:0.13,
     tphhl$D$Q = 0.16:0.16:0.16,
     tplhl$D$QN = 0.12:0.12:0.12,
     tphlh$D$QN = 0.15:0.15:0.15,
     tpllh$G$Q = 0.19:0.19:0.19,
     tplhl$G$Q = 0.2:0.2:0.2,
     tpllh$G$QN = 0.2:0.2:0.2,
     tplhl$G$QN = 0.18:0.18:0.18,
     tpllh$RN$Q = 0.19:0.19:0.19,
     tphhl$RN$Q = 0.16:0.18:0.2,
     tplhl$RN$QN = 0.19:0.19:0.19,
     tphlh$RN$QN = 0.16:0.18:0.2,
     tplhl$SN$Q = 0.1:0.1:0.11,
     tphlh$SN$Q = 0.077:0.077:0.078,
     tpllh$SN$QN = 0.1:0.1:0.1,
     tphhl$SN$QN = 0.071:0.072:0.072,
     tminpwh$G = 0.081:0.2:0.2,
     tminpwl$RN = 0.043:0.16:0.16,
     tminpwl$SN = 0.028:0.1:0.1,
     tsetup_negedge$D$G = 0.069:0.069:0.069,
     thold_negedge$D$G = -0.044:-0.044:-0.044,
     tsetup_posedge$D$G = 0.037:0.037:0.037,
     thold_posedge$D$G = -0.019:-0.019:-0.019,
     tsetup_posedge$RN$G = 0.11:0.11:0.11,
     thold_posedge$RN$G = -0.088:-0.088:-0.088,
     trec$SN$G = 0.012:0.012:0.012,
     trem$SN$G = 0.019:0.019:0.019,
     trec$SN$RN = 0.019:0.019:0.019,
     trem$SN$RN = 0.0062:0.0062:0.0062;

      // path delays
      (posedge RN *> (QN -: 1'b1)) = (0, tplhl$RN$QN);
      (posedge RN *> (Q +: 1'b1)) = (tpllh$RN$Q, 0);
      (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
      (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$G, NOTIFIER);
      $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$G,  NOTIFIER);
      $setup(posedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$G, NOTIFIER);
      $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$G,  NOTIFIER);
      $setup(posedge RN, negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$G, NOTIFIER);
      $hold (negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$G,  NOTIFIER);
      $recovery(posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$G, NOTIFIER);
      $removal (posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$G, NOTIFIER);
      $recovery(posedge SN, posedge RN &&& G == 1'b0, trec$SN$RN, NOTIFIER);
      $removal (posedge SN, posedge RN &&& G == 1'b0, trem$SN$RN, NOTIFIER);
      $width(posedge G &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$G, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATSRX4 (D, G, Q, QN, RN, SN);
   input  D ;
   input  G ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_ENABLE, G, RN);
   not (I0_SET, SN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (N5, QINT);
   buf (Q, QINT);
   not (QN, QINT);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I12_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.12:0.12:0.12,
     tphhl$D$Q = 0.14:0.14:0.14,
     tplhl$D$QN = 0.11:0.11:0.11,
     tphlh$D$QN = 0.13:0.13:0.13,
     tpllh$G$Q = 0.19:0.19:0.19,
     tplhl$G$Q = 0.2:0.2:0.2,
     tpllh$G$QN = 0.19:0.19:0.19,
     tplhl$G$QN = 0.18:0.18:0.18,
     tpllh$RN$Q = 0.19:0.19:0.19,
     tphhl$RN$Q = 0.15:0.17:0.19,
     tplhl$RN$QN = 0.18:0.18:0.18,
     tphlh$RN$QN = 0.14:0.16:0.18,
     tplhl$SN$Q = 0.087:0.087:0.087,
     tphlh$SN$Q = 0.063:0.063:0.063,
     tpllh$SN$QN = 0.078:0.078:0.079,
     tphhl$SN$QN = 0.053:0.053:0.053,
     tminpwh$G = 0.098:0.2:0.2,
     tminpwl$RN = 0.047:0.15:0.15,
     tminpwl$SN = 0.023:0.1:0.1,
     tsetup_negedge$D$G = 0.062:0.062:0.062,
     thold_negedge$D$G = -0.044:-0.044:-0.044,
     tsetup_posedge$D$G = 0.031:0.031:0.031,
     thold_posedge$D$G = -0.012:-0.012:-0.012,
     tsetup_posedge$RN$G = 0.11:0.11:0.11,
     thold_posedge$RN$G = -0.094:-0.094:-0.094,
     trec$SN$G = 0.0062:0.0062:0.0062,
     trem$SN$G = 0.031:0.031:0.031,
     trec$SN$RN = 0.012:0.012:0.012,
     trem$SN$RN = 0.012:0.012:0.012;

      // path delays
      (posedge RN *> (QN -: 1'b1)) = (0, tplhl$RN$QN);
      (posedge RN *> (Q +: 1'b1)) = (tpllh$RN$Q, 0);
      (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
      (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$G, NOTIFIER);
      $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$G,  NOTIFIER);
      $setup(posedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$G, NOTIFIER);
      $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$G,  NOTIFIER);
      $setup(posedge RN, negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$G, NOTIFIER);
      $hold (negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$G,  NOTIFIER);
      $recovery(posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$G, NOTIFIER);
      $removal (posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$G, NOTIFIER);
      $recovery(posedge SN, posedge RN &&& G == 1'b0, trec$SN$RN, NOTIFIER);
      $removal (posedge SN, posedge RN &&& G == 1'b0, trem$SN$RN, NOTIFIER);
      $width(posedge G &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$G, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATX2 (D, G, Q, QN);
   input  D ;
   input  G ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_tlat (QINT, D, G, 1'B0, 1'B0, NOTIFIER);
   not (N0, QINT);
   buf (Q, QINT);
   not (QN, QINT);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.12:0.12:0.12,
     tphhl$D$Q = 0.12:0.12:0.12,
     tplhl$D$QN = 0.11:0.11:0.11,
     tphlh$D$QN = 0.11:0.11:0.11,
     tpllh$G$Q = 0.15:0.15:0.15,
     tplhl$G$Q = 0.13:0.13:0.13,
     tpllh$G$QN = 0.13:0.13:0.13,
     tplhl$G$QN = 0.14:0.14:0.14,
     tminpwh$G = 0.049:0.13:0.13,
     tsetup_negedge$D$G = 0.05:0.05:0.05,
     thold_negedge$D$G = -0.031:-0.031:-0.031,
     tsetup_posedge$D$G = 0.031:0.031:0.031,
     thold_posedge$D$G = -0.012:-0.012:-0.012;

      // path delays
      (posedge G *> (QN -: D)) = (tpllh$G$QN, tplhl$G$QN);
      (posedge G *> (Q +: D)) = (tpllh$G$Q, tplhl$G$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, negedge G, tsetup_negedge$D$G, NOTIFIER);
      $hold (negedge G, negedge D, thold_negedge$D$G,  NOTIFIER);
      $setup(posedge D, negedge G, tsetup_posedge$D$G, NOTIFIER);
      $hold (negedge G, posedge D, thold_posedge$D$G,  NOTIFIER);
      $width(posedge G &&& D == 1'b0, tminpwh$G, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATXL (D, G, Q, QN);
   input  D ;
   input  G ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_tlat (QINT, D, G, 1'B0, 1'B0, NOTIFIER);
   not (N0, QINT);
   buf (Q, QINT);
   not (QN, QINT);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.16:0.16:0.16,
     tphhl$D$Q = 0.16:0.16:0.16,
     tplhl$D$QN = 0.15:0.15:0.15,
     tphlh$D$QN = 0.15:0.15:0.15,
     tpllh$G$Q = 0.19:0.19:0.19,
     tplhl$G$Q = 0.18:0.18:0.18,
     tpllh$G$QN = 0.17:0.17:0.17,
     tplhl$G$QN = 0.18:0.18:0.18,
     tminpwh$G = 0.047:0.18:0.18,
     tsetup_negedge$D$G = 0.044:0.044:0.044,
     thold_negedge$D$G = -0.031:-0.031:-0.031,
     tsetup_posedge$D$G = 0.019:0.019:0.019,
     thold_posedge$D$G = -0.0063:-0.0063:-0.0063;

      // path delays
      (posedge G *> (QN -: D)) = (tpllh$G$QN, tplhl$G$QN);
      (posedge G *> (Q +: D)) = (tpllh$G$Q, tplhl$G$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, negedge G, tsetup_negedge$D$G, NOTIFIER);
      $hold (negedge G, negedge D, thold_negedge$D$G,  NOTIFIER);
      $setup(posedge D, negedge G, tsetup_posedge$D$G, NOTIFIER);
      $hold (negedge G, posedge D, thold_posedge$D$G,  NOTIFIER);
      $width(posedge G &&& D == 1'b0, tminpwh$G, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XNOR2X1 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.1:0.1:0.1,
     tplhl$A$Y = 0.12:0.12:0.12,
     tphlh$A$Y = 0.12:0.12:0.12,
     tphhl$A$Y = 0.11:0.11:0.11,
     tpllh$B$Y = 0.085:0.085:0.085,
     tplhl$B$Y = 0.096:0.096:0.096,
     tphlh$B$Y = 0.11:0.11:0.11,
     tphhl$B$Y = 0.093:0.093:0.093;

      // path delays
      (posedge B *> (Y +: A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: !A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: !B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XNOR2X2 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.089:0.089:0.089,
     tplhl$A$Y = 0.11:0.11:0.11,
     tphlh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.094:0.094:0.094,
     tpllh$B$Y = 0.075:0.075:0.075,
     tplhl$B$Y = 0.085:0.085:0.085,
     tphlh$B$Y = 0.099:0.099:0.099,
     tphhl$B$Y = 0.084:0.084:0.084;

      // path delays
      (posedge B *> (Y +: A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: !A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: !B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XNOR2X4 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.099:0.099:0.099,
     tplhl$A$Y = 0.1:0.1:0.1,
     tphlh$A$Y = 0.1:0.1:0.1,
     tphhl$A$Y = 0.1:0.1:0.1,
     tpllh$B$Y = 0.076:0.076:0.076,
     tplhl$B$Y = 0.087:0.087:0.087,
     tphlh$B$Y = 0.087:0.087:0.087,
     tphhl$B$Y = 0.071:0.071:0.071;

      // path delays
      (posedge B *> (Y +: A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: !A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: !B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XNOR2XL (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.12:0.12:0.12,
     tplhl$A$Y = 0.14:0.14:0.14,
     tphlh$A$Y = 0.14:0.14:0.14,
     tphhl$A$Y = 0.13:0.13:0.13,
     tpllh$B$Y = 0.11:0.11:0.11,
     tplhl$B$Y = 0.12:0.12:0.12,
     tphlh$B$Y = 0.13:0.13:0.13,
     tphhl$B$Y = 0.11:0.11:0.11;

      // path delays
      (posedge B *> (Y +: A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: !A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: !B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XOR2X1 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.1:0.1:0.1,
     tplhl$A$Y = 0.12:0.12:0.12,
     tphlh$A$Y = 0.12:0.12:0.12,
     tphhl$A$Y = 0.11:0.11:0.11,
     tpllh$B$Y = 0.091:0.091:0.091,
     tplhl$B$Y = 0.11:0.11:0.11,
     tphlh$B$Y = 0.092:0.092:0.092,
     tphhl$B$Y = 0.091:0.091:0.091;

      // path delays
      (posedge B *> (Y +: !A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: !B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XOR2X2 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.091:0.091:0.091,
     tplhl$A$Y = 0.11:0.11:0.11,
     tphlh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.095:0.095:0.095,
     tpllh$B$Y = 0.08:0.08:0.08,
     tplhl$B$Y = 0.099:0.099:0.099,
     tphlh$B$Y = 0.08:0.08:0.08,
     tphhl$B$Y = 0.08:0.08:0.08;

      // path delays
      (posedge B *> (Y +: !A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: !B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XOR2X4 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.1:0.1:0.1,
     tplhl$A$Y = 0.1:0.1:0.1,
     tphlh$A$Y = 0.099:0.099:0.099,
     tphhl$A$Y = 0.1:0.1:0.1,
     tpllh$B$Y = 0.069:0.069:0.069,
     tplhl$B$Y = 0.091:0.091:0.091,
     tphlh$B$Y = 0.083:0.083:0.083,
     tphhl$B$Y = 0.083:0.083:0.083;

      // path delays
      (posedge B *> (Y +: !A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: !B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XOR2XL (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.13:0.13:0.13,
     tplhl$A$Y = 0.14:0.14:0.14,
     tphlh$A$Y = 0.14:0.14:0.14,
     tphhl$A$Y = 0.13:0.13:0.13,
     tpllh$B$Y = 0.12:0.12:0.12,
     tplhl$B$Y = 0.13:0.13:0.13,
     tphlh$B$Y = 0.12:0.12:0.12,
     tphhl$B$Y = 0.11:0.11:0.11;

      // path delays
      (posedge B *> (Y +: !A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: !B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ACHCONX2 (A, B, CI, CON);
   input  A ;
   input  B ;
   input  CI ;
   output CON ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (I4_out, I0_out, I1_out, I3_out);
   not (CON, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A$CON = 0.13:0.13:0.13,
     tphlh$A$CON = 0.12:0.12:0.12,
     tplhl$B$CON = 0.09:0.09:0.091,
     tphlh$B$CON = 0.081:0.083:0.084,
     tplhl$CI$CON = 0.061:0.061:0.062,
     tphlh$CI$CON = 0.053:0.053:0.053;

      // path delays
      (CI *> CON) = (tphlh$CI$CON, tplhl$CI$CON);
      (B *> CON) = (tphlh$B$CON, tplhl$B$CON);
      (A *> CON) = (tphlh$A$CON, tplhl$A$CON);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDFX2 (A, B, CI, CO, S);
   input  A ;
   input  B ;
   input  CI ;
   output CO ;
   output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.097:0.11:0.13,
     tplhl$A$S = 0.17:0.17:0.18,
     tphlh$A$S = 0.17:0.18:0.18,
     tphhl$A$S = 0.1:0.12:0.13,
     tpllh$A$CO = 0.11:0.11:0.11,
     tphhl$A$CO = 0.12:0.12:0.12,
     tpllh$B$S = 0.093:0.11:0.13,
     tplhl$B$S = 0.17:0.17:0.17,
     tphlh$B$S = 0.17:0.18:0.18,
     tphhl$B$S = 0.1:0.11:0.13,
     tpllh$B$CO = 0.11:0.11:0.11,
     tphhl$B$CO = 0.12:0.12:0.12,
     tpllh$CI$S = 0.092:0.11:0.12,
     tplhl$CI$S = 0.17:0.17:0.17,
     tphlh$CI$S = 0.17:0.17:0.17,
     tphhl$CI$S = 0.1:0.11:0.13,
     tpllh$CI$CO = 0.1:0.1:0.1,
     tphhl$CI$CO = 0.11:0.11:0.11;

      // path delays
      (posedge CI *> (S +: !(B^A))) = (tpllh$CI$S, tplhl$CI$S);
      (negedge CI *> (S +: B^A)) = (tphlh$CI$S, tphhl$CI$S);
      (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
      (posedge B *> (S +: CI^!A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: CI^A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: CI^!B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: CI^B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDFX4 (A, B, CI, CO, S);
   input  A ;
   input  B ;
   input  CI ;
   output CO ;
   output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.083:0.097:0.11,
     tplhl$A$S = 0.16:0.16:0.16,
     tphlh$A$S = 0.16:0.16:0.16,
     tphhl$A$S = 0.087:0.1:0.12,
     tpllh$A$CO = 0.091:0.091:0.092,
     tphhl$A$CO = 0.095:0.095:0.096,
     tpllh$B$S = 0.081:0.095:0.11,
     tplhl$B$S = 0.15:0.16:0.16,
     tphlh$B$S = 0.15:0.16:0.16,
     tphhl$B$S = 0.085:0.099:0.11,
     tpllh$B$CO = 0.086:0.089:0.091,
     tphhl$B$CO = 0.093:0.093:0.093,
     tpllh$CI$S = 0.079:0.093:0.11,
     tplhl$CI$S = 0.15:0.15:0.15,
     tphlh$CI$S = 0.15:0.15:0.15,
     tphhl$CI$S = 0.086:0.097:0.11,
     tpllh$CI$CO = 0.082:0.084:0.086,
     tphhl$CI$CO = 0.088:0.088:0.089;

      // path delays
      (posedge CI *> (S +: !(B^A))) = (tpllh$CI$S, tplhl$CI$S);
      (negedge CI *> (S +: B^A)) = (tphlh$CI$S, tphhl$CI$S);
      (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
      (posedge B *> (S +: CI^!A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: CI^A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: CI^!B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: CI^B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDHX1 (A, B, CO, S);
   input  A ;
   input  B ;
   output CO ;
   output S ;

   and (CO, A, B);
   xor (S, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.098:0.098:0.098,
     tplhl$A$S = 0.11:0.11:0.11,
     tphlh$A$S = 0.11:0.11:0.11,
     tphhl$A$S = 0.1:0.1:0.1,
     tpllh$A$CO = 0.087:0.087:0.087,
     tphhl$A$CO = 0.072:0.072:0.072,
     tpllh$B$S = 0.085:0.085:0.085,
     tplhl$B$S = 0.11:0.11:0.11,
     tphlh$B$S = 0.091:0.091:0.091,
     tphhl$B$S = 0.086:0.086:0.086,
     tpllh$B$CO = 0.085:0.085:0.085,
     tphhl$B$CO = 0.07:0.07:0.07;

      // path delays
      (posedge B *> (S +: !A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: !B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND3X4 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.096:0.096:0.096,
     tphhl$A$Y = 0.051:0.051:0.051,
     tpllh$B$Y = 0.094:0.094:0.094,
     tphhl$B$Y = 0.05:0.05:0.05,
     tpllh$C$Y = 0.089:0.089:0.089,
     tphhl$C$Y = 0.048:0.048:0.048;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND3X6 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.077:0.077:0.077,
     tphhl$A$Y = 0.041:0.041:0.041,
     tpllh$B$Y = 0.075:0.075:0.075,
     tphhl$B$Y = 0.04:0.04:0.04,
     tpllh$C$Y = 0.071:0.071:0.071,
     tphhl$C$Y = 0.039:0.039:0.039;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AO22X4 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (Y, I0_out, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.079:0.08:0.082,
     tphhl$A0$Y = 0.07:0.078:0.086,
     tpllh$A1$Y = 0.076:0.078:0.079,
     tphhl$A1$Y = 0.068:0.075:0.082,
     tpllh$B0$Y = 0.068:0.069:0.07,
     tphhl$B0$Y = 0.06:0.068:0.076,
     tpllh$B1$Y = 0.065:0.067:0.068,
     tphhl$B1$Y = 0.057:0.065:0.073;

      // path delays
      (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI21X4 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (I1_out, I0_out, B0);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.039:0.039:0.039,
     tphlh$A0$Y = 0.039:0.039:0.039,
     tplhl$A1$Y = 0.037:0.037:0.037,
     tphlh$A1$Y = 0.036:0.036:0.036,
     tplhl$B0$Y = 0.017:0.018:0.018,
     tphlh$B0$Y = 0.023:0.028:0.032;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI221X1 (A0, A1, B0, B1, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.11:0.11:0.11,
     tphlh$A0$Y = 0.13:0.15:0.16,
     tplhl$A1$Y = 0.11:0.11:0.11,
     tphlh$A1$Y = 0.13:0.15:0.16,
     tplhl$B0$Y = 0.1:0.1:0.1,
     tphlh$B0$Y = 0.13:0.14:0.16,
     tplhl$B1$Y = 0.098:0.098:0.099,
     tphlh$B1$Y = 0.12:0.14:0.15,
     tplhl$C0$Y = 0.05:0.05:0.05,
     tphlh$C0$Y = 0.09:0.12:0.14;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI222X2 (A0, A1, B0, B1, C0, C1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   input  C1 ;
   output Y ;

   and (I0_out, C0, C1);
   and (I1_out, A0, A1);
   and (I3_out, B0, B1);
   or  (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.073:0.075:0.078,
     tphlh$A0$Y = 0.077:0.096:0.11,
     tplhl$A1$Y = 0.07:0.073:0.075,
     tphlh$A1$Y = 0.075:0.094:0.11,
     tplhl$B0$Y = 0.065:0.067:0.068,
     tphlh$B0$Y = 0.069:0.088:0.11,
     tplhl$B1$Y = 0.063:0.064:0.065,
     tphlh$B1$Y = 0.066:0.084:0.1,
     tplhl$C0$Y = 0.056:0.056:0.056,
     tphlh$C0$Y = 0.055:0.072:0.089,
     tplhl$C1$Y = 0.054:0.054:0.054,
     tphlh$C1$Y = 0.053:0.07:0.086;

      // path delays
      (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI2BB2X1 (A0N, A1N, B0, B1, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   or  (I1_out, A0N, A1N);
   not (I2_out, I1_out);
   or  (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.099:0.11:0.12,
     tphhl$A0N$Y = 0.12:0.12:0.12,
     tpllh$A1N$Y = 0.098:0.11:0.12,
     tphhl$A1N$Y = 0.12:0.12:0.12,
     tplhl$B0$Y = 0.092:0.092:0.092,
     tphlh$B0$Y = 0.071:0.084:0.097,
     tplhl$B1$Y = 0.089:0.09:0.09,
     tphlh$B1$Y = 0.068:0.081:0.094;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI2BB2X4 (A0N, A1N, B0, B1, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   or  (I1_out, A0N, A1N);
   not (I2_out, I1_out);
   or  (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.064:0.069:0.074,
     tphhl$A0N$Y = 0.072:0.074:0.075,
     tpllh$A1N$Y = 0.062:0.067:0.072,
     tphhl$A1N$Y = 0.07:0.071:0.072,
     tplhl$B0$Y = 0.035:0.035:0.035,
     tphlh$B0$Y = 0.027:0.032:0.037,
     tplhl$B1$Y = 0.032:0.032:0.032,
     tphlh$B1$Y = 0.025:0.03:0.035;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI31X1 (A0, A1, A2, B0, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   output Y ;

   and (I1_out, A0, A1, A2);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.15:0.15:0.15,
     tphlh$A0$Y = 0.1:0.1:0.1,
     tplhl$A1$Y = 0.14:0.14:0.14,
     tphlh$A1$Y = 0.1:0.1:0.1,
     tplhl$A2$Y = 0.14:0.14:0.14,
     tphlh$A2$Y = 0.097:0.097:0.097,
     tplhl$B0$Y = 0.049:0.049:0.049,
     tphlh$B0$Y = 0.06:0.077:0.094;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI32X1 (A0, A1, A2, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   and (I2_out, A0, A1, A2);
   or  (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.15:0.16:0.16,
     tphlh$A0$Y = 0.086:0.098:0.11,
     tplhl$A1$Y = 0.15:0.15:0.15,
     tphlh$A1$Y = 0.084:0.096:0.11,
     tplhl$A2$Y = 0.15:0.15:0.15,
     tphlh$A2$Y = 0.081:0.093:0.1,
     tplhl$B0$Y = 0.092:0.092:0.092,
     tphlh$B0$Y = 0.063:0.081:0.099,
     tplhl$B1$Y = 0.089:0.089:0.089,
     tphlh$B1$Y = 0.061:0.079:0.096;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module BMXIX2 (A, M0, M1, PPN, S, X2);
   input  A ;
   input  M0 ;
   input  M1 ;
   input  S ;
   input  X2 ;
   output PPN ;

   udp_mux2 (I0_out, S, A, M0);
   udp_mux2 (I1_out, S, A, M1);
   udp_mux2 (PPN, I1_out, I0_out, X2);

    specify
      // delay parameters
      specparam
	tpllh$A$PPN = 0.13:0.14:0.14,
     tphhl$A$PPN = 0.14:0.15:0.15,
     tpllh$M0$PPN = 0.13:0.13:0.13,
     tplhl$M0$PPN = 0.15:0.15:0.15,
     tphlh$M0$PPN = 0.15:0.15:0.15,
     tphhl$M0$PPN = 0.13:0.13:0.13,
     tpllh$M1$PPN = 0.13:0.13:0.13,
     tplhl$M1$PPN = 0.16:0.16:0.16,
     tphlh$M1$PPN = 0.15:0.15:0.15,
     tphhl$M1$PPN = 0.14:0.14:0.14,
     tpllh$S$PPN = 0.13:0.14:0.14,
     tphhl$S$PPN = 0.14:0.14:0.15,
     tpllh$X2$PPN = 0.09:0.09:0.09,
     tplhl$X2$PPN = 0.1:0.1:0.1,
     tphlh$X2$PPN = 0.095:0.095:0.095,
     tphhl$X2$PPN = 0.096:0.096:0.096;

      // path delays
      (posedge X2 *> (PPN +: M0?A:S)) = (tpllh$X2$PPN, tplhl$X2$PPN);
      (negedge X2 *> (PPN +: M1?A:S)) = (tphlh$X2$PPN, tphhl$X2$PPN);
      (S *> PPN) = (tpllh$S$PPN, tphhl$S$PPN);
      (posedge M1 *> (PPN +: X2?(M0?A:S):A)) = (tpllh$M1$PPN, tplhl$M1$PPN);
      (negedge M1 *> (PPN +: X2?(M0?A:S):S)) = (tphlh$M1$PPN, tphhl$M1$PPN);
      (posedge M0 *> (PPN +: X2?A:(M1?A:S))) = (tpllh$M0$PPN, tplhl$M0$PPN);
      (negedge M0 *> (PPN +: X2?S:(M1?A:S))) = (tphlh$M0$PPN, tphhl$M0$PPN);
      (A *> PPN) = (tpllh$A$PPN, tphhl$A$PPN);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module BUFX8 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.034:0.034:0.034,
     tphhl$A$Y = 0.036:0.036:0.036;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKAND2X12 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.038:0.038:0.038,
     tphhl$A$Y = 0.041:0.041:0.041,
     tpllh$B$Y = 0.036:0.036:0.036,
     tphhl$B$Y = 0.038:0.038:0.038;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKAND2X3 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.046:0.046:0.046,
     tphhl$A$Y = 0.048:0.048:0.048,
     tpllh$B$Y = 0.044:0.044:0.044,
     tphhl$B$Y = 0.046:0.046:0.046;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKBUFX3 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.041:0.041:0.041,
     tphhl$A$Y = 0.042:0.042:0.042;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKINVX8 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.012:0.012:0.012,
     tphlh$A$Y = 0.011:0.011:0.011;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKMX2X6 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.092:0.092:0.092,
     tphhl$A$Y = 0.098:0.098:0.098,
     tpllh$B$Y = 0.092:0.092:0.092,
     tphhl$B$Y = 0.099:0.099:0.099,
     tpllh$S0$Y = 0.086:0.086:0.086,
     tplhl$S0$Y = 0.11:0.11:0.11,
     tphlh$S0$Y = 0.1:0.1:0.1,
     tphhl$S0$Y = 0.092:0.092:0.092;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKXOR2X2 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.091:0.091:0.091,
     tplhl$A$Y = 0.11:0.11:0.11,
     tphlh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.095:0.095:0.095,
     tpllh$B$Y = 0.08:0.08:0.08,
     tplhl$B$Y = 0.099:0.099:0.099,
     tphlh$B$Y = 0.08:0.08:0.08,
     tphhl$B$Y = 0.08:0.08:0.08;

      // path delays
      (posedge B *> (Y +: !A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: !B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFNSRX1 (CKN, D, Q, QN, RN, SN);
   input  CKN ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I13_out, RN, SN);
   not (I16_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I16_out, SN);
   not (I18_out, D);
   not (I19_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I18_out, I19_out);

    specify
      // delay parameters
      specparam
	tphlh$CKN$Q = 0.17:0.17:0.17,
     tphhl$CKN$Q = 0.15:0.15:0.15,
     tphlh$CKN$QN = 0.17:0.17:0.17,
     tphhl$CKN$QN = 0.19:0.19:0.19,
     tphhl$RN$Q = 0.19:0.2:0.2,
     tphlh$RN$QN = 0.21:0.21:0.21,
     tplhl$SN$Q = 0.18:0.18:0.19,
     tphlh$SN$Q = 0.14:0.14:0.15,
     tpllh$SN$QN = 0.19:0.19:0.2,
     tphhl$SN$QN = 0.16:0.16:0.16,
     tminpwh$CKN = 0.048:0.12:0.12,
     tminpwl$CKN = 0.052:0.17:0.17,
     tminpwl$RN = 0.058:0.21:0.21,
     tminpwl$SN = 0.02:0.16:0.16,
     tsetup_negedge$D$CKN = 0.069:0.069:0.069,
     thold_negedge$D$CKN = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CKN = 0.05:0.05:0.05,
     thold_posedge$D$CKN = 0.025:0.025:0.025,
     trec$RN$CKN = 0.038:0.038:0.038,
     trem$RN$CKN = 0.0063:0.0063:0.0063,
     trec$RN$SN = 0.075:0.081:0.081,
     trec$SN$CKN = 0.038:0.038:0.038,
     trem$SN$CKN = 0.013:0.013:0.013;

      // path delays
      (negedge CKN *> (QN -: D)) = (tphlh$CKN$QN, tphhl$CKN$QN);
      (negedge CKN *> (Q +: D)) = (tphlh$CKN$Q, tphhl$CKN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
      $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
      $recovery(posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CKN, NOTIFIER);
      $removal (posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CKN, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CKN, NOTIFIER);
      $removal (posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CKN, NOTIFIER);
      $width(posedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CKN, 0, NOTIFIER);
      $width(negedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CKN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFNSRXL (CKN, D, Q, QN, RN, SN);
   input  CKN ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I13_out, RN, SN);
   not (I16_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I16_out, SN);
   not (I18_out, D);
   not (I19_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I18_out, I19_out);

    specify
      // delay parameters
      specparam
	tphlh$CKN$Q = 0.2:0.2:0.2,
     tphhl$CKN$Q = 0.18:0.18:0.18,
     tphlh$CKN$QN = 0.19:0.19:0.19,
     tphhl$CKN$QN = 0.2:0.2:0.2,
     tphhl$RN$Q = 0.22:0.22:0.23,
     tphlh$RN$QN = 0.23:0.23:0.24,
     tplhl$SN$Q = 0.2:0.2:0.21,
     tphlh$SN$Q = 0.17:0.17:0.17,
     tpllh$SN$QN = 0.21:0.21:0.22,
     tphhl$SN$QN = 0.18:0.18:0.18,
     tminpwh$CKN = 0.048:0.12:0.12,
     tminpwl$CKN = 0.05:0.19:0.19,
     tminpwl$RN = 0.058:0.24:0.24,
     tminpwl$SN = 0.02:0.18:0.18,
     tsetup_negedge$D$CKN = 0.069:0.069:0.069,
     thold_negedge$D$CKN = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CKN = 0.05:0.05:0.05,
     thold_posedge$D$CKN = 0.019:0.019:0.019,
     trec$RN$CKN = 0.037:0.037:0.037,
     trem$RN$CKN = 0.0063:0.0063:0.0063,
     trec$RN$SN = 0.069:0.075:0.075,
     trec$SN$CKN = 0.037:0.037:0.037,
     trem$SN$CKN = 0.012:0.012:0.012;

      // path delays
      (negedge CKN *> (QN -: D)) = (tphlh$CKN$QN, tphhl$CKN$QN);
      (negedge CKN *> (Q +: D)) = (tphlh$CKN$Q, tphhl$CKN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
      $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
      $recovery(posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CKN, NOTIFIER);
      $removal (posedge RN, negedge CKN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CKN, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CKN, NOTIFIER);
      $removal (posedge SN, negedge CKN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CKN, NOTIFIER);
      $width(posedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CKN, 0, NOTIFIER);
      $width(negedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CKN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFRHQX1 (CK, D, Q, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (N30, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I5_out, RN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.16:0.16:0.16,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tphhl$RN$Q = 0.074:0.074:0.075,
     tminpwh$CK = 0.055:0.16:0.16,
     tminpwl$CK = 0.058:0.11:0.11,
     tminpwl$RN = 0.018:0.083:0.083,
     tsetup_negedge$D$CK = 0.0063:0.0063:0.0063,
     thold_negedge$D$CK = 0.031:0.031:0.031,
     tsetup_posedge$D$CK = 0.037:0.037:0.037,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = -0.044:-0.044:-0.044,
     trem$RN$CK = 0.062:0.062:0.062;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D == 1'b0, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFRHQX4 (CK, D, Q, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (N30, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I5_out, RN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tphhl$RN$Q = 0.041:0.041:0.042,
     tminpwh$CK = 0.059:0.13:0.13,
     tminpwl$CK = 0.054:0.11:0.11,
     tminpwl$RN = 0.017:0.086:0.086,
     tsetup_negedge$D$CK = 0.0063:0.0063:0.0063,
     thold_negedge$D$CK = 0.031:0.031:0.031,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.012:-0.012:-0.012,
     trec$RN$CK = -0.031:-0.031:-0.031,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D == 1'b0, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFRX2 (CK, D, Q, QN, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (N30, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I7_out, RN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.063:0.064:0.064,
     tphlh$RN$QN = 0.085:0.085:0.085,
     tminpwh$CK = 0.05:0.16:0.16,
     tminpwl$CK = 0.049:0.1:0.1,
     tminpwl$RN = 0.024:0.086:0.086,
     tsetup_negedge$D$CK = 0.019:0.019:0.019,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = -0.031:-0.031:-0.031,
     trem$RN$CK = 0.05:0.05:0.05;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D == 1'b0, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSRHQX4 (CK, D, Q, RN, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   not (I6_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I6_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I10_out, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I13_out, SN);
   not (I15_out, D);
   not (I16_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I15_out, I16_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tphhl$RN$Q = 0.16:0.17:0.17,
     tplhl$SN$Q = 0.14:0.15:0.15,
     tphlh$SN$Q = 0.11:0.11:0.11,
     tminpwh$CK = 0.07:0.15:0.15,
     tminpwl$CK = 0.059:0.13:0.13,
     tminpwl$RN = 0.062:0.17:0.17,
     tminpwl$SN = 0.019:0.11:0.11,
     tsetup_negedge$D$CK = 0.037:0.037:0.037,
     thold_negedge$D$CK = 0.031:0.031:0.031,
     tsetup_posedge$D$CK = 0.069:0.069:0.069,
     thold_posedge$D$CK = -0.012:-0.012:-0.012,
     trec$RN$CK = 0.062:0.062:0.062,
     trem$RN$CK = -0.012:-0.012:-0.012,
     trec$RN$SN = 0.075:0.081:0.081,
     trec$SN$CK = 0.0062:0.0062:0.0062,
     trem$SN$CK = 0.038:0.038:0.038;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSRX2 (CK, D, Q, QN, RN, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I12_out, RN, SN);
   not (I15_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I15_out, SN);
   not (I17_out, D);
   not (I18_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I17_out, I18_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tpllh$CK$QN = 0.18:0.18:0.18,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.19:0.2:0.2,
     tphlh$RN$QN = 0.22:0.22:0.22,
     tplhl$SN$Q = 0.17:0.17:0.17,
     tphlh$SN$Q = 0.13:0.13:0.13,
     tpllh$SN$QN = 0.19:0.19:0.19,
     tphhl$SN$QN = 0.15:0.15:0.16,
     tminpwh$CK = 0.063:0.18:0.18,
     tminpwl$CK = 0.058:0.13:0.13,
     tminpwl$RN = 0.067:0.22:0.22,
     tminpwl$SN = 0.021:0.16:0.16,
     tsetup_negedge$D$CK = 0.05:0.05:0.05,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = 0.069:0.069:0.069,
     trem$RN$CK = -0.019:-0.019:-0.019,
     trec$RN$SN = 0.075:0.087:0.087,
     trec$SN$CK = 0.012:0.012:0.012,
     trem$SN$CK = 0.031:0.031:0.031;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSX4 (CK, D, Q, QN, SN);
   input  CK ;
   input  D ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (N35, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I7_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tpllh$CK$QN = 0.17:0.17:0.17,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tphlh$SN$Q = 0.11:0.11:0.11,
     tphhl$SN$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.058:0.17:0.17,
     tminpwl$CK = 0.049:0.11:0.11,
     tminpwl$SN = 0.018:0.14:0.14,
     tsetup_negedge$D$CK = 0.05:0.05:0.05,
     thold_negedge$D$CK = 0.019:0.019:0.019,
     tsetup_posedge$D$CK = 0.05:0.05:0.05,
     thold_posedge$D$CK = -0.012:-0.012:-0.012,
     trec$SN$CK = 0.019:0.019:0.019,
     trem$SN$CK = 0.025:0.025:0.025;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (0, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSXL (CK, D, Q, QN, SN);
   input  CK ;
   input  D ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (N35, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I7_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.17:0.17:0.17,
     tplhl$CK$Q = 0.19:0.19:0.19,
     tpllh$CK$QN = 0.2:0.2:0.2,
     tplhl$CK$QN = 0.18:0.18:0.18,
     tphlh$SN$Q = 0.17:0.17:0.17,
     tphhl$SN$QN = 0.18:0.18:0.18,
     tminpwh$CK = 0.053:0.2:0.2,
     tminpwl$CK = 0.054:0.12:0.12,
     tminpwl$SN = 0.02:0.18:0.18,
     tsetup_negedge$D$CK = 0.056:0.056:0.056,
     thold_negedge$D$CK = 0.019:0.019:0.019,
     tsetup_posedge$D$CK = 0.05:0.05:0.05,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$SN$CK = 0.013:0.013:0.013,
     trem$SN$CK = 0.031:0.031:0.031;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (0, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFTRX1 (CK, D, Q, QN, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_D, D, RN);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   not (I8_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I7_out, I8_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tpllh$CK$QN = 0.17:0.17:0.17,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.045:0.17:0.17,
     tminpwl$CK = 0.048:0.083:0.083,
     tsetup_negedge$D$CK = 0.025:0.025:0.025,
     thold_negedge$D$CK = 0.0063:0.0063:0.0063,
     tsetup_negedge$RN$CK = 0.025:0.025:0.025,
     thold_negedge$RN$CK = 0.0063:0.0063:0.0063,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$RN$CK = 0.075:0.075:0.075,
     thold_posedge$RN$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (QN -: RN&D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: RN&D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFTRX4 (CK, D, Q, QN, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_D, D, RN);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   not (I8_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I7_out, I8_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.15:0.15:0.15,
     tplhl$CK$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.055:0.15:0.15,
     tminpwl$CK = 0.047:0.083:0.083,
     tsetup_negedge$D$CK = 0.031:0.031:0.031,
     thold_negedge$D$CK = 0.0062:0.0062:0.0062,
     tsetup_negedge$RN$CK = 0.031:0.031:0.031,
     thold_negedge$RN$CK = 0.0062:0.0062:0.0062,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$RN$CK = 0.081:0.081:0.081,
     thold_posedge$RN$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (QN -: RN&D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: RN&D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFX4 (CK, D, Q, QN);
   input  CK ;
   input  D ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.15:0.15:0.15,
     tplhl$CK$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.057:0.15:0.15,
     tminpwl$CK = 0.051:0.1:0.1,
     tsetup_negedge$D$CK = 0.019:0.019:0.019,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.019:-0.019:-0.019;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DLY1X1 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.11:0.11:0.11;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DLY4X1 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.33:0.33:0.33,
     tphhl$A$Y = 0.33:0.33:0.33;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFHQX1 (CK, D, E, Q);
   input  CK ;
   input  D ;
   input  E ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D);
   and (D_EQ_0_AN_E_EQ_1, I6_out, E);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tminpwh$CK = 0.047:0.15:0.15,
     tminpwl$CK = 0.047:0.089:0.089,
     tsetup_negedge$D$CK = 0.056:0.056:0.056,
     thold_negedge$D$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$E$CK = 0.025:0.025:0.025,
     thold_negedge$E$CK = 0.019:0.019:0.019,


     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$E$CK = 0.069:0.069:0.069,
      thold_posedge$E$CK = -0.05:-0.05:-0.05;
       


      // path delays
      (posedge CK *> (Q +: E?D:!QBINT)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFX2 (CK, D, E, Q, QN);
   input  CK ;
   input  D ;
   input  E ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   and (D_EQ_0_AN_E_EQ_1, I8_out, E);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.15:0.15:0.15,
     tplhl$CK$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.047:0.15:0.15,
     tminpwl$CK = 0.046:0.089:0.089,
     tsetup_negedge$D$CK = 0.075:0.075:0.075,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$E$CK = 0.025:0.025:0.025,
     thold_negedge$E$CK = 0.0063:0.0063:0.0063,


     tsetup_posedge$D$CK = 0.094:0.094:0.094,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$E$CK = 0.088:0.088:0.088,
      thold_posedge$E$CK = -0.062:-0.062:-0.062;
       


      // path delays
      (posedge CK *> (QN -: E?D:!QBINT)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: E?D:!QBINT)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFXL (CK, D, E, Q, QN);
   input  CK ;
   input  D ;
   input  E ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   and (D_EQ_0_AN_E_EQ_1, I8_out, E);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.17:0.17:0.17,
     tplhl$CK$Q = 0.18:0.18:0.18,
     tpllh$CK$QN = 0.19:0.19:0.19,
     tplhl$CK$QN = 0.18:0.18:0.18,
     tminpwh$CK = 0.047:0.19:0.19,
     tminpwl$CK = 0.048:0.093:0.093,
     tsetup_negedge$D$CK = 0.075:0.075:0.075,
     thold_negedge$D$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$E$CK = 0.038:0.038:0.038,
     thold_negedge$E$CK = 0.0062:0.0062:0.0062,


     tsetup_posedge$D$CK = 0.094:0.094:0.094,
     thold_posedge$D$CK = -0.062:-0.062:-0.062,
     tsetup_posedge$E$CK = 0.087:0.087:0.087,
      thold_posedge$E$CK = -0.062:-0.062:-0.062;
       


      // path delays
      (posedge CK *> (QN -: E?D:!QBINT)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: E?D:!QBINT)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module INVX20 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.0085:0.0085:0.0085,
     tphlh$A$Y = 0.0082:0.0082:0.0082;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module INVX4 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.017:0.017:0.017,
     tphlh$A$Y = 0.016:0.016:0.016;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MDFFHQX1 (CK, D0, D1, Q, S0);
   input  CK ;
   input  D0 ;
   input  D1 ;
   input  S0 ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D0, D1, S0);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D0);
   and (D0_EQ_0_AN_D1_EQ_1, I5_out, D1);
   not (I7_out, D1);
   and (D0_EQ_1_AN_D1_EQ_0, D0, I7_out);
   not (I9_out, D0);
   not (I10_out, D1);
   not (I12_out, S0);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tminpwh$CK = 0.049:0.15:0.15,
     tminpwl$CK = 0.051:0.094:0.094,
     tsetup_negedge$D0$CK = 0.044:0.044:0.044,
     thold_negedge$D0$CK = -0.0062:-0.0062:-0.0062,
     tsetup_negedge$D1$CK = 0.044:0.044:0.044,
     thold_negedge$D1$CK = -0.0063:-0.0063:-0.0063,
     tsetup_negedge$S0$CK = 0.081:0.081:0.081,
     thold_negedge$S0$CK = -0.056:-0.056:-0.056,


     tsetup_posedge$D0$CK = 0.069:0.069:0.069,
     thold_posedge$D0$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$D1$CK = 0.069:0.069:0.069,
     thold_posedge$D1$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$S0$CK = 0.056:0.056:0.056,
      thold_posedge$S0$CK = -0.019:-0.019:-0.019;
       


      // path delays
      (posedge CK *> (Q +: S0?D1:D0)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D0, posedge CK &&& S0 == 1'b0, tsetup_negedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b0, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
      $setup(negedge D1, posedge CK &&& S0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(posedge D0, posedge CK &&& S0 == 1'b0, tsetup_posedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b0, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
      $setup(posedge D1, posedge CK &&& S0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $width(posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MDFFHQX2 (CK, D0, D1, Q, S0);
   input  CK ;
   input  D0 ;
   input  D1 ;
   input  S0 ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D0, D1, S0);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D0);
   and (D0_EQ_0_AN_D1_EQ_1, I5_out, D1);
   not (I7_out, D1);
   and (D0_EQ_1_AN_D1_EQ_0, D0, I7_out);
   not (I9_out, D0);
   not (I10_out, D1);
   not (I12_out, S0);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.049:0.13:0.13,
     tminpwl$CK = 0.051:0.094:0.094,
     tsetup_negedge$D0$CK = 0.044:0.044:0.044,
     thold_negedge$D0$CK = -0.0062:-0.0062:-0.0062,
     tsetup_negedge$D1$CK = 0.044:0.044:0.044,
     thold_negedge$D1$CK = -0.0063:-0.0063:-0.0063,
     tsetup_negedge$S0$CK = 0.087:0.087:0.087,
     thold_negedge$S0$CK = -0.056:-0.056:-0.056,


     tsetup_posedge$D0$CK = 0.075:0.075:0.075,
     thold_posedge$D0$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$D1$CK = 0.069:0.069:0.069,
     thold_posedge$D1$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$S0$CK = 0.056:0.056:0.056,
      thold_posedge$S0$CK = -0.019:-0.019:-0.019;
       


      // path delays
      (posedge CK *> (Q +: S0?D1:D0)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D0, posedge CK &&& S0 == 1'b0, tsetup_negedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b0, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
      $setup(negedge D1, posedge CK &&& S0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(posedge D0, posedge CK &&& S0 == 1'b0, tsetup_posedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b0, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
      $setup(posedge D1, posedge CK &&& S0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $width(posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MDFFHQX4 (CK, D0, D1, Q, S0);
   input  CK ;
   input  D0 ;
   input  D1 ;
   input  S0 ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D0, D1, S0);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D0);
   and (D0_EQ_0_AN_D1_EQ_1, I5_out, D1);
   not (I7_out, D1);
   and (D0_EQ_1_AN_D1_EQ_0, D0, I7_out);
   not (I9_out, D0);
   not (I10_out, D1);
   not (I12_out, S0);
   and (D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.1:0.1:0.1,
     tplhl$CK$Q = 0.12:0.12:0.12,
     tminpwh$CK = 0.054:0.12:0.12,
     tminpwl$CK = 0.052:0.095:0.095,
     tsetup_negedge$D0$CK = 0.044:0.044:0.044,
     thold_negedge$D0$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_negedge$D1$CK = 0.044:0.044:0.044,
     thold_negedge$D1$CK = -0.000000000085:-0.000000000085:-0.000000000085,
     tsetup_negedge$S0$CK = 0.081:0.081:0.081,
     thold_negedge$S0$CK = -0.05:-0.05:-0.05,


     tsetup_posedge$D0$CK = 0.069:0.069:0.069,
     thold_posedge$D0$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$D1$CK = 0.069:0.069:0.069,
     thold_posedge$D1$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$S0$CK = 0.056:0.056:0.056,
      thold_posedge$S0$CK = -0.012:-0.012:-0.012;
       


      // path delays
      (posedge CK *> (Q +: S0?D1:D0)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D0, posedge CK &&& S0 == 1'b0, tsetup_negedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b0, negedge D0, thold_negedge$D0$CK,  NOTIFIER);
      $setup(negedge D1, posedge CK &&& S0 == 1'b1, tsetup_negedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b1, negedge D1, thold_negedge$D1$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(negedge S0, posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, tsetup_negedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, negedge S0, thold_negedge$S0$CK,  NOTIFIER);
      $setup(posedge D0, posedge CK &&& S0 == 1'b0, tsetup_posedge$D0$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b0, posedge D0, thold_posedge$D0$CK,  NOTIFIER);
      $setup(posedge D1, posedge CK &&& S0 == 1'b1, tsetup_posedge$D1$CK, NOTIFIER);
      $hold (posedge CK &&& S0 == 1'b1, posedge D1, thold_posedge$D1$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_0_AN_D1_EQ_1 == 1'b1, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $setup(posedge S0, posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, tsetup_posedge$S0$CK, NOTIFIER);
      $hold (posedge CK &&& D0_EQ_1_AN_D1_EQ_0 == 1'b1, posedge S0, thold_posedge$S0$CK,  NOTIFIER);
      $width(posedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D0_EQ_0_AN_D1_EQ_0_AN_S0_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX4X1 (A, B, C, D, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (Y, I1_out, I0_out, S1);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.15:0.15:0.15,
     tphhl$A$Y = 0.16:0.16:0.16,
     tpllh$B$Y = 0.15:0.15:0.15,
     tphhl$B$Y = 0.16:0.16:0.16,
     tpllh$C$Y = 0.15:0.15:0.15,
     tphhl$C$Y = 0.15:0.15:0.15,
     tpllh$D$Y = 0.15:0.15:0.15,
     tphhl$D$Y = 0.15:0.15:0.15,
     tpllh$S0$Y = 0.14:0.14:0.14,
     tplhl$S0$Y = 0.17:0.17:0.18,
     tphlh$S0$Y = 0.17:0.17:0.17,
     tphhl$S0$Y = 0.15:0.15:0.15,
     tpllh$S1$Y = 0.1:0.1:0.1,
     tplhl$S1$Y = 0.12:0.12:0.12,
     tphlh$S1$Y = 0.11:0.11:0.11,
     tphhl$S1$Y = 0.11:0.11:0.11;

      // path delays
      (posedge S1 *> (Y +: S0?D:C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: S0?B:A)) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: S1?D:B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: S1?C:A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX4X2 (A, B, C, D, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (Y, I1_out, I0_out, S1);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.14:0.14:0.14,
     tphhl$A$Y = 0.15:0.15:0.15,
     tpllh$B$Y = 0.14:0.14:0.14,
     tphhl$B$Y = 0.14:0.14:0.14,
     tpllh$C$Y = 0.15:0.15:0.15,
     tphhl$C$Y = 0.15:0.15:0.15,
     tpllh$D$Y = 0.14:0.14:0.14,
     tphhl$D$Y = 0.15:0.15:0.15,
     tpllh$S0$Y = 0.13:0.13:0.14,
     tplhl$S0$Y = 0.16:0.17:0.17,
     tphlh$S0$Y = 0.16:0.16:0.17,
     tphhl$S0$Y = 0.14:0.14:0.14,
     tpllh$S1$Y = 0.089:0.089:0.089,
     tplhl$S1$Y = 0.1:0.1:0.1,
     tphlh$S1$Y = 0.097:0.097:0.097,
     tphhl$S1$Y = 0.097:0.097:0.097;

      // path delays
      (posedge S1 *> (Y +: S0?D:C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: S0?B:A)) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: S1?D:B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: S1?C:A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX4XL (A, B, C, D, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (Y, I1_out, I0_out, S1);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.17:0.17:0.17,
     tphhl$A$Y = 0.18:0.18:0.18,
     tpllh$B$Y = 0.17:0.17:0.17,
     tphhl$B$Y = 0.18:0.18:0.18,
     tpllh$C$Y = 0.17:0.17:0.17,
     tphhl$C$Y = 0.18:0.18:0.18,
     tpllh$D$Y = 0.17:0.17:0.17,
     tphhl$D$Y = 0.18:0.18:0.18,
     tpllh$S0$Y = 0.16:0.17:0.17,
     tplhl$S0$Y = 0.19:0.2:0.2,
     tphlh$S0$Y = 0.19:0.19:0.2,
     tphhl$S0$Y = 0.17:0.17:0.17,
     tpllh$S1$Y = 0.13:0.13:0.13,
     tplhl$S1$Y = 0.14:0.14:0.14,
     tphlh$S1$Y = 0.14:0.14:0.14,
     tphhl$S1$Y = 0.13:0.13:0.13;

      // path delays
      (posedge S1 *> (Y +: S0?D:C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: S0?B:A)) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: S1?D:B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: S1?C:A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI2X2 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.095:0.095:0.095,
     tphlh$A$Y = 0.095:0.095:0.095,
     tplhl$B$Y = 0.095:0.095:0.095,
     tphlh$B$Y = 0.096:0.096:0.096,
     tpllh$S0$Y = 0.1:0.1:0.1,
     tplhl$S0$Y = 0.089:0.089:0.089,
     tphlh$S0$Y = 0.088:0.088:0.088,
     tphhl$S0$Y = 0.1:0.1:0.1;

      // path delays
      (posedge S0 *> (Y +: !B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI3X2 (A, B, C, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (I1_out, I0_out, C, S1);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.13:0.13:0.13,
     tphlh$A$Y = 0.13:0.13:0.13,
     tplhl$B$Y = 0.13:0.13:0.13,
     tphlh$B$Y = 0.13:0.13:0.13,
     tplhl$C$Y = 0.1:0.1:0.1,
     tphlh$C$Y = 0.099:0.099:0.099,
     tpllh$S0$Y = 0.14:0.14:0.14,
     tplhl$S0$Y = 0.12:0.12:0.12,
     tphlh$S0$Y = 0.12:0.12:0.12,
     tphhl$S0$Y = 0.14:0.14:0.14,
     tpllh$S1$Y = 0.078:0.078:0.078,
     tplhl$S1$Y = 0.099:0.099:0.099,
     tphlh$S1$Y = 0.095:0.095:0.095,
     tphhl$S1$Y = 0.082:0.082:0.082;

      // path delays
      (posedge S1 *> (Y +: !C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: !(S0?B:A))) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: !(S1?C:B))) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !(S1?C:A))) = (tphlh$S0$Y, tphhl$S0$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI3XL (A, B, C, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (I1_out, I0_out, C, S1);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.16:0.16:0.16,
     tphlh$A$Y = 0.16:0.16:0.16,
     tplhl$B$Y = 0.16:0.16:0.16,
     tphlh$B$Y = 0.16:0.16:0.16,
     tplhl$C$Y = 0.14:0.14:0.14,
     tphlh$C$Y = 0.14:0.14:0.14,
     tpllh$S0$Y = 0.17:0.17:0.17,
     tplhl$S0$Y = 0.15:0.15:0.15,
     tphlh$S0$Y = 0.15:0.15:0.15,
     tphhl$S0$Y = 0.17:0.17:0.17,
     tpllh$S1$Y = 0.12:0.12:0.12,
     tplhl$S1$Y = 0.14:0.14:0.14,
     tphlh$S1$Y = 0.13:0.13:0.13,
     tphhl$S1$Y = 0.12:0.12:0.12;

      // path delays
      (posedge S1 *> (Y +: !C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: !(S0?B:A))) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: !(S1?C:B))) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !(S1?C:A))) = (tphlh$S0$Y, tphhl$S0$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI4X4 (A, B, C, D, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (I2_out, I1_out, I0_out, S1);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.14:0.14:0.14,
     tphlh$A$Y = 0.14:0.14:0.14,
     tplhl$B$Y = 0.14:0.14:0.14,
     tphlh$B$Y = 0.14:0.14:0.14,
     tplhl$C$Y = 0.14:0.14:0.14,
     tphlh$C$Y = 0.13:0.13:0.13,
     tplhl$D$Y = 0.14:0.14:0.14,
     tphlh$D$Y = 0.14:0.14:0.14,
     tpllh$S0$Y = 0.15:0.15:0.16,
     tplhl$S0$Y = 0.13:0.13:0.13,
     tphlh$S0$Y = 0.13:0.13:0.13,
     tphhl$S0$Y = 0.16:0.16:0.16,
     tpllh$S1$Y = 0.08:0.08:0.08,
     tplhl$S1$Y = 0.11:0.11:0.11,
     tphlh$S1$Y = 0.11:0.11:0.11,
     tphhl$S1$Y = 0.083:0.083:0.083;

      // path delays
      (posedge S1 *> (Y +: !(S0?D:C))) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: !(S0?B:A))) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: !(S1?D:B))) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !(S1?C:A))) = (tphlh$S0$Y, tphhl$S0$Y);
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND2BX4 (AN, B, Y);
   input  AN ;
   input  B ;
   output Y ;

   not (I0_out, AN);
   and (I1_out, I0_out, B);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.047:0.047:0.047,
     tphhl$AN$Y = 0.061:0.061:0.061,
     tplhl$B$Y = 0.031:0.031:0.031,
     tphlh$B$Y = 0.018:0.018:0.018;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND2X4 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.033:0.033:0.033,
     tphlh$A$Y = 0.019:0.019:0.019,
     tplhl$B$Y = 0.031:0.031:0.031,
     tphlh$B$Y = 0.018:0.018:0.018;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND2XL (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.14:0.14:0.14,
     tphlh$A$Y = 0.081:0.081:0.081,
     tplhl$B$Y = 0.14:0.14:0.14,
     tphlh$B$Y = 0.079:0.079:0.079;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND3X2 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.081:0.081:0.081,
     tphlh$A$Y = 0.032:0.032:0.032,
     tplhl$B$Y = 0.079:0.079:0.079,
     tphlh$B$Y = 0.031:0.031:0.031,
     tplhl$C$Y = 0.075:0.075:0.075,
     tphlh$C$Y = 0.029:0.029:0.029;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4BBX4 (AN, BN, C, D, Y);
   input  AN ;
   input  BN ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   and (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.05:0.05:0.05,
     tphhl$AN$Y = 0.11:0.11:0.11,
     tpllh$BN$Y = 0.051:0.051:0.051,
     tphhl$BN$Y = 0.11:0.11:0.11,
     tplhl$C$Y = 0.077:0.077:0.077,
     tphlh$C$Y = 0.022:0.022:0.022,
     tplhl$D$Y = 0.067:0.067:0.067,
     tphlh$D$Y = 0.02:0.02:0.02;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4BX4 (AN, B, C, D, Y);
   input  AN ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   and (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.051:0.051:0.051,
     tphhl$AN$Y = 0.11:0.11:0.11,
     tplhl$B$Y = 0.087:0.087:0.087,
     tphlh$B$Y = 0.025:0.025:0.025,
     tplhl$C$Y = 0.08:0.08:0.08,
     tphlh$C$Y = 0.023:0.023:0.023,
     tplhl$D$Y = 0.069:0.069:0.069,
     tphlh$D$Y = 0.021:0.021:0.021;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4X4 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.091:0.091:0.091,
     tphlh$A$Y = 0.025:0.025:0.025,
     tplhl$B$Y = 0.087:0.087:0.087,
     tphlh$B$Y = 0.025:0.025:0.025,
     tplhl$C$Y = 0.08:0.08:0.08,
     tphlh$C$Y = 0.023:0.023:0.023,
     tplhl$D$Y = 0.069:0.069:0.069,
     tphlh$D$Y = 0.021:0.021:0.021;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4X8 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.068:0.068:0.068,
     tphlh$A$Y = 0.019:0.019:0.019,
     tplhl$B$Y = 0.065:0.065:0.065,
     tphlh$B$Y = 0.018:0.018:0.018,
     tplhl$C$Y = 0.058:0.058:0.058,
     tphlh$C$Y = 0.017:0.017:0.017,
     tplhl$D$Y = 0.049:0.049:0.049,
     tphlh$D$Y = 0.015:0.015:0.015;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR3X6 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.02:0.02:0.02,
     tphlh$A$Y = 0.046:0.046:0.046,
     tplhl$B$Y = 0.018:0.018:0.018,
     tphlh$B$Y = 0.043:0.043:0.043,
     tplhl$C$Y = 0.016:0.016:0.016,
     tphlh$C$Y = 0.035:0.035:0.035;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4BBX1 (AN, BN, C, D, Y);
   input  AN ;
   input  BN ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   not (I1_out, BN);
   or  (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.21:0.21:0.21,
     tphhl$AN$Y = 0.074:0.074:0.074,
     tpllh$BN$Y = 0.21:0.21:0.21,
     tphhl$BN$Y = 0.073:0.073:0.073,
     tplhl$C$Y = 0.053:0.053:0.053,
     tphlh$C$Y = 0.19:0.19:0.19,
     tplhl$D$Y = 0.051:0.051:0.051,
     tphlh$D$Y = 0.18:0.18:0.18;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4BX2 (AN, B, C, D, Y);
   input  AN ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   or  (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.15:0.15:0.15,
     tphhl$AN$Y = 0.06:0.06:0.06,
     tplhl$B$Y = 0.035:0.035:0.035,
     tphlh$B$Y = 0.12:0.12:0.12,
     tplhl$C$Y = 0.033:0.033:0.033,
     tphlh$C$Y = 0.12:0.12:0.12,
     tplhl$D$Y = 0.03:0.03:0.03,
     tphlh$D$Y = 0.1:0.1:0.1;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4BX4 (AN, B, C, D, Y);
   input  AN ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   or  (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.11:0.11:0.11,
     tphhl$AN$Y = 0.05:0.05:0.05,
     tplhl$B$Y = 0.024:0.024:0.024,
     tphlh$B$Y = 0.084:0.084:0.084,
     tplhl$C$Y = 0.023:0.023:0.023,
     tphlh$C$Y = 0.075:0.075:0.075,
     tplhl$D$Y = 0.02:0.02:0.02,
     tphlh$D$Y = 0.061:0.061:0.061;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OA22X4 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (Y, I0_out, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.068:0.076:0.084,
     tphhl$A0$Y = 0.081:0.083:0.085,
     tpllh$A1$Y = 0.063:0.071:0.079,
     tphhl$A1$Y = 0.078:0.08:0.082,
     tpllh$B0$Y = 0.06:0.068:0.077,
     tphhl$B0$Y = 0.073:0.075:0.077,
     tpllh$B1$Y = 0.055:0.064:0.072,
     tphhl$B1$Y = 0.07:0.072:0.074;

      // path delays
      (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI21X1 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (I1_out, I0_out, B0);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.1:0.1:0.1,
     tphlh$A0$Y = 0.098:0.098:0.098,
     tplhl$A1$Y = 0.093:0.093:0.093,
     tphlh$A1$Y = 0.095:0.095:0.095,
     tplhl$B0$Y = 0.067:0.081:0.095,
     tphlh$B0$Y = 0.049:0.049:0.049;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI221X4 (A0, A1, B0, B1, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.059:0.068:0.076,
     tphlh$A0$Y = 0.046:0.047:0.047,
     tplhl$A1$Y = 0.054:0.062:0.07,
     tphlh$A1$Y = 0.043:0.044:0.044,
     tplhl$B0$Y = 0.053:0.062:0.07,
     tphlh$B0$Y = 0.042:0.042:0.042,
     tplhl$B1$Y = 0.048:0.056:0.064,
     tphlh$B1$Y = 0.038:0.038:0.038,
     tplhl$C0$Y = 0.033:0.047:0.061,
     tphlh$C0$Y = 0.019:0.019:0.019;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI222X1 (A0, A1, B0, B1, C0, C1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   input  C1 ;
   output Y ;

   or  (I0_out, C0, C1);
   or  (I1_out, A0, A1);
   or  (I3_out, B0, B1);
   and (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.12:0.15:0.18,
     tphlh$A0$Y = 0.11:0.11:0.11,
     tplhl$A1$Y = 0.11:0.14:0.17,
     tphlh$A1$Y = 0.11:0.11:0.11,
     tplhl$B0$Y = 0.11:0.14:0.17,
     tphlh$B0$Y = 0.11:0.11:0.11,
     tplhl$B1$Y = 0.11:0.14:0.17,
     tphlh$B1$Y = 0.1:0.1:0.1,
     tplhl$C0$Y = 0.096:0.13:0.16,
     tphlh$C0$Y = 0.098:0.098:0.098,
     tplhl$C1$Y = 0.093:0.12:0.15,
     tphlh$C1$Y = 0.095:0.095:0.095;

      // path delays
      (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI22X4 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   or  (I1_out, A0, A1);
   and (I2_out, I0_out, I1_out);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.036:0.042:0.048,
     tphlh$A0$Y = 0.042:0.043:0.044,
     tplhl$A1$Y = 0.033:0.039:0.044,
     tphlh$A1$Y = 0.039:0.04:0.041,
     tplhl$B0$Y = 0.029:0.035:0.041,
     tphlh$B0$Y = 0.036:0.036:0.036,
     tplhl$B1$Y = 0.026:0.032:0.038,
     tphlh$B1$Y = 0.032:0.032:0.033;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI2BB1X1 (A0N, A1N, B0, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.088:0.088:0.088,
     tphhl$A0N$Y = 0.11:0.11:0.11,
     tpllh$A1N$Y = 0.085:0.085:0.085,
     tphhl$A1N$Y = 0.11:0.11:0.11,
     tplhl$B0$Y = 0.091:0.091:0.091,
     tphlh$B0$Y = 0.05:0.05:0.05;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI2BB1X4 (A0N, A1N, B0, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.07:0.07:0.07,
     tphhl$A0N$Y = 0.061:0.061:0.061,
     tpllh$A1N$Y = 0.068:0.068:0.068,
     tphhl$A1N$Y = 0.06:0.06:0.06,
     tplhl$B0$Y = 0.034:0.035:0.035,
     tphlh$B0$Y = 0.019:0.019:0.019;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI2BB2X4 (A0N, A1N, B0, B1, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   and (I1_out, A0N, A1N);
   not (I2_out, I1_out);
   and (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.073:0.074:0.075,
     tphhl$A0N$Y = 0.067:0.074:0.08,
     tpllh$A1N$Y = 0.068:0.069:0.07,
     tphhl$A1N$Y = 0.064:0.07:0.076,
     tplhl$B0$Y = 0.029:0.036:0.042,
     tphlh$B0$Y = 0.036:0.037:0.037,
     tplhl$B1$Y = 0.026:0.032:0.038,
     tphlh$B1$Y = 0.033:0.033:0.033;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI31X4 (A0, A1, A2, B0, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   output Y ;

   or  (I1_out, A0, A1, A2);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.047:0.047:0.047,
     tphlh$A0$Y = 0.064:0.064:0.064,
     tplhl$A1$Y = 0.043:0.043:0.043,
     tphlh$A1$Y = 0.061:0.061:0.061,
     tplhl$A2$Y = 0.039:0.039:0.039,
     tphlh$A2$Y = 0.054:0.054:0.054,
     tplhl$B0$Y = 0.023:0.031:0.04,
     tphlh$B0$Y = 0.018:0.018:0.018;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI32X4 (A0, A1, A2, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   or  (I2_out, A0, A1, A2);
   and (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.04:0.047:0.054,
     tphlh$A0$Y = 0.068:0.069:0.071,
     tplhl$A1$Y = 0.037:0.044:0.05,
     tphlh$A1$Y = 0.065:0.066:0.067,
     tplhl$A2$Y = 0.034:0.04:0.046,
     tphlh$A2$Y = 0.058:0.059:0.06,
     tplhl$B0$Y = 0.026:0.036:0.046,
     tphlh$B0$Y = 0.036:0.036:0.036,
     tplhl$B1$Y = 0.024:0.033:0.042,
     tphlh$B1$Y = 0.033:0.033:0.033;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR2X4 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.046:0.046:0.046,
     tphhl$A$Y = 0.07:0.07:0.07,
     tpllh$B$Y = 0.043:0.043:0.043,
     tphhl$B$Y = 0.067:0.067:0.067;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR2X6 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.036:0.036:0.036,
     tphhl$A$Y = 0.055:0.055:0.055,
     tpllh$B$Y = 0.034:0.034:0.034,
     tphhl$B$Y = 0.052:0.052:0.052;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR2X8 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.038:0.038:0.038,
     tphhl$A$Y = 0.06:0.06:0.06,
     tpllh$B$Y = 0.036:0.036:0.036,
     tphhl$B$Y = 0.057:0.057:0.057;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR3X1 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.075:0.075:0.075,
     tphhl$A$Y = 0.12:0.12:0.12,
     tpllh$B$Y = 0.072:0.072:0.072,
     tphhl$B$Y = 0.12:0.12:0.12,
     tpllh$C$Y = 0.069:0.069:0.069,
     tphhl$C$Y = 0.11:0.11:0.11;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR3X8 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.042:0.042:0.042,
     tphhl$A$Y = 0.09:0.09:0.09,
     tpllh$B$Y = 0.04:0.04:0.04,
     tphhl$B$Y = 0.087:0.087:0.087,
     tpllh$C$Y = 0.038:0.038:0.038,
     tphhl$C$Y = 0.08:0.08:0.08;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFHQX1 (CK, D, Q, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I5_out, SI);
   not (I7_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I7_out);
   not (I9_out, D);
   not (I10_out, SE);
   not (I12_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tminpwh$CK = 0.049:0.15:0.15,
     tminpwl$CK = 0.051:0.094:0.094,
     tsetup_negedge$D$CK = 0.044:0.044:0.044,
     thold_negedge$D$CK = -0.0062:-0.0062:-0.0062,
     tsetup_negedge$SE$CK = 0.081:0.081:0.081,
     thold_negedge$SE$CK = -0.056:-0.056:-0.056,


     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$D$CK = 0.069:0.069:0.069,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.056:0.056:0.056,
     thold_posedge$SE$CK = -0.019:-0.019:-0.019,


     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFHQX2 (CK, D, Q, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I5_out, SI);
   not (I7_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I7_out);
   not (I9_out, D);
   not (I10_out, SE);
   not (I12_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.049:0.13:0.13,
     tminpwl$CK = 0.051:0.094:0.094,
     tsetup_negedge$D$CK = 0.044:0.044:0.044,
     thold_negedge$D$CK = -0.0062:-0.0062:-0.0062,
     tsetup_negedge$SE$CK = 0.087:0.087:0.087,
     thold_negedge$SE$CK = -0.056:-0.056:-0.056,


     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.056:0.056:0.056,
     thold_posedge$SE$CK = -0.019:-0.019:-0.019,


     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFQX4 (CK, D, Q, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I5_out, SI);
   not (I7_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I7_out);
   not (I9_out, D);
   not (I10_out, SE);
   not (I12_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.12:0.12:0.12,
     tminpwh$CK = 0.058:0.12:0.12,
     tminpwl$CK = 0.053:0.097:0.097,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$SE$CK = 0.1:0.1:0.1,
     thold_negedge$SE$CK = -0.062:-0.062:-0.062,


     tsetup_negedge$SI$CK = 0.069:0.069:0.069,
     thold_negedge$SI$CK = -0.013:-0.013:-0.013,
     tsetup_posedge$D$CK = 0.094:0.094:0.094,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.075:0.075:0.075,
     thold_posedge$SE$CK = -0.019:-0.019:-0.019,


     tsetup_posedge$SI$CK = 0.094:0.094:0.094,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFQXL (CK, D, Q, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I5_out, SI);
   not (I7_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I7_out);
   not (I9_out, D);
   not (I10_out, SE);
   not (I12_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.16:0.16:0.16,
     tplhl$CK$Q = 0.17:0.17:0.17,
     tminpwh$CK = 0.046:0.17:0.17,
     tminpwl$CK = 0.049:0.091:0.091,
     tsetup_negedge$D$CK = 0.063:0.063:0.063,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.087:0.087:0.087,
     thold_negedge$SE$CK = -0.062:-0.062:-0.062,


     tsetup_negedge$SI$CK = 0.063:0.063:0.063,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.081:0.081:0.081,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$SE$CK = 0.069:0.069:0.069,
     thold_posedge$SE$CK = -0.025:-0.025:-0.025,


     tsetup_posedge$SI$CK = 0.081:0.081:0.081,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFRHQX8 (CK, D, Q, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (N30, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I7_out, D);
   and (D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1, I7_out, SE, SI);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I10_out);
   not (I12_out, D);
   not (I14_out, SE);
   not (I16_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0, I12_out, RN, I14_out, I16_out);
   not (I18_out, D);
   not (I19_out, SE);
   not (I21_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I18_out, I19_out, I21_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tphhl$RN$Q = 0.036:0.036:0.036,
     tminpwh$CK = 0.071:0.14:0.14,
     tminpwl$CK = 0.056:0.099:0.099,
     tminpwl$RN = 0.017:0.093:0.093,
     tsetup_negedge$D$CK = 0.044:0.044:0.044,
     thold_negedge$D$CK = -0.000000000081:-0.000000000081:-0.000000000081,
     tsetup_negedge$SE$CK = 0.038:0.087:0.087,
     thold_negedge$SE$CK = -0.056:0.0063:0.0063,
     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.056:0.069:0.069,
     thold_posedge$SE$CK = -0.037:-0.0063:-0.0063,
     tsetup_posedge$SI$CK = 0.075:0.075:0.075,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$RN$CK = -0.038:-0.038:-0.038,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFRX4 (CK, D, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (N30, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I9_out, D);
   and (D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1, I9_out, SE, SI);
   not (I12_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I12_out);
   not (I14_out, D);
   not (I16_out, SE);
   not (I18_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0, I14_out, RN, I16_out, I18_out);
   not (I20_out, D);
   not (I21_out, SE);
   not (I23_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I20_out, I21_out, I23_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.047:0.048:0.048,
     tphlh$RN$QN = 0.073:0.073:0.074,
     tminpwh$CK = 0.06:0.16:0.16,
     tminpwl$CK = 0.051:0.094:0.094,
     tminpwl$RN = 0.02:0.093:0.093,
     tsetup_negedge$D$CK = 0.075:0.075:0.075,
     thold_negedge$D$CK = -0.013:-0.013:-0.013,
     tsetup_negedge$SE$CK = 0.069:0.11:0.11,
     thold_negedge$SE$CK = -0.062:-0.0063:-0.0063,
     tsetup_negedge$SI$CK = 0.075:0.075:0.075,
     thold_negedge$SI$CK = -0.013:-0.013:-0.013,
     tsetup_posedge$D$CK = 0.1:0.1:0.1,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.081:0.094:0.094,
     thold_posedge$SE$CK = -0.05:-0.019:-0.019,
     tsetup_posedge$SI$CK = 0.1:0.1:0.1,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056,
     trec$RN$CK = -0.031:-0.031:-0.031,
     trem$RN$CK = 0.05:0.05:0.05;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSHQX2 (CK, D, Q, SE, SI, SN);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N30, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D);
   not (I7_out, SE);
   not (I9_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I6_out, I7_out, I9_out);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I12_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I12_out, SN);
   not (I14_out, D);
   not (I15_out, SE);
   not (I17_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I14_out, I15_out, I17_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tphlh$SN$Q = 0.099:0.1:0.1,
     tminpwh$CK = 0.055:0.14:0.14,
     tminpwl$CK = 0.056:0.11:0.11,
     tminpwl$SN = 0.015:0.1:0.1,
     tsetup_negedge$D$CK = 0.062:0.062:0.062,
     thold_negedge$D$CK = -0.0062:-0.0062:-0.0062,
     tsetup_negedge$SE$CK = 0.056:0.087:0.087,
     thold_negedge$SE$CK = -0.056:-0.000000000094:-0.000000000094,
     tsetup_negedge$SI$CK = 0.062:0.062:0.062,
     thold_negedge$SI$CK = -0.0062:-0.0062:-0.0062,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.069:0.075:0.075,
     thold_posedge$SE$CK = -0.037:-0.019:-0.019,
     tsetup_posedge$SI$CK = 0.075:0.075:0.075,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$SN$CK = -0.0062:-0.0062:-0.0062,
     trem$SN$CK = 0.044:0.044:0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSRX2 (CK, D, Q, QN, RN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   not (I13_out, SE);
   not (I15_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I12_out, I13_out, I15_out);
   not (I17_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I17_out, SN);
   not (I20_out, D);
   not (I22_out, SE);
   not (I24_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I20_out, RN, I22_out, I24_out, SN);
   not (I27_out, D);
   not (I28_out, SE);
   not (I30_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I27_out, I28_out, I30_out, SN);
   not (I33_out, D);
   not (I34_out, RN);
   not (I36_out, SE);
   not (I38_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I33_out, I34_out, I36_out, I38_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tpllh$CK$QN = 0.18:0.18:0.18,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.19:0.2:0.2,
     tphlh$RN$QN = 0.22:0.22:0.22,
     tplhl$SN$Q = 0.17:0.17:0.17,
     tphlh$SN$Q = 0.13:0.13:0.13,
     tpllh$SN$QN = 0.19:0.19:0.2,
     tphhl$SN$QN = 0.15:0.15:0.16,
     tminpwh$CK = 0.06:0.18:0.18,
     tminpwl$CK = 0.057:0.12:0.12,
     tminpwl$RN = 0.065:0.22:0.22,
     tminpwl$SN = 0.021:0.16:0.16,
     tsetup_negedge$D$CK = 0.1:0.1:0.1,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.094:0.14:0.14,
     thold_negedge$SE$CK = -0.069:-0.013:-0.013,
     tsetup_negedge$SI$CK = 0.1:0.1:0.1,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.13:0.13:0.13,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.11:0.12:0.12,
     thold_posedge$SE$CK = -0.05:-0.025:-0.025,
     tsetup_posedge$SI$CK = 0.12:0.12:0.12,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056,
     trec$RN$CK = 0.069:0.069:0.069,
     trem$RN$CK = -0.019:-0.019:-0.019,
     trec$RN$SN = 0.075:0.087:0.087,
     trec$SN$CK = 0.019:0.019:0.019,
     trem$SN$CK = 0.031:0.031:0.031;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSX2 (CK, D, Q, QN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   not (I9_out, SE);
   not (I11_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I8_out, I9_out, I11_out);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I14_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I14_out, SN);
   not (I16_out, D);
   not (I17_out, SE);
   not (I19_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I16_out, I17_out, I19_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tpllh$CK$QN = 0.17:0.17:0.17,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tphlh$SN$Q = 0.11:0.11:0.11,
     tphhl$SN$QN = 0.13:0.14:0.14,
     tminpwh$CK = 0.053:0.17:0.17,
     tminpwl$CK = 0.055:0.12:0.12,
     tminpwl$SN = 0.018:0.14:0.14,
     tsetup_negedge$D$CK = 0.1:0.1:0.1,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.094:0.11:0.11,
     thold_negedge$SE$CK = -0.063:-0.012:-0.012,
     tsetup_negedge$SI$CK = 0.094:0.094:0.094,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.1:0.1:0.1,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.087:0.11:0.11,
     thold_posedge$SE$CK = -0.05:-0.025:-0.025,
     tsetup_posedge$SI$CK = 0.094:0.094:0.094,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05,
     trec$SN$CK = 0.012:0.012:0.012,
     trem$SN$CK = 0.031:0.031:0.031;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (0, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFX2 (CK, D, Q, QN, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I7_out, SI);
   not (I9_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I9_out);
   not (I11_out, D);
   not (I12_out, SE);
   not (I14_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I11_out, I12_out, I14_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.047:0.16:0.16,
     tminpwl$CK = 0.047:0.091:0.091,
     tsetup_negedge$D$CK = 0.062:0.062:0.062,
     thold_negedge$D$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$SE$CK = 0.1:0.1:0.1,
     thold_negedge$SE$CK = -0.063:-0.063:-0.063,


     tsetup_negedge$SI$CK = 0.069:0.069:0.069,
     thold_negedge$SI$CK = -0.013:-0.013:-0.013,
     tsetup_posedge$D$CK = 0.088:0.088:0.088,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$SE$CK = 0.075:0.075:0.075,
     thold_posedge$SE$CK = -0.025:-0.025:-0.025,


     tsetup_posedge$SI$CK = 0.087:0.087:0.087,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFX4 (CK, D, Q, QN, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I7_out, SI);
   not (I9_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I9_out);
   not (I11_out, D);
   not (I12_out, SE);
   not (I14_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I11_out, I12_out, I14_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tpllh$CK$QN = 0.15:0.15:0.15,
     tplhl$CK$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.054:0.15:0.15,
     tminpwl$CK = 0.045:0.089:0.089,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.11:0.11:0.11,
     thold_negedge$SE$CK = -0.069:-0.069:-0.069,
 
 
     tsetup_negedge$SI$CK = 0.075:0.075:0.075,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.094:0.094:0.094,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.081:0.081:0.081,
     thold_posedge$SE$CK = -0.025:-0.025:-0.025,
 
 
     tsetup_posedge$SI$CK = 0.094:0.094:0.094,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFXL (CK, D, Q, QN, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I7_out, SI);
   not (I9_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I9_out);
   not (I11_out, D);
   not (I12_out, SE);
   not (I14_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I11_out, I12_out, I14_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.17:0.17:0.17,
     tplhl$CK$Q = 0.18:0.18:0.18,
     tpllh$CK$QN = 0.19:0.19:0.19,
     tplhl$CK$QN = 0.18:0.18:0.18,
     tminpwh$CK = 0.048:0.19:0.19,
     tminpwl$CK = 0.05:0.092:0.092,
     tsetup_negedge$D$CK = 0.062:0.062:0.062,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.094:0.094:0.094,
     thold_negedge$SE$CK = -0.062:-0.062:-0.062,


     tsetup_negedge$SI$CK = 0.062:0.062:0.062,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.081:0.081:0.081,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$SE$CK = 0.069:0.069:0.069,
     thold_posedge$SE$CK = -0.025:-0.025:-0.025,


     tsetup_posedge$SI$CK = 0.081:0.081:0.081,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TBUFX12 (A, OE, Y);
   input  A ;
   input  OE ;
   output Y ;

   bufif1 (Y, A, OE);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.047:0.047:0.047,
     tphhl$A$Y = 0.041:0.041:0.041,
     tpzh$OE$Y = 0.044:0.044:0.044,
     tpzl$OE$Y = 0.06:0.06:0.06,
     tplz$OE$Y = 0.045:0.045:0.045,
     tphz$OE$Y = 0.025:0.025:0.025;

      // path delays
      (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TBUFX20 (A, OE, Y);
   input  A ;
   input  OE ;
   output Y ;

   bufif1 (Y, A, OE);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.044:0.044:0.044,
     tphhl$A$Y = 0.039:0.039:0.039,
     tpzh$OE$Y = 0.041:0.041:0.041,
     tpzl$OE$Y = 0.052:0.052:0.052,
     tplz$OE$Y = 0.04:0.04:0.04,
     tphz$OE$Y = 0.026:0.026:0.026;

      // path delays
      (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TBUFX4 (A, OE, Y);
   input  A ;
   input  OE ;
   output Y ;

   bufif1 (Y, A, OE);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.056:0.056:0.056,
     tphhl$A$Y = 0.049:0.049:0.049,
     tpzh$OE$Y = 0.053:0.053:0.053,
     tpzl$OE$Y = 0.06:0.06:0.06,
     tplz$OE$Y = 0.035:0.035:0.035,
     tphz$OE$Y = 0.023:0.023:0.023;

      // path delays
      (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNCAX16 (CK, E, ECK);
   input  CK ;
   input  E ;
   output ECK ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (EINT, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, EINT);
   and (ECK, CK, EINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.13:0.13:0.13,
     tphhl$CK$ECK = 0.12:0.12:0.12,
     tminpwl$CK = 0.12:0.15:0.15,
     tsetup_negedge$E$CK = -0.0000000003:-0.0000000003:-0.0000000003,
     thold_negedge$E$CK = 0.0063:0.0063:0.0063,
     tsetup_posedge$E$CK = 0.038:0.038:0.038,
     thold_posedge$E$CK = -0.031:-0.031:-0.031;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(negedge CK &&& E == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNSRX2 (D, GN, Q, QN, RN, SN);
   input  D ;
   input  GN ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, GN);
   and (I0_ENABLE, I0_out, RN);
   not (I0_SET, SN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (N5, QINT);
   buf (Q, QINT);
   not (QN, QINT);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I13_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.12:0.12:0.12,
     tphhl$D$Q = 0.15:0.15:0.15,
     tplhl$D$QN = 0.12:0.12:0.12,
     tphlh$D$QN = 0.15:0.15:0.15,
     tphlh$GN$Q = 0.2:0.2:0.2,
     tphhl$GN$Q = 0.21:0.21:0.21,
     tphlh$GN$QN = 0.21:0.21:0.21,
     tphhl$GN$QN = 0.19:0.19:0.19,
     tpllh$RN$Q = 0.18:0.18:0.18,
     tphhl$RN$Q = 0.16:0.17:0.19,
     tplhl$RN$QN = 0.18:0.18:0.18,
     tphlh$RN$QN = 0.15:0.17:0.19,
     tplhl$SN$Q = 0.098:0.098:0.099,
     tphlh$SN$Q = 0.073:0.074:0.074,
     tpllh$SN$QN = 0.096:0.096:0.097,
     tphhl$SN$QN = 0.068:0.068:0.068,
     tminpwl$GN = 0.094:0.21:0.21,
     tminpwl$RN = 0.043:0.16:0.16,
     tminpwl$SN = 0.025:0.096:0.096,
     tsetup_negedge$D$GN = 0.044:0.044:0.044,
     thold_negedge$D$GN = -0.025:-0.025:-0.025,
     tsetup_posedge$D$GN = 0.019:0.019:0.019,
     thold_posedge$D$GN = 0:0:0,
     tsetup_posedge$RN$GN = 0.081:0.081:0.081,
     thold_posedge$RN$GN = -0.062:-0.062:-0.062,
     trec$SN$GN = -0.0063:-0.0063:-0.0063,
     trem$SN$GN = 0.037:0.037:0.037,
     trec$SN$RN = 0.012:0.012:0.012,
     trem$SN$RN = 0.0062:0.0062:0.0062;

      // path delays
      (posedge RN *> (QN -: 1'b1)) = (0, tplhl$RN$QN);
      (posedge RN *> (Q +: 1'b1)) = (tpllh$RN$Q, 0);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
      (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$GN, NOTIFIER);
      $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$GN,  NOTIFIER);
      $setup(posedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$GN, NOTIFIER);
      $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$GN,  NOTIFIER);
      $setup(posedge RN, posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$GN, NOTIFIER);
      $hold (posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$GN,  NOTIFIER);
      $recovery(posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$GN, NOTIFIER);
      $removal (posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$GN, NOTIFIER);
      $recovery(posedge SN, posedge RN &&& GN == 1'b1, trec$SN$RN, NOTIFIER);
      $removal (posedge SN, posedge RN &&& GN == 1'b1, trem$SN$RN, NOTIFIER);
      $width(negedge GN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$GN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNTSCAX12 (CK, E, ECK, SE);
   input  CK ;
   input  E ;
   input  SE ;
   output ECK ;
   reg 	  NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (EINT, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N5, EINT);
   and (ECK, CK, EINT);
   not (I6_out, E);
   not (I7_out, SE);
   and (E_EQ_0_AN_SE_EQ_0, I6_out, I7_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.12:0.12:0.12,
     tphhl$CK$ECK = 0.11:0.11:0.11,
     tminpwl$CK = 0.079:0.12:0.12,
     tsetup_negedge$E$CK = 0.044:0.044:0.044,
     thold_negedge$E$CK = -0.037:-0.037:-0.037,
     tsetup_negedge$SE$CK = 0.05:0.05:0.05,
     thold_negedge$SE$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$E$CK = 0.044:0.044:0.044,
     thold_posedge$E$CK = -0.037:-0.037:-0.037,
     tsetup_posedge$SE$CK = 0.05:0.05:0.05,
     thold_posedge$SE$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $width(negedge CK &&& E_EQ_0_AN_SE_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNTSCAX2 (CK, E, ECK, SE);
   input  CK ;
   input  E ;
   input  SE ;
   output ECK ;
   reg 	  NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (EINT, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N5, EINT);
   and (ECK, CK, EINT);
   not (I6_out, E);
   not (I7_out, SE);
   and (E_EQ_0_AN_SE_EQ_0, I6_out, I7_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.12:0.12:0.12,
     tphhl$CK$ECK = 0.1:0.1:0.1,
     tminpwl$CK = 0.063:0.1:0.1,
     tsetup_negedge$E$CK = 0.044:0.044:0.044,
     thold_negedge$E$CK = -0.037:-0.037:-0.037,
     tsetup_negedge$SE$CK = 0.05:0.05:0.05,
     thold_negedge$SE$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$E$CK = 0.037:0.037:0.037,
     thold_posedge$E$CK = -0.031:-0.031:-0.031,
     tsetup_posedge$SE$CK = 0.044:0.044:0.044,
     thold_posedge$SE$CK = -0.037:-0.037:-0.037;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $width(negedge CK &&& E_EQ_0_AN_SE_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNTSCAX20 (CK, E, ECK, SE);
   input  CK ;
   input  E ;
   input  SE ;
   output ECK ;
   reg 	  NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (EINT, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N5, EINT);
   and (ECK, CK, EINT);
   not (I6_out, E);
   not (I7_out, SE);
   and (E_EQ_0_AN_SE_EQ_0, I6_out, I7_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.14:0.14:0.14,
     tphhl$CK$ECK = 0.12:0.12:0.12,
     tminpwl$CK = 0.099:0.14:0.14,
     tsetup_negedge$E$CK = 0.05:0.05:0.05,
     thold_negedge$E$CK = -0.044:-0.044:-0.044,
     tsetup_negedge$SE$CK = 0.05:0.05:0.05,
     thold_negedge$SE$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$E$CK = 0.05:0.05:0.05,
     thold_posedge$E$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.056:0.056:0.056,
     thold_posedge$SE$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $width(negedge CK &&& E_EQ_0_AN_SE_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNTSCAX6 (CK, E, ECK, SE);
   input  CK ;
   input  E ;
   input  SE ;
   output ECK ;
   reg 	  NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (EINT, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N5, EINT);
   and (ECK, CK, EINT);
   not (I6_out, E);
   not (I7_out, SE);
   and (E_EQ_0_AN_SE_EQ_0, I6_out, I7_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.11:0.11:0.11,
     tphhl$CK$ECK = 0.093:0.093:0.093,
     tminpwl$CK = 0.069:0.11:0.11,
     tsetup_negedge$E$CK = 0.05:0.05:0.05,
     thold_negedge$E$CK = -0.044:-0.044:-0.044,
     tsetup_negedge$SE$CK = 0.05:0.05:0.05,
     thold_negedge$SE$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$E$CK = 0.044:0.044:0.044,
     thold_posedge$E$CK = -0.037:-0.037:-0.037,
     tsetup_posedge$SE$CK = 0.044:0.044:0.044,
     thold_posedge$SE$CK = -0.038:-0.038:-0.038;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $width(negedge CK &&& E_EQ_0_AN_SE_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNX4 (D, GN, Q, QN);
   input  D ;
   input  GN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, GN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, QINT);
   buf (Q, QINT);
   not (QN, QINT);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.11:0.11:0.11,
     tphhl$D$Q = 0.11:0.11:0.11,
     tplhl$D$QN = 0.1:0.1:0.1,
     tphlh$D$QN = 0.1:0.1:0.1,
     tphlh$GN$Q = 0.14:0.14:0.14,
     tphhl$GN$Q = 0.15:0.15:0.15,
     tphlh$GN$QN = 0.14:0.14:0.14,
     tphhl$GN$QN = 0.13:0.13:0.13,
     tminpwl$GN = 0.06:0.15:0.15,
     tsetup_negedge$D$GN = 0.038:0.038:0.038,
     thold_negedge$D$GN = -0.019:-0.019:-0.019,
     tsetup_posedge$D$GN = 0.056:0.056:0.056,
     thold_posedge$D$GN = -0.038:-0.038:-0.038;

      // path delays
      (negedge GN *> (QN -: D)) = (tphlh$GN$QN, tphhl$GN$QN);
      (negedge GN *> (Q +: D)) = (tphlh$GN$Q, tphhl$GN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, posedge GN, tsetup_negedge$D$GN, NOTIFIER);
      $hold (posedge GN, negedge D, thold_negedge$D$GN,  NOTIFIER);
      $setup(posedge D, posedge GN, tsetup_posedge$D$GN, NOTIFIER);
      $hold (posedge GN, posedge D, thold_posedge$D$GN,  NOTIFIER);
      $width(negedge GN &&& D == 1'b0, tminpwl$GN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATSRX1 (D, G, Q, QN, RN, SN);
   input  D ;
   input  G ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_ENABLE, G, RN);
   not (I0_SET, SN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (N5, QINT);
   buf (Q, QINT);
   not (QN, QINT);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I12_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.14:0.14:0.14,
     tphhl$D$Q = 0.16:0.16:0.16,
     tplhl$D$QN = 0.13:0.13:0.13,
     tphlh$D$QN = 0.16:0.16:0.16,
     tpllh$G$Q = 0.19:0.19:0.19,
     tplhl$G$Q = 0.2:0.2:0.2,
     tpllh$G$QN = 0.2:0.2:0.2,
     tplhl$G$QN = 0.19:0.19:0.19,
     tpllh$RN$Q = 0.19:0.19:0.19,
     tphhl$RN$Q = 0.17:0.19:0.2,
     tplhl$RN$QN = 0.19:0.19:0.19,
     tphlh$RN$QN = 0.17:0.19:0.2,
     tplhl$SN$Q = 0.12:0.12:0.12,
     tphlh$SN$Q = 0.094:0.095:0.095,
     tpllh$SN$QN = 0.12:0.12:0.12,
     tphhl$SN$QN = 0.089:0.089:0.09,
     tminpwh$G = 0.071:0.2:0.2,
     tminpwl$RN = 0.039:0.17:0.17,
     tminpwl$SN = 0.026:0.095:0.095,
     tsetup_negedge$D$G = 0.056:0.056:0.056,
     thold_negedge$D$G = -0.038:-0.038:-0.038,
     tsetup_posedge$D$G = 0.038:0.038:0.038,
     thold_posedge$D$G = -0.019:-0.019:-0.019,
     tsetup_posedge$RN$G = 0.094:0.094:0.094,
     thold_posedge$RN$G = -0.075:-0.075:-0.075,
     trec$SN$G = 0.0062:0.0062:0.0062,
     trem$SN$G = 0.019:0.019:0.019,
     trec$SN$RN = 0.013:0.013:0.013,
     trem$SN$RN = 0.0063:0.0063:0.0063;

      // path delays
      (posedge RN *> (QN -: 1'b1)) = (0, tplhl$RN$QN);
      (posedge RN *> (Q +: 1'b1)) = (tpllh$RN$Q, 0);
      (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
      (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$G, NOTIFIER);
      $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$G,  NOTIFIER);
      $setup(posedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$G, NOTIFIER);
      $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$G,  NOTIFIER);
      $setup(posedge RN, negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$G, NOTIFIER);
      $hold (negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$G,  NOTIFIER);
      $recovery(posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$G, NOTIFIER);
      $removal (posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$G, NOTIFIER);
      $recovery(posedge SN, posedge RN &&& G == 1'b0, trec$SN$RN, NOTIFIER);
      $removal (posedge SN, posedge RN &&& G == 1'b0, trem$SN$RN, NOTIFIER);
      $width(posedge G &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$G, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATSRXL (D, G, Q, QN, RN, SN);
   input  D ;
   input  G ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_ENABLE, G, RN);
   not (I0_SET, SN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (N5, QINT);
   buf (Q, QINT);
   not (QN, QINT);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I12_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.16:0.16:0.16,
     tphhl$D$Q = 0.18:0.18:0.18,
     tplhl$D$QN = 0.15:0.15:0.15,
     tphlh$D$QN = 0.18:0.18:0.18,
     tpllh$G$Q = 0.22:0.22:0.22,
     tplhl$G$Q = 0.23:0.23:0.23,
     tpllh$G$QN = 0.22:0.22:0.22,
     tplhl$G$QN = 0.21:0.21:0.21,
     tpllh$RN$Q = 0.22:0.22:0.22,
     tphhl$RN$Q = 0.19:0.21:0.23,
     tplhl$RN$QN = 0.21:0.21:0.21,
     tphlh$RN$QN = 0.19:0.21:0.22,
     tplhl$SN$Q = 0.14:0.14:0.14,
     tphlh$SN$Q = 0.12:0.12:0.12,
     tpllh$SN$QN = 0.14:0.14:0.14,
     tphhl$SN$QN = 0.11:0.11:0.11,
     tminpwh$G = 0.07:0.23:0.23,
     tminpwl$RN = 0.038:0.19:0.19,
     tminpwl$SN = 0.023:0.12:0.12,
     tsetup_negedge$D$G = 0.05:0.05:0.05,
     thold_negedge$D$G = -0.031:-0.031:-0.031,
     tsetup_posedge$D$G = 0.025:0.025:0.025,
     thold_posedge$D$G = -0.012:-0.012:-0.012,
     tsetup_posedge$RN$G = 0.087:0.087:0.087,
     thold_posedge$RN$G = -0.075:-0.075:-0.075,
     trec$SN$G = -0.000000000084:-0.000000000084:-0.000000000084,
     trem$SN$G = 0.019:0.019:0.019,
     trec$SN$RN = 0.0062:0.0062:0.0062,
     trem$SN$RN = 0.013:0.013:0.013;

      // path delays
      (posedge RN *> (QN -: 1'b1)) = (0, tplhl$RN$QN);
      (posedge RN *> (Q +: 1'b1)) = (tpllh$RN$Q, 0);
      (G *> QN) = (tpllh$G$QN, tplhl$G$QN);
      (G *> Q) = (tpllh$G$Q, tplhl$G$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$G, NOTIFIER);
      $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$G,  NOTIFIER);
      $setup(posedge D, negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$G, NOTIFIER);
      $hold (negedge G &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$G,  NOTIFIER);
      $setup(posedge RN, negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$G, NOTIFIER);
      $hold (negedge G &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$G,  NOTIFIER);
      $recovery(posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$G, NOTIFIER);
      $removal (posedge SN, negedge G &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$G, NOTIFIER);
      $recovery(posedge SN, posedge RN &&& G == 1'b0, trec$SN$RN, NOTIFIER);
      $removal (posedge SN, posedge RN &&& G == 1'b0, trem$SN$RN, NOTIFIER);
      $width(posedge G &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$G, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATX1 (D, G, Q, QN);
   input  D ;
   input  G ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_tlat (QINT, D, G, 1'B0, 1'B0, NOTIFIER);
   not (N0, QINT);
   buf (Q, QINT);
   not (QN, QINT);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.13:0.13:0.13,
     tphhl$D$Q = 0.13:0.13:0.13,
     tplhl$D$QN = 0.13:0.13:0.13,
     tphlh$D$QN = 0.12:0.12:0.12,
     tpllh$G$Q = 0.17:0.17:0.17,
     tplhl$G$Q = 0.15:0.15:0.15,
     tpllh$G$QN = 0.14:0.14:0.14,
     tplhl$G$QN = 0.16:0.16:0.16,
     tminpwh$G = 0.048:0.15:0.15,
     tsetup_negedge$D$G = 0.044:0.044:0.044,
     thold_negedge$D$G = -0.031:-0.031:-0.031,
     tsetup_posedge$D$G = 0.025:0.025:0.025,
     thold_posedge$D$G = -0.0063:-0.0063:-0.0063;

      // path delays
      (posedge G *> (QN -: D)) = (tpllh$G$QN, tplhl$G$QN);
      (posedge G *> (Q +: D)) = (tpllh$G$Q, tplhl$G$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, negedge G, tsetup_negedge$D$G, NOTIFIER);
      $hold (negedge G, negedge D, thold_negedge$D$G,  NOTIFIER);
      $setup(posedge D, negedge G, tsetup_posedge$D$G, NOTIFIER);
      $hold (negedge G, posedge D, thold_posedge$D$G,  NOTIFIER);
      $width(posedge G &&& D == 1'b0, tminpwh$G, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XNOR3X1 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   xor (I0_out, A, B);
   xor (I1_out, I0_out, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.14:0.15:0.15,
     tplhl$A$Y = 0.19:0.2:0.2,
     tphlh$A$Y = 0.18:0.18:0.18,
     tphhl$A$Y = 0.14:0.14:0.15,
     tpllh$B$Y = 0.12:0.13:0.14,
     tplhl$B$Y = 0.13:0.14:0.15,
     tphlh$B$Y = 0.13:0.13:0.13,
     tphhl$B$Y = 0.13:0.14:0.14,
     tpllh$C$Y = 0.088:0.089:0.089,
     tplhl$C$Y = 0.1:0.11:0.11,
     tphlh$C$Y = 0.095:0.096:0.096,
     tphhl$C$Y = 0.098:0.1:0.1;

      // path delays
      (posedge C *> (Y +: B^A)) = (tpllh$C$Y, tplhl$C$Y);
      (negedge C *> (Y +: !(B^A))) = (tphlh$C$Y, tphhl$C$Y);
      (posedge B *> (Y +: !(C^!A))) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: !(C^A))) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: !(C^!B))) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: !(C^B))) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XNOR3XL (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   xor (I0_out, A, B);
   xor (I1_out, I0_out, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.18:0.18:0.18,
     tplhl$A$Y = 0.19:0.19:0.19,
     tphlh$A$Y = 0.22:0.22:0.22,
     tphhl$A$Y = 0.15:0.16:0.16,
     tpllh$B$Y = 0.16:0.16:0.17,
     tplhl$B$Y = 0.14:0.14:0.15,
     tphlh$B$Y = 0.17:0.17:0.17,
     tphhl$B$Y = 0.14:0.14:0.14,
     tpllh$C$Y = 0.12:0.12:0.12,
     tplhl$C$Y = 0.11:0.11:0.11,
     tphlh$C$Y = 0.13:0.13:0.13,
     tphhl$C$Y = 0.098:0.099:0.099;

      // path delays
      (posedge C *> (Y +: B^A)) = (tpllh$C$Y, tplhl$C$Y);
      (negedge C *> (Y +: !(B^A))) = (tphlh$C$Y, tphhl$C$Y);
      (posedge B *> (Y +: !(C^!A))) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: !(C^A))) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: !(C^!B))) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: !(C^B))) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND2X1 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.085:0.085:0.085,
     tphhl$A$Y = 0.07:0.07:0.07,
     tpllh$B$Y = 0.083:0.083:0.083,
     tphhl$B$Y = 0.069:0.069:0.069;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AO21X4 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (Y, I0_out, B0);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.074:0.074:0.074,
     tphhl$A0$Y = 0.077:0.077:0.077,
     tpllh$A1$Y = 0.072:0.072:0.072,
     tphhl$A1$Y = 0.074:0.074:0.074,
     tpllh$B0$Y = 0.043:0.044:0.045,
     tphhl$B0$Y = 0.055:0.063:0.07;

      // path delays
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI211X1 (A0, A1, B0, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  C0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.1:0.1:0.1,
     tphlh$A0$Y = 0.15:0.15:0.15,
     tplhl$A1$Y = 0.1:0.1:0.1,
     tphlh$A1$Y = 0.15:0.15:0.15,
     tplhl$B0$Y = 0.052:0.052:0.052,
     tphlh$B0$Y = 0.12:0.13:0.14,
     tplhl$C0$Y = 0.05:0.05:0.05,
     tphlh$C0$Y = 0.11:0.12:0.14;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI21X2 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (I1_out, I0_out, B0);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.058:0.058:0.058,
     tphlh$A0$Y = 0.058:0.058:0.058,
     tplhl$A1$Y = 0.056:0.056:0.056,
     tphlh$A1$Y = 0.056:0.056:0.056,
     tplhl$B0$Y = 0.028:0.028:0.028,
     tphlh$B0$Y = 0.037:0.044:0.051;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI221X2 (A0, A1, B0, B1, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   output Y ;

   and (I0_out, A0, A1);
   and (I1_out, B0, B1);
   or  (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.068:0.069:0.07,
     tphlh$A0$Y = 0.085:0.094:0.1,
     tplhl$A1$Y = 0.066:0.067:0.068,
     tphlh$A1$Y = 0.082:0.091:0.1,
     tplhl$B0$Y = 0.061:0.061:0.061,
     tphlh$B0$Y = 0.076:0.086:0.095,
     tplhl$B1$Y = 0.059:0.059:0.059,
     tphlh$B1$Y = 0.073:0.083:0.092,
     tplhl$C0$Y = 0.029:0.029:0.029,
     tphlh$C0$Y = 0.05:0.066:0.082;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI222X1 (A0, A1, B0, B1, C0, C1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   input  C1 ;
   output Y ;

   and (I0_out, C0, C1);
   and (I1_out, A0, A1);
   and (I3_out, B0, B1);
   or  (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.11:0.11:0.12,
     tphlh$A0$Y = 0.12:0.14:0.17,
     tplhl$A1$Y = 0.11:0.11:0.11,
     tphlh$A1$Y = 0.11:0.14:0.17,
     tplhl$B0$Y = 0.1:0.11:0.11,
     tphlh$B0$Y = 0.11:0.14:0.16,
     tplhl$B1$Y = 0.1:0.1:0.1,
     tphlh$B1$Y = 0.11:0.13:0.16,
     tplhl$C0$Y = 0.094:0.094:0.094,
     tphlh$C0$Y = 0.093:0.12:0.15,
     tplhl$C1$Y = 0.092:0.092:0.092,
     tphlh$C1$Y = 0.091:0.12:0.14;

      // path delays
      (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI222X4 (A0, A1, B0, B1, C0, C1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   input  C1 ;
   output Y ;

   and (I0_out, C0, C1);
   and (I1_out, A0, A1);
   and (I3_out, B0, B1);
   or  (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.052:0.055:0.058,
     tphlh$A0$Y = 0.057:0.071:0.086,
     tplhl$A1$Y = 0.05:0.053:0.056,
     tphlh$A1$Y = 0.054:0.068:0.082,
     tplhl$B0$Y = 0.046:0.047:0.049,
     tphlh$B0$Y = 0.048:0.063:0.077,
     tplhl$B1$Y = 0.044:0.045:0.046,
     tphlh$B1$Y = 0.046:0.059:0.073,
     tplhl$C0$Y = 0.037:0.037:0.037,
     tphlh$C0$Y = 0.036:0.048:0.061,
     tplhl$C1$Y = 0.035:0.035:0.035,
     tphlh$C1$Y = 0.033:0.045:0.057;

      // path delays
      (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI2BB1X1 (A0N, A1N, B0, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.11:0.11:0.11,
     tphhl$A0N$Y = 0.091:0.091:0.091,
     tpllh$A1N$Y = 0.11:0.11:0.11,
     tphhl$A1N$Y = 0.087:0.087:0.087,
     tplhl$B0$Y = 0.051:0.051:0.051,
     tphlh$B0$Y = 0.092:0.093:0.093;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI31XL (A0, A1, A2, B0, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   output Y ;

   and (I1_out, A0, A1, A2);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.23:0.23:0.23,
     tphlh$A0$Y = 0.16:0.16:0.16,
     tplhl$A1$Y = 0.22:0.22:0.22,
     tphlh$A1$Y = 0.16:0.16:0.16,
     tplhl$A2$Y = 0.22:0.22:0.22,
     tphlh$A2$Y = 0.16:0.16:0.16,
     tplhl$B0$Y = 0.077:0.078:0.078,
     tphlh$B0$Y = 0.099:0.13:0.15;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI33XL (A0, A1, A2, B0, B1, B2, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   input  B2 ;
   output Y ;

   and (I1_out, B0, B1, B2);
   and (I3_out, A0, A1, A2);
   or  (I4_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.24:0.25:0.25,
     tphlh$A0$Y = 0.13:0.15:0.18,
     tplhl$A1$Y = 0.24:0.24:0.25,
     tphlh$A1$Y = 0.13:0.15:0.18,
     tplhl$A2$Y = 0.24:0.24:0.24,
     tphlh$A2$Y = 0.12:0.15:0.17,
     tplhl$B0$Y = 0.22:0.22:0.22,
     tphlh$B0$Y = 0.11:0.14:0.16,
     tplhl$B1$Y = 0.22:0.22:0.22,
     tphlh$B1$Y = 0.11:0.13:0.16,
     tplhl$B2$Y = 0.21:0.21:0.21,
     tphlh$B2$Y = 0.1:0.13:0.16;

      // path delays
      (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module BMXIX4 (A, M0, M1, PPN, S, X2);
   input  A ;
   input  M0 ;
   input  M1 ;
   input  S ;
   input  X2 ;
   output PPN ;

   udp_mux2 (I0_out, S, A, M0);
   udp_mux2 (I1_out, S, A, M1);
   udp_mux2 (PPN, I1_out, I0_out, X2);

    specify
      // delay parameters
      specparam
	tpllh$A$PPN = 0.16:0.16:0.16,
     tphhl$A$PPN = 0.17:0.17:0.17,
     tpllh$M0$PPN = 0.15:0.15:0.15,
     tplhl$M0$PPN = 0.18:0.18:0.18,
     tphlh$M0$PPN = 0.17:0.17:0.17,
     tphhl$M0$PPN = 0.16:0.16:0.16,
     tpllh$M1$PPN = 0.15:0.15:0.15,
     tplhl$M1$PPN = 0.17:0.17:0.17,
     tphlh$M1$PPN = 0.17:0.17:0.17,
     tphhl$M1$PPN = 0.16:0.16:0.16,
     tpllh$S$PPN = 0.16:0.16:0.16,
     tphhl$S$PPN = 0.17:0.17:0.17,
     tpllh$X2$PPN = 0.1:0.1:0.1,
     tplhl$X2$PPN = 0.11:0.11:0.11,
     tphlh$X2$PPN = 0.11:0.11:0.11,
     tphhl$X2$PPN = 0.11:0.11:0.11;

      // path delays
      (posedge X2 *> (PPN +: M0?A:S)) = (tpllh$X2$PPN, tplhl$X2$PPN);
      (negedge X2 *> (PPN +: M1?A:S)) = (tphlh$X2$PPN, tphhl$X2$PPN);
      (S *> PPN) = (tpllh$S$PPN, tphhl$S$PPN);
      (posedge M1 *> (PPN +: X2?(M0?A:S):A)) = (tpllh$M1$PPN, tplhl$M1$PPN);
      (negedge M1 *> (PPN +: X2?(M0?A:S):S)) = (tphlh$M1$PPN, tphhl$M1$PPN);
      (posedge M0 *> (PPN +: X2?A:(M1?A:S))) = (tpllh$M0$PPN, tplhl$M0$PPN);
      (negedge M0 *> (PPN +: X2?S:(M1?A:S))) = (tphlh$M0$PPN, tphhl$M0$PPN);
      (A *> PPN) = (tpllh$A$PPN, tphhl$A$PPN);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module BUFX6 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.032:0.032:0.032,
     tphhl$A$Y = 0.034:0.034:0.034;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKAND2X8 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.04:0.04:0.04,
     tphhl$A$Y = 0.043:0.043:0.043,
     tpllh$B$Y = 0.037:0.037:0.037,
     tphhl$B$Y = 0.04:0.04:0.04;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKMX2X2 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.086:0.086:0.086,
     tphhl$A$Y = 0.089:0.089:0.089,
     tpllh$B$Y = 0.086:0.086:0.086,
     tphhl$B$Y = 0.091:0.091:0.091,
     tpllh$S0$Y = 0.079:0.079:0.079,
     tplhl$S0$Y = 0.1:0.1:0.1,
     tphlh$S0$Y = 0.098:0.098:0.098,
     tphhl$S0$Y = 0.083:0.083:0.083;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKMX2X3 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.072:0.072:0.072,
     tphhl$A$Y = 0.074:0.074:0.074,
     tpllh$B$Y = 0.071:0.071:0.071,
     tphhl$B$Y = 0.075:0.075:0.075,
     tpllh$S0$Y = 0.064:0.064:0.064,
     tplhl$S0$Y = 0.088:0.088:0.088,
     tphlh$S0$Y = 0.087:0.087:0.087,
     tphhl$S0$Y = 0.067:0.067:0.067;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKMX2X4 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.082:0.082:0.082,
     tphhl$A$Y = 0.086:0.086:0.086,
     tpllh$B$Y = 0.081:0.081:0.081,
     tphhl$B$Y = 0.086:0.086:0.086,
     tpllh$S0$Y = 0.075:0.075:0.075,
     tplhl$S0$Y = 0.097:0.097:0.097,
     tphlh$S0$Y = 0.095:0.095:0.095,
     tphhl$S0$Y = 0.08:0.08:0.08;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFQXL (CK, D, Q);
   input  CK ;
   input  D ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.16:0.16:0.16,
     tplhl$CK$Q = 0.18:0.18:0.18,
     tminpwh$CK = 0.051:0.18:0.18,
     tminpwl$CK = 0.054:0.11:0.11,
     tsetup_negedge$D$CK = 0.012:0.012:0.012,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.037:0.037:0.037,
     thold_posedge$D$CK = -0.019:-0.019:-0.019;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFRHQX8 (CK, D, Q, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   udp_dff (N30, D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I5_out, RN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tphhl$RN$Q = 0.036:0.036:0.036,
     tminpwh$CK = 0.07:0.14:0.14,
     tminpwl$CK = 0.053:0.11:0.11,
     tminpwl$RN = 0.017:0.094:0.094,
     tsetup_negedge$D$CK = 0.0062:0.0062:0.0062,
     thold_negedge$D$CK = 0.037:0.037:0.037,
     tsetup_posedge$D$CK = 0.044:0.044:0.044,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = -0.031:-0.031:-0.031,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D == 1'b0, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSRX4 (CK, D, Q, QN, RN, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I8_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I12_out, RN, SN);
   not (I15_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I15_out, SN);
   not (I17_out, D);
   not (I18_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I17_out, I18_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tpllh$CK$QN = 0.17:0.17:0.17,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tphhl$RN$Q = 0.17:0.18:0.19,
     tphlh$RN$QN = 0.2:0.21:0.22,
     tplhl$SN$Q = 0.15:0.16:0.17,
     tphlh$SN$Q = 0.12:0.12:0.12,
     tpllh$SN$QN = 0.18:0.19:0.2,
     tphhl$SN$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.067:0.17:0.17,
     tminpwl$CK = 0.058:0.14:0.14,
     tminpwl$RN = 0.067:0.22:0.22,
     tminpwl$SN = 0.025:0.15:0.15,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.1:0.1:0.1,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = 0.087:0.087:0.087,
     trem$RN$CK = -0.019:-0.019:-0.019,
     trec$RN$SN = 0.087:0.088:0.088,
     trec$SN$CK = 0.031:0.031:0.031,
     trem$SN$CK = 0.025:0.025:0.025;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSX1 (CK, D, Q, QN, SN);
   input  CK ;
   input  D ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (N35, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I7_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tpllh$CK$QN = 0.18:0.18:0.18,
     tplhl$CK$QN = 0.16:0.16:0.16,
     tphlh$SN$Q = 0.14:0.14:0.14,
     tphhl$SN$QN = 0.15:0.15:0.16,
     tminpwh$CK = 0.052:0.18:0.18,
     tminpwl$CK = 0.054:0.12:0.12,
     tminpwl$SN = 0.02:0.16:0.16,
     tsetup_negedge$D$CK = 0.056:0.056:0.056,
     thold_negedge$D$CK = 0.019:0.019:0.019,
     tsetup_posedge$D$CK = 0.056:0.056:0.056,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$SN$CK = 0.019:0.019:0.019,
     trem$SN$CK = 0.031:0.031:0.031;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (0, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFTRXL (CK, D, Q, QN, RN);
   input  CK ;
   input  D ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   and (I0_D, D, RN);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I7_out, D);
   not (I8_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I7_out, I8_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.16:0.16:0.16,
     tplhl$CK$Q = 0.18:0.18:0.18,
     tpllh$CK$QN = 0.19:0.19:0.19,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tminpwh$CK = 0.046:0.19:0.19,
     tminpwl$CK = 0.049:0.084:0.084,
     tsetup_negedge$D$CK = 0.025:0.025:0.025,
     thold_negedge$D$CK = 0.0063:0.0063:0.0063,
     tsetup_negedge$RN$CK = 0.025:0.025:0.025,
     thold_negedge$RN$CK = 0.0063:0.0063:0.0063,
     tsetup_posedge$D$CK = 0.069:0.069:0.069,
     thold_posedge$D$CK = -0.038:-0.038:-0.038,
     tsetup_posedge$RN$CK = 0.069:0.069:0.069,
     thold_posedge$RN$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (QN -: RN&D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: RN&D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& RN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFXL (CK, D, Q, QN);
   input  CK ;
   input  D ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.17:0.17:0.17,
     tplhl$CK$Q = 0.19:0.19:0.19,
     tpllh$CK$QN = 0.2:0.2:0.2,
     tplhl$CK$QN = 0.18:0.18:0.18,
     tminpwh$CK = 0.053:0.2:0.2,
     tminpwl$CK = 0.054:0.11:0.11,
     tsetup_negedge$D$CK = 0.012:0.012:0.012,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.038:0.038:0.038,
     thold_posedge$D$CK = -0.019:-0.019:-0.019;

      // path delays
      (posedge CK *> (QN -: D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DLY2X1 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.19:0.19:0.19,
     tphhl$A$Y = 0.19:0.19:0.19;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DLY3X1 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.26:0.26:0.26,
     tphhl$A$Y = 0.26:0.26:0.26;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DLY4X4 (A, Y);
   input  A ;
   output Y ;

   buf (Y, A);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.31:0.31:0.31,
     tphhl$A$Y = 0.31:0.31:0.31;

      // path delays
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFHQX8 (CK, D, E, Q);
   input  CK ;
   input  D ;
   input  E ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D);
   and (D_EQ_0_AN_E_EQ_1, I6_out, E);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.12:0.12:0.12,
     tminpwh$CK = 0.062:0.12:0.12,
     tminpwl$CK = 0.047:0.089:0.089,
     tsetup_negedge$D$CK = 0.063:0.063:0.063,
     thold_negedge$D$CK = -0.013:-0.013:-0.013,
     tsetup_negedge$E$CK = 0.012:0.012:0.012,
     thold_negedge$E$CK = 0.012:0.012:0.012,


     tsetup_posedge$D$CK = 0.088:0.088:0.088,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$E$CK = 0.081:0.081:0.081,
      thold_posedge$E$CK = -0.056:-0.056:-0.056;
       


      // path delays
      (posedge CK *> (Q +: E?D:!QBINT)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module INVX6 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.014:0.014:0.014,
     tphlh$A$Y = 0.013:0.013:0.013;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX3XL (A, B, C, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   udp_mux2 (Y, I0_out, C, S1);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.17:0.17:0.17,
     tphhl$A$Y = 0.17:0.17:0.17,
     tpllh$B$Y = 0.17:0.17:0.17,
     tphhl$B$Y = 0.17:0.17:0.17,
     tpllh$C$Y = 0.12:0.12:0.12,
     tphhl$C$Y = 0.12:0.12:0.12,
     tpllh$S0$Y = 0.16:0.16:0.16,
     tplhl$S0$Y = 0.18:0.18:0.18,
     tphlh$S0$Y = 0.18:0.18:0.18,
     tphhl$S0$Y = 0.16:0.16:0.16,
     tpllh$S1$Y = 0.11:0.11:0.11,
     tplhl$S1$Y = 0.13:0.13:0.13,
     tphlh$S1$Y = 0.13:0.13:0.13,
     tphhl$S1$Y = 0.12:0.12:0.12;

      // path delays
      (posedge S1 *> (Y +: C)) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: S0?B:A)) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: S1?C:B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: S1?C:A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND2X2 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.052:0.052:0.052,
     tphlh$A$Y = 0.029:0.029:0.029,
     tplhl$B$Y = 0.05:0.05:0.05,
     tphlh$B$Y = 0.029:0.029:0.029;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND2X8 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.024:0.024:0.024,
     tphlh$A$Y = 0.014:0.014:0.014,
     tplhl$B$Y = 0.022:0.022:0.022,
     tphlh$B$Y = 0.013:0.013:0.013;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND3BX1 (AN, B, C, Y);
   input  AN ;
   input  B ;
   input  C ;
   output Y ;

   not (I0_out, AN);
   and (I2_out, I0_out, B, C);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.069:0.069:0.069,
     tphhl$AN$Y = 0.15:0.15:0.15,
     tplhl$B$Y = 0.14:0.14:0.14,
     tphlh$B$Y = 0.052:0.052:0.052,
     tplhl$C$Y = 0.13:0.13:0.13,
     tphlh$C$Y = 0.05:0.05:0.05;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND3X8 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.04:0.04:0.04,
     tphlh$A$Y = 0.016:0.016:0.016,
     tplhl$B$Y = 0.038:0.038:0.038,
     tphlh$B$Y = 0.015:0.015:0.015,
     tplhl$C$Y = 0.033:0.033:0.033,
     tphlh$C$Y = 0.014:0.014:0.014;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4BX2 (AN, B, C, D, Y);
   input  AN ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   and (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.058:0.058:0.058,
     tphhl$AN$Y = 0.15:0.15:0.15,
     tplhl$B$Y = 0.12:0.12:0.12,
     tphlh$B$Y = 0.035:0.035:0.035,
     tplhl$C$Y = 0.12:0.12:0.12,
     tphlh$C$Y = 0.033:0.033:0.033,
     tplhl$D$Y = 0.11:0.11:0.11,
     tphlh$D$Y = 0.031:0.031:0.031;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4BXL (AN, B, C, D, Y);
   input  AN ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   and (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.1:0.1:0.1,
     tphhl$AN$Y = 0.3:0.3:0.3,
     tplhl$B$Y = 0.29:0.29:0.29,
     tphlh$B$Y = 0.085:0.085:0.085,
     tplhl$C$Y = 0.28:0.28:0.28,
     tphlh$C$Y = 0.084:0.084:0.084,
     tplhl$D$Y = 0.28:0.28:0.28,
     tphlh$D$Y = 0.082:0.082:0.082;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4X1 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.19:0.19:0.19,
     tphlh$A$Y = 0.054:0.054:0.054,
     tplhl$B$Y = 0.19:0.19:0.19,
     tphlh$B$Y = 0.054:0.054:0.054,
     tplhl$C$Y = 0.18:0.18:0.18,
     tphlh$C$Y = 0.053:0.053:0.053,
     tplhl$D$Y = 0.17:0.17:0.17,
     tphlh$D$Y = 0.051:0.051:0.051;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4XL (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.29:0.29:0.29,
     tphlh$A$Y = 0.087:0.087:0.087,
     tplhl$B$Y = 0.29:0.29:0.29,
     tphlh$B$Y = 0.085:0.085:0.085,
     tplhl$C$Y = 0.28:0.28:0.28,
     tphlh$C$Y = 0.084:0.084:0.084,
     tplhl$D$Y = 0.28:0.28:0.28,
     tphlh$D$Y = 0.082:0.082:0.082;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR3BX4 (AN, B, C, Y);
   input  AN ;
   input  B ;
   input  C ;
   output Y ;

   not (I0_out, AN);
   or  (I2_out, I0_out, B, C);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.083:0.083:0.083,
     tphhl$AN$Y = 0.053:0.053:0.053,
     tplhl$B$Y = 0.021:0.021:0.021,
     tphlh$B$Y = 0.053:0.053:0.053,
     tplhl$C$Y = 0.019:0.019:0.019,
     tphlh$C$Y = 0.046:0.046:0.046;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR3X2 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.033:0.033:0.033,
     tphlh$A$Y = 0.083:0.083:0.083,
     tplhl$B$Y = 0.031:0.031:0.031,
     tphlh$B$Y = 0.081:0.081:0.081,
     tplhl$C$Y = 0.029:0.029:0.029,
     tphlh$C$Y = 0.074:0.074:0.074;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4X1 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.057:0.057:0.057,
     tphlh$A$Y = 0.19:0.19:0.19,
     tplhl$B$Y = 0.055:0.055:0.055,
     tphlh$B$Y = 0.19:0.19:0.19,
     tplhl$C$Y = 0.053:0.053:0.053,
     tphlh$C$Y = 0.19:0.19:0.19,
     tplhl$D$Y = 0.051:0.051:0.051,
     tphlh$D$Y = 0.17:0.17:0.17;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4XL (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.086:0.086:0.086,
     tphlh$A$Y = 0.31:0.31:0.31,
     tplhl$B$Y = 0.085:0.085:0.085,
     tphlh$B$Y = 0.31:0.31:0.31,
     tplhl$C$Y = 0.082:0.082:0.082,
     tphlh$C$Y = 0.3:0.3:0.3,
     tplhl$D$Y = 0.08:0.08:0.08,
     tphlh$D$Y = 0.29:0.29:0.29;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OA21X2 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (Y, I0_out, B0);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.085:0.085:0.085,
     tphhl$A0$Y = 0.09:0.09:0.09,
     tpllh$A1$Y = 0.08:0.08:0.08,
     tphhl$A1$Y = 0.086:0.086:0.086,
     tpllh$B0$Y = 0.062:0.071:0.079,
     tphhl$B0$Y = 0.055:0.056:0.058;

      // path delays
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OA21XL (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (Y, I0_out, B0);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.12:0.12:0.12,
     tphhl$A0$Y = 0.12:0.12:0.12,
     tpllh$A1$Y = 0.11:0.11:0.11,
     tphhl$A1$Y = 0.12:0.12:0.12,
     tpllh$B0$Y = 0.099:0.11:0.11,
     tphhl$B0$Y = 0.092:0.094:0.095;

      // path delays
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI21X2 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (I1_out, I0_out, B0);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.059:0.059:0.059,
     tphlh$A0$Y = 0.058:0.058:0.058,
     tplhl$A1$Y = 0.056:0.056:0.056,
     tphlh$A1$Y = 0.055:0.055:0.055,
     tplhl$B0$Y = 0.039:0.047:0.054,
     tphlh$B0$Y = 0.028:0.028:0.028;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI221X1 (A0, A1, B0, B1, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.13:0.15:0.16,
     tphlh$A0$Y = 0.11:0.11:0.11,
     tplhl$A1$Y = 0.13:0.14:0.16,
     tphlh$A1$Y = 0.1:0.1:0.11,
     tplhl$B0$Y = 0.13:0.14:0.16,
     tphlh$B0$Y = 0.1:0.1:0.1,
     tplhl$B1$Y = 0.12:0.14:0.15,
     tphlh$B1$Y = 0.099:0.099:0.099,
     tplhl$C0$Y = 0.09:0.12:0.15,
     tphlh$C0$Y = 0.05:0.05:0.051;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI22XL (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   or  (I1_out, A0, A1);
   and (I2_out, I0_out, I1_out);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.13:0.14:0.16,
     tphlh$A0$Y = 0.16:0.16:0.16,
     tplhl$A1$Y = 0.12:0.14:0.16,
     tphlh$A1$Y = 0.16:0.16:0.16,
     tplhl$B0$Y = 0.11:0.13:0.15,
     tphlh$B0$Y = 0.15:0.15:0.15,
     tplhl$B1$Y = 0.11:0.13:0.15,
     tphlh$B1$Y = 0.15:0.15:0.15;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI2BB1XL (A0N, A1N, B0, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   output Y ;

   and (I0_out, A0N, A1N);
   not (I1_out, I0_out);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.11:0.11:0.11,
     tphhl$A0N$Y = 0.16:0.16:0.16,
     tpllh$A1N$Y = 0.11:0.11:0.11,
     tphhl$A1N$Y = 0.16:0.16:0.16,
     tplhl$B0$Y = 0.14:0.14:0.14,
     tphlh$B0$Y = 0.081:0.081:0.081;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI2BB2X2 (A0N, A1N, B0, B1, Y);
   input  A0N ;
   input  A1N ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   and (I1_out, A0N, A1N);
   not (I2_out, I1_out);
   and (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$A0N$Y = 0.089:0.09:0.09,
     tphhl$A0N$Y = 0.079:0.087:0.095,
     tpllh$A1N$Y = 0.086:0.087:0.087,
     tphhl$A1N$Y = 0.079:0.086:0.094,
     tplhl$B0$Y = 0.043:0.052:0.061,
     tphlh$B0$Y = 0.055:0.055:0.056,
     tplhl$B1$Y = 0.041:0.05:0.058,
     tphlh$B1$Y = 0.052:0.052:0.052;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1N *> Y) = (tpllh$A1N$Y, tphhl$A1N$Y);
      (A0N *> Y) = (tpllh$A0N$Y, tphhl$A0N$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI31X2 (A0, A1, A2, B0, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   output Y ;

   or  (I1_out, A0, A1, A2);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.065:0.065:0.065,
     tphlh$A0$Y = 0.093:0.093:0.093,
     tplhl$A1$Y = 0.062:0.062:0.062,
     tphlh$A1$Y = 0.09:0.09:0.09,
     tplhl$A2$Y = 0.059:0.059:0.059,
     tphlh$A2$Y = 0.083:0.083:0.083,
     tplhl$B0$Y = 0.035:0.047:0.059,
     tphlh$B0$Y = 0.028:0.028:0.028;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI32X2 (A0, A1, A2, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   or  (I2_out, A0, A1, A2);
   and (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.056:0.065:0.073,
     tphlh$A0$Y = 0.097:0.099:0.1,
     tplhl$A1$Y = 0.053:0.062:0.07,
     tphlh$A1$Y = 0.094:0.096:0.097,
     tplhl$A2$Y = 0.051:0.058:0.066,
     tphlh$A2$Y = 0.087:0.089:0.09,
     tplhl$B0$Y = 0.039:0.052:0.065,
     tphlh$B0$Y = 0.055:0.055:0.055,
     tplhl$B1$Y = 0.037:0.049:0.062,
     tphlh$B1$Y = 0.052:0.052:0.052;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI33X4 (A0, A1, A2, B0, B1, B2, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   input  B2 ;
   output Y ;

   or  (I1_out, B0, B1, B2);
   or  (I3_out, A0, A1, A2);
   and (I4_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.041:0.053:0.066,
     tphlh$A0$Y = 0.077:0.079:0.082,
     tplhl$A1$Y = 0.038:0.049:0.061,
     tphlh$A1$Y = 0.072:0.075:0.077,
     tplhl$A2$Y = 0.034:0.045:0.055,
     tphlh$A2$Y = 0.064:0.066:0.069,
     tplhl$B0$Y = 0.031:0.044:0.056,
     tphlh$B0$Y = 0.063:0.063:0.063,
     tplhl$B1$Y = 0.028:0.04:0.051,
     tphlh$B1$Y = 0.058:0.058:0.059,
     tplhl$B2$Y = 0.025:0.035:0.045,
     tphlh$B2$Y = 0.049:0.05:0.05;

      // path delays
      (B2 *> Y) = (tphlh$B2$Y, tplhl$B2$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR4X1 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.077:0.077:0.077,
     tphhl$A$Y = 0.15:0.15:0.15,
     tpllh$B$Y = 0.075:0.075:0.075,
     tphhl$B$Y = 0.15:0.15:0.15,
     tpllh$C$Y = 0.073:0.073:0.073,
     tphhl$C$Y = 0.14:0.14:0.14,
     tpllh$D$Y = 0.071:0.071:0.071,
     tphhl$D$Y = 0.13:0.13:0.13;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFHQX4 (CK, D, Q, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I5_out, SI);
   not (I7_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I7_out);
   not (I9_out, D);
   not (I10_out, SE);
   not (I12_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.1:0.1:0.1,
     tplhl$CK$Q = 0.12:0.12:0.12,
     tminpwh$CK = 0.054:0.12:0.12,
     tminpwl$CK = 0.052:0.095:0.095,
     tsetup_negedge$D$CK = 0.044:0.044:0.044,
     thold_negedge$D$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_negedge$SE$CK = 0.081:0.081:0.081,
     thold_negedge$SE$CK = -0.05:-0.05:-0.05,


     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$D$CK = 0.069:0.069:0.069,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.056:0.056:0.056,
     thold_posedge$SE$CK = -0.013:-0.013:-0.013,


     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFNSRX1 (CKN, D, Q, QN, RN, SE, SI, SN);
   input  CKN ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   not (I14_out, SE);
   not (I16_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I13_out, I14_out, I16_out);
   not (I18_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I18_out, SN);
   not (I21_out, D);
   not (I23_out, SE);
   not (I25_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I21_out, RN, I23_out, I25_out, SN);
   not (I28_out, D);
   not (I29_out, SE);
   not (I31_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I28_out, I29_out, I31_out, SN);
   not (I34_out, D);
   not (I35_out, RN);
   not (I37_out, SE);
   not (I39_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I34_out, I35_out, I37_out, I39_out);

    specify
      // delay parameters
      specparam
	tphlh$CKN$Q = 0.17:0.17:0.17,
     tphhl$CKN$Q = 0.15:0.15:0.15,
     tphlh$CKN$QN = 0.16:0.16:0.16,
     tphhl$CKN$QN = 0.18:0.18:0.18,
     tphhl$RN$Q = 0.19:0.2:0.2,
     tphlh$RN$QN = 0.21:0.21:0.22,
     tplhl$SN$Q = 0.18:0.18:0.19,
     tphlh$SN$Q = 0.14:0.14:0.15,
     tpllh$SN$QN = 0.19:0.19:0.2,
     tphhl$SN$QN = 0.16:0.16:0.16,
     tminpwh$CKN = 0.047:0.11:0.11,
     tminpwl$CKN = 0.05:0.16:0.16,
     tminpwl$RN = 0.06:0.22:0.22,
     tminpwl$SN = 0.02:0.16:0.16,
     tsetup_negedge$D$CKN = 0.12:0.12:0.12,
     thold_negedge$D$CKN = -0.062:-0.062:-0.062,
     tsetup_negedge$SE$CKN = 0.11:0.12:0.12,
     thold_negedge$SE$CKN = -0.056:-0.031:-0.031,
     tsetup_negedge$SI$CKN = 0.12:0.12:0.12,
     thold_negedge$SI$CKN = -0.063:-0.063:-0.063,
     tsetup_posedge$D$CKN = 0.1:0.1:0.1,
     thold_posedge$D$CKN = -0.019:-0.019:-0.019,
     tsetup_posedge$SE$CKN = 0.094:0.14:0.14,
     thold_posedge$SE$CKN = -0.075:-0.012:-0.012,
     tsetup_posedge$SI$CKN = 0.1:0.1:0.1,
     thold_posedge$SI$CKN = -0.019:-0.019:-0.019,
     trec$RN$CKN = 0.044:0.044:0.044,
     trem$RN$CKN = -0.000000000056:-0.000000000056:-0.000000000056,
     trec$RN$SN = 0.069:0.075:0.075,
     trec$SN$CKN = 0.038:0.038:0.038,
     trem$SN$CKN = 0.012:0.012:0.012;

      // path delays
      (negedge CKN *> (QN -: SE?SI:D)) = (tphlh$CKN$QN, tphhl$CKN$QN);
      (negedge CKN *> (Q +: SE?SI:D)) = (tphlh$CKN$Q, tphhl$CKN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
      $setup(negedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CKN,  NOTIFIER);
      $setup(negedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CKN,  NOTIFIER);
      $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
      $setup(posedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CKN,  NOTIFIER);
      $setup(posedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CKN,  NOTIFIER);
      $recovery(posedge RN, negedge CKN &&& SN == 1'b1, trec$RN$CKN, NOTIFIER);
      $removal (posedge RN, negedge CKN &&& SN == 1'b1, trem$RN$CKN, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, negedge CKN &&& RN == 1'b1, trec$SN$CKN, NOTIFIER);
      $removal (posedge SN, negedge CKN &&& RN == 1'b1, trem$SN$CKN, NOTIFIER);
      $width(posedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CKN, 0, NOTIFIER);
      $width(negedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CKN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFNSRX4 (CKN, D, Q, QN, RN, SE, SI, SN);
   input  CKN ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLOCK, CKN);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, I0_CLOCK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   not (I14_out, SE);
   not (I16_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I13_out, I14_out, I16_out);
   not (I18_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I18_out, SN);
   not (I21_out, D);
   not (I23_out, SE);
   not (I25_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I21_out, RN, I23_out, I25_out, SN);
   not (I28_out, D);
   not (I29_out, SE);
   not (I31_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I28_out, I29_out, I31_out, SN);
   not (I34_out, D);
   not (I35_out, RN);
   not (I37_out, SE);
   not (I39_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I34_out, I35_out, I37_out, I39_out);

    specify
      // delay parameters
      specparam
	tphlh$CKN$Q = 0.16:0.16:0.16,
     tphhl$CKN$Q = 0.14:0.14:0.14,
     tphlh$CKN$QN = 0.17:0.17:0.17,
     tphhl$CKN$QN = 0.18:0.18:0.18,
     tphhl$RN$Q = 0.17:0.18:0.19,
     tphlh$RN$QN = 0.2:0.2:0.21,
     tplhl$SN$Q = 0.15:0.16:0.17,
     tphlh$SN$Q = 0.12:0.12:0.12,
     tpllh$SN$QN = 0.18:0.19:0.2,
     tphhl$SN$QN = 0.15:0.15:0.15,
     tminpwh$CKN = 0.063:0.13:0.13,
     tminpwl$CKN = 0.071:0.17:0.17,
     tminpwl$RN = 0.064:0.21:0.21,
     tminpwl$SN = 0.024:0.15:0.15,
     tsetup_negedge$D$CKN = 0.13:0.13:0.13,
     thold_negedge$D$CKN = -0.056:-0.056:-0.056,
     tsetup_negedge$SE$CKN = 0.11:0.12:0.12,
     thold_negedge$SE$CKN = -0.05:-0.019:-0.019,
     tsetup_negedge$SI$CKN = 0.13:0.13:0.13,
     thold_negedge$SI$CKN = -0.056:-0.056:-0.056,
     tsetup_posedge$D$CKN = 0.11:0.11:0.11,
     thold_posedge$D$CKN = -0.013:-0.013:-0.013,
     tsetup_posedge$SE$CKN = 0.1:0.14:0.14,
     thold_posedge$SE$CKN = -0.062:-0.00000000015:-0.00000000015,
     tsetup_posedge$SI$CKN = 0.11:0.11:0.11,
     thold_posedge$SI$CKN = -0.0062:-0.0062:-0.0062,
     trec$RN$CKN = 0.044:0.044:0.044,
     trem$RN$CKN = 0.0063:0.0063:0.0063,
     trec$RN$SN = 0.087:0.087:0.087,
     trec$SN$CKN = 0.05:0.05:0.05,
     trem$SN$CKN = 0.012:0.012:0.012;

      // path delays
      (negedge CKN *> (QN -: SE?SI:D)) = (tphlh$CKN$QN, tphhl$CKN$QN);
      (negedge CKN *> (Q +: SE?SI:D)) = (tphlh$CKN$Q, tphhl$CKN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CKN,  NOTIFIER);
      $setup(negedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CKN,  NOTIFIER);
      $setup(negedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CKN,  NOTIFIER);
      $setup(posedge D, negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CKN,  NOTIFIER);
      $setup(posedge SE, negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CKN,  NOTIFIER);
      $setup(posedge SI, negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CKN, NOTIFIER);
      $hold (negedge CKN &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CKN,  NOTIFIER);
      $recovery(posedge RN, negedge CKN &&& SN == 1'b1, trec$RN$CKN, NOTIFIER);
      $removal (posedge RN, negedge CKN &&& SN == 1'b1, trem$RN$CKN, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, negedge CKN &&& RN == 1'b1, trec$SN$CKN, NOTIFIER);
      $removal (posedge SN, negedge CKN &&& RN == 1'b1, trem$SN$CKN, NOTIFIER);
      $width(posedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CKN, 0, NOTIFIER);
      $width(negedge CKN &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CKN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFRHQX2 (CK, D, Q, RN, SE, SI);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   udp_dff (N30, I0_D, CK, I0_CLEAR, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1, RN, SE);
   not (I7_out, D);
   and (D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1, I7_out, SE, SI);
   not (I10_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I10_out);
   not (I12_out, D);
   not (I14_out, SE);
   not (I16_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0, I12_out, RN, I14_out, I16_out);
   not (I18_out, D);
   not (I19_out, SE);
   not (I21_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I18_out, I19_out, I21_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tphhl$RN$Q = 0.06:0.06:0.06,
     tminpwh$CK = 0.052:0.14:0.14,
     tminpwl$CK = 0.054:0.097:0.097,
     tminpwl$RN = 0.022:0.08:0.08,
     tsetup_negedge$D$CK = 0.044:0.044:0.044,
     thold_negedge$D$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_negedge$SE$CK = 0.038:0.087:0.087,
     thold_negedge$SE$CK = -0.056:0.0062:0.0062,
     tsetup_negedge$SI$CK = 0.044:0.044:0.044,
     thold_negedge$SI$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.056:0.069:0.069,
     thold_posedge$SE$CK = -0.037:-0.012:-0.012,
     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$RN$CK = -0.038:-0.038:-0.038,
     trem$RN$CK = 0.056:0.056:0.056;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_0_AN_SE_EQ_1_AN_SI_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$RN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSHQX4 (CK, D, Q, SE, SI, SN);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N30, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D);
   not (I7_out, SE);
   not (I9_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I6_out, I7_out, I9_out);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I12_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I12_out, SN);
   not (I14_out, D);
   not (I15_out, SE);
   not (I17_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I14_out, I15_out, I17_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tphlh$SN$Q = 0.092:0.093:0.093,
     tminpwh$CK = 0.059:0.14:0.14,
     tminpwl$CK = 0.056:0.11:0.11,
     tminpwl$SN = 0.015:0.093:0.093,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = -0.0063:-0.0063:-0.0063,
     tsetup_negedge$SE$CK = 0.056:0.094:0.094,
     thold_negedge$SE$CK = -0.056:0.0062:0.0062,
     tsetup_negedge$SI$CK = 0.069:0.069:0.069,
     thold_negedge$SI$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.069:0.081:0.081,
     thold_posedge$SE$CK = -0.037:-0.019:-0.019,
     tsetup_posedge$SI$CK = 0.075:0.075:0.075,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$SN$CK = -0.0063:-0.0063:-0.0063,
     trem$SN$CK = 0.044:0.044:0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSHQX8 (CK, D, Q, SE, SI, SN);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N30, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D);
   not (I7_out, SE);
   not (I9_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I6_out, I7_out, I9_out);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I12_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I12_out, SN);
   not (I14_out, D);
   not (I15_out, SE);
   not (I17_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I14_out, I15_out, I17_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tphlh$SN$Q = 0.098:0.099:0.1,
     tminpwh$CK = 0.068:0.14:0.14,
     tminpwl$CK = 0.057:0.11:0.11,
     tminpwl$SN = 0.016:0.1:0.1,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = -0.0062:-0.0062:-0.0062,
     tsetup_negedge$SE$CK = 0.062:0.094:0.094,
     thold_negedge$SE$CK = -0.056:0.000000000027:0.000000000027,
     tsetup_negedge$SI$CK = 0.069:0.069:0.069,
     thold_negedge$SI$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$D$CK = 0.075:0.075:0.075,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.069:0.081:0.081,
     thold_posedge$SE$CK = -0.037:-0.019:-0.019,
     tsetup_posedge$SI$CK = 0.075:0.075:0.075,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$SN$CK = 0:0:0,
     trem$SN$CK = 0.037:0.037:0.037;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSRHQX8 (CK, D, Q, RN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, D);
   not (I11_out, SE);
   not (I13_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I10_out, I11_out, I13_out);
   not (I15_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I15_out, SN);
   not (I18_out, D);
   not (I20_out, SE);
   not (I22_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I18_out, RN, I20_out, I22_out, SN);
   not (I25_out, D);
   not (I26_out, SE);
   not (I28_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I25_out, I26_out, I28_out, SN);
   not (I31_out, D);
   not (I32_out, RN);
   not (I34_out, SE);
   not (I36_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I31_out, I32_out, I34_out, I36_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tphhl$RN$Q = 0.17:0.18:0.18,
     tplhl$SN$Q = 0.15:0.16:0.16,
     tphlh$SN$Q = 0.11:0.11:0.12,
     tminpwh$CK = 0.084:0.16:0.16,
     tminpwl$CK = 0.06:0.12:0.12,
     tminpwl$RN = 0.062:0.18:0.18,
     tminpwl$SN = 0.019:0.12:0.12,
     tsetup_negedge$D$CK = 0.069:0.069:0.069,
     thold_negedge$D$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_negedge$SE$CK = 0.063:0.11:0.11,
     thold_negedge$SE$CK = -0.056:0.0062:0.0062,
     tsetup_negedge$SI$CK = 0.075:0.075:0.075,
     thold_negedge$SI$CK = -0.000000000099:-0.000000000099:-0.000000000099,
     tsetup_posedge$D$CK = 0.1:0.1:0.1,
     thold_posedge$D$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$SE$CK = 0.081:0.094:0.094,
     thold_posedge$SE$CK = -0.038:-0.013:-0.013,
     tsetup_posedge$SI$CK = 0.1:0.1:0.1,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044,
     trec$RN$CK = 0.062:0.062:0.062,
     trem$RN$CK = -0.012:-0.012:-0.012,
     trec$RN$SN = 0.081:0.094:0.094,
     trec$SN$CK = 0.0062:0.0062:0.0062,
     trem$SN$CK = 0.038:0.038:0.038;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFTRX1 (CK, D, E, Q, QN, RN, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  RN ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, QBINT);
   not (I5_out, I4_out);
   and (I7_out, I2_out, I5_out, RN);
   udp_mux2 (I0_D, I7_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I15_out, D);
   not (I16_out, E);
   not (I18_out, RN);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1, I15_out, I16_out, I18_out, SI);
   not (I21_out, D);
   not (I22_out, E);
   not (I25_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0, I21_out, I22_out, RN, I25_out);
   not (I29_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0, D, E, RN, I29_out);
   not (I31_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0, RN, I31_out);
   not (I34_out, SE);
   and (E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0, E, RN, I34_out);
   not (I36_out, D);
   not (I37_out, E);
   not (I39_out, RN);
   not (I41_out, SE);
   not (I43_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I36_out, I37_out, I39_out, I41_out, I43_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.15:0.15:0.15,
     tplhl$CK$Q = 0.17:0.17:0.17,
     tpllh$CK$QN = 0.18:0.18:0.18,
     tplhl$CK$QN = 0.17:0.17:0.17,
     tminpwh$CK = 0.044:0.18:0.18,
     tminpwl$CK = 0.045:0.089:0.089,
     tsetup_negedge$D$CK = 0.13:0.13:0.13,
     thold_negedge$D$CK = -0.081:-0.081:-0.081,
     tsetup_negedge$E$CK = 0.12:0.13:0.13,
     thold_negedge$E$CK = -0.12:-0.094:-0.094,
     tsetup_negedge$RN$CK = 0.12:0.12:0.12,
     thold_negedge$RN$CK = -0.075:-0.075:-0.075,
     tsetup_negedge$SE$CK = 0.11:0.11:0.11,
     thold_negedge$SE$CK = -0.075:-0.075:-0.075,


     tsetup_negedge$SI$CK = 0.075:0.075:0.075,
     thold_negedge$SI$CK = -0.025:-0.025:-0.025,
     tsetup_posedge$D$CK = 0.17:0.17:0.17,
     thold_posedge$D$CK = -0.12:-0.12:-0.12,
     tsetup_posedge$E$CK = 0.12:0.19:0.19,
     thold_posedge$E$CK = -0.17:-0.1:-0.1,
     tsetup_posedge$RN$CK = 0.21:0.21:0.21,
     thold_posedge$RN$CK = -0.17:-0.17:-0.17,
     tsetup_posedge$SE$CK = 0.087:0.087:0.087,
     thold_posedge$SE$CK = -0.037:-0.037:-0.037,


     tsetup_posedge$SI$CK = 0.088:0.088:0.088,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056;

      // path delays
      (posedge CK *> (QN -: SE?SI:(RN&(!(QBINT&!E)&!(E&!D))))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(RN&(!(QBINT&!E)&!(E&!D))))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& SE == 1'b0, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0 == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& SE == 1'b0, tsetup_posedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_RN_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFX1 (CK, D, E, Q, QN, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, NET536);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (NET536, N30);
   not (Q, NET536);
   buf (QN, NET536);
   not (I9_out, D);
   not (I10_out, E);
   not (I12_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);
   not (I14_out, D);
   not (I15_out, E);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1, I14_out, I15_out, SI);
   not (I18_out, D);
   and (D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1, I18_out, E, SI);
   not (I22_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0, D, E, I22_out);
   not (I24_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I24_out);
   not (I26_out, D);
   not (I27_out, E);
   not (I30_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0, I26_out, I27_out, SE, I30_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tpllh$CK$QN = 0.18:0.18:0.18,
     tplhl$CK$QN = 0.16:0.16:0.16,
     tminpwh$CK = 0.046:0.18:0.18,
     tminpwl$CK = 0.048:0.094:0.094,
     tsetup_negedge$D$CK = 0.13:0.13:0.13,
     thold_negedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_negedge$E$CK = 0.094:0.13:0.13,
     thold_negedge$E$CK = -0.12:-0.044:-0.044,
     thold_negedge$SE$CK = -0.019:-0.019:-0.019,

     tsetup_negedge$SE$CK = 0.11:0.11:0.11,

     tsetup_negedge$SI$CK = 0.075:0.075:0.075,
     thold_negedge$SI$CK = -0.025:-0.025:-0.025,
     tsetup_posedge$D$CK = 0.16:0.16:0.16,
     thold_posedge$D$CK = -0.11:-0.11:-0.11,
     tsetup_posedge$E$CK = 0.14:0.15:0.15,
     thold_posedge$E$CK = -0.12:-0.12:-0.12,
     tsetup_posedge$SE$CK = 0.087:0.087:0.087,

     thold_posedge$SE$CK = -0.038:-0.038:-0.038,

     tsetup_posedge$SI$CK = 0.094:0.094:0.094,
     thold_posedge$SI$CK = -0.062:-0.062:-0.062;

      // path delays
      (posedge CK *> (QN -: SE?SI:(E?D:!NET536))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(E?D:!NET536))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TBUFX2 (A, OE, Y);
   input  A ;
   input  OE ;
   output Y ;

   bufif1 (Y, A, OE);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.069:0.069:0.069,
     tphhl$A$Y = 0.062:0.062:0.062,
     tpzh$OE$Y = 0.067:0.067:0.067,
     tpzl$OE$Y = 0.069:0.069:0.069,
     tplz$OE$Y = 0.032:0.032:0.032,
     tphz$OE$Y = 0.025:0.025:0.025;

      // path delays
      (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNCAX4 (CK, E, ECK);
   input  CK ;
   input  E ;
   output ECK ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (EINT, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, EINT);
   and (ECK, CK, EINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.11:0.11:0.11,
     tphhl$CK$ECK = 0.091:0.091:0.091,
     tminpwl$CK = 0.071:0.1:0.1,
     tsetup_negedge$E$CK = 0.012:0.012:0.012,
     thold_negedge$E$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$E$CK = 0.038:0.038:0.038,
     thold_posedge$E$CK = -0.031:-0.031:-0.031;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(negedge CK &&& E == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNX1 (D, GN, Q, QN);
   input  D ;
   input  GN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, GN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, QINT);
   buf (Q, QINT);
   not (QN, QINT);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.13:0.13:0.13,
     tphhl$D$Q = 0.13:0.13:0.13,
     tplhl$D$QN = 0.12:0.12:0.12,
     tphlh$D$QN = 0.12:0.12:0.12,
     tphlh$GN$Q = 0.15:0.15:0.15,
     tphhl$GN$Q = 0.17:0.17:0.17,
     tphlh$GN$QN = 0.16:0.16:0.16,
     tphhl$GN$QN = 0.14:0.14:0.14,
     tminpwl$GN = 0.047:0.17:0.17,
     tsetup_negedge$D$GN = 0.025:0.025:0.025,
     thold_negedge$D$GN = -0.012:-0.012:-0.012,
     tsetup_posedge$D$GN = 0.044:0.044:0.044,
     thold_posedge$D$GN = -0.031:-0.031:-0.031;

      // path delays
      (negedge GN *> (QN -: D)) = (tphlh$GN$QN, tphhl$GN$QN);
      (negedge GN *> (Q +: D)) = (tphlh$GN$Q, tphhl$GN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, posedge GN, tsetup_negedge$D$GN, NOTIFIER);
      $hold (posedge GN, negedge D, thold_negedge$D$GN,  NOTIFIER);
      $setup(posedge D, posedge GN, tsetup_posedge$D$GN, NOTIFIER);
      $hold (posedge GN, posedge D, thold_posedge$D$GN,  NOTIFIER);
      $width(negedge GN &&& D == 1'b0, tminpwl$GN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATX4 (D, G, Q, QN);
   input  D ;
   input  G ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_tlat (QINT, D, G, 1'B0, 1'B0, NOTIFIER);
   not (N0, QINT);
   buf (Q, QINT);
   not (QN, QINT);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.11:0.11:0.11,
     tphhl$D$Q = 0.12:0.12:0.12,
     tplhl$D$QN = 0.1:0.1:0.1,
     tphlh$D$QN = 0.11:0.11:0.11,
     tpllh$G$Q = 0.15:0.15:0.15,
     tplhl$G$Q = 0.14:0.14:0.14,
     tpllh$G$QN = 0.13:0.13:0.13,
     tplhl$G$QN = 0.14:0.14:0.14,
     tminpwh$G = 0.058:0.14:0.14,
     tsetup_negedge$D$G = 0.056:0.056:0.056,
     thold_negedge$D$G = -0.044:-0.044:-0.044,
     tsetup_posedge$D$G = 0.037:0.037:0.037,
     thold_posedge$D$G = -0.019:-0.019:-0.019;

      // path delays
      (posedge G *> (QN -: D)) = (tpllh$G$QN, tplhl$G$QN);
      (posedge G *> (Q +: D)) = (tpllh$G$Q, tplhl$G$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, negedge G, tsetup_negedge$D$G, NOTIFIER);
      $hold (negedge G, negedge D, thold_negedge$D$G,  NOTIFIER);
      $setup(posedge D, negedge G, tsetup_posedge$D$G, NOTIFIER);
      $hold (negedge G, posedge D, thold_posedge$D$G,  NOTIFIER);
      $width(posedge G &&& D == 1'b0, tminpwh$G, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDFHX1 (A, B, CI, CO, S);
   input  A ;
   input  B ;
   input  CI ;
   output CO ;
   output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.096:0.11:0.12,
     tplhl$A$S = 0.15:0.15:0.15,
     tphlh$A$S = 0.15:0.15:0.15,
     tphhl$A$S = 0.099:0.11:0.12,
     tpllh$A$CO = 0.11:0.11:0.11,
     tphhl$A$CO = 0.11:0.12:0.12,
     tpllh$B$S = 0.093:0.1:0.12,
     tplhl$B$S = 0.14:0.15:0.15,
     tphlh$B$S = 0.14:0.15:0.15,
     tphhl$B$S = 0.097:0.11:0.12,
     tpllh$B$CO = 0.11:0.11:0.11,
     tphhl$B$CO = 0.11:0.11:0.11,
     tpllh$CI$S = 0.092:0.1:0.12,
     tplhl$CI$S = 0.14:0.14:0.14,
     tphlh$CI$S = 0.14:0.14:0.14,
     tphhl$CI$S = 0.099:0.11:0.11,
     tpllh$CI$CO = 0.1:0.1:0.11,
     tphhl$CI$CO = 0.11:0.11:0.11;

      // path delays
      (posedge CI *> (S +: !(B^A))) = (tpllh$CI$S, tplhl$CI$S);
      (negedge CI *> (S +: B^A)) = (tphlh$CI$S, tphhl$CI$S);
      (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
      (posedge B *> (S +: CI^!A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: CI^A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: CI^!B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: CI^B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDFX1 (A, B, CI, CO, S);
   input  A ;
   input  B ;
   input  CI ;
   output CO ;
   output S ;

   and (I0_out, A, B);
   and (I1_out, B, CI);
   and (I3_out, CI, A);
   or  (CO, I0_out, I1_out, I3_out);
   xor (I5_out, A, B);
   xor (S, I5_out, CI);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.11:0.12:0.13,
     tplhl$A$S = 0.17:0.17:0.17,
     tphlh$A$S = 0.17:0.17:0.17,
     tphhl$A$S = 0.11:0.12:0.14,
     tpllh$A$CO = 0.12:0.12:0.12,
     tphhl$A$CO = 0.13:0.13:0.13,
     tpllh$B$S = 0.1:0.12:0.13,
     tplhl$B$S = 0.16:0.17:0.17,
     tphlh$B$S = 0.16:0.17:0.17,
     tphhl$B$S = 0.11:0.12:0.13,
     tpllh$B$CO = 0.12:0.12:0.12,
     tphhl$B$CO = 0.13:0.13:0.13,
     tpllh$CI$S = 0.1:0.12:0.13,
     tplhl$CI$S = 0.16:0.16:0.16,
     tphlh$CI$S = 0.16:0.16:0.16,
     tphhl$CI$S = 0.11:0.12:0.13,
     tpllh$CI$CO = 0.11:0.11:0.12,
     tphhl$CI$CO = 0.12:0.12:0.12;

      // path delays
      (posedge CI *> (S +: !(B^A))) = (tpllh$CI$S, tplhl$CI$S);
      (negedge CI *> (S +: B^A)) = (tphlh$CI$S, tphhl$CI$S);
      (CI *> CO) = (tpllh$CI$CO, tphhl$CI$CO);
      (posedge B *> (S +: CI^!A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: CI^A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: CI^!B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: CI^B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module ADDHX4 (A, B, CO, S);
   input  A ;
   input  B ;
   output CO ;
   output S ;

   and (CO, A, B);
   xor (S, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$S = 0.096:0.096:0.096,
     tplhl$A$S = 0.099:0.099:0.099,
     tphlh$A$S = 0.096:0.096:0.096,
     tphhl$A$S = 0.1:0.1:0.1,
     tpllh$A$CO = 0.063:0.063:0.063,
     tphhl$A$CO = 0.045:0.045:0.045,
     tpllh$B$S = 0.065:0.065:0.065,
     tplhl$B$S = 0.09:0.09:0.09,
     tphlh$B$S = 0.082:0.082:0.082,
     tphhl$B$S = 0.079:0.079:0.079,
     tpllh$B$CO = 0.061:0.061:0.061,
     tphhl$B$CO = 0.044:0.044:0.044;

      // path delays
      (posedge B *> (S +: !A)) = (tpllh$B$S, tplhl$B$S);
      (negedge B *> (S +: A)) = (tphlh$B$S, tphhl$B$S);
      (B *> CO) = (tpllh$B$CO, tphhl$B$CO);
      (posedge A *> (S +: !B)) = (tpllh$A$S, tplhl$A$S);
      (negedge A *> (S +: B)) = (tphlh$A$S, tphhl$A$S);
      (A *> CO) = (tpllh$A$CO, tphhl$A$CO);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND2X2 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.077:0.077:0.077,
     tphhl$A$Y = 0.057:0.057:0.057,
     tpllh$B$Y = 0.074:0.074:0.074,
     tphhl$B$Y = 0.056:0.056:0.056;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND2X8 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.057:0.057:0.057,
     tphhl$A$Y = 0.039:0.039:0.039,
     tpllh$B$Y = 0.055:0.055:0.055,
     tphhl$B$Y = 0.039:0.039:0.039;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND3X2 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   and (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.062:0.062:0.062,
     tpllh$B$Y = 0.11:0.11:0.11,
     tphhl$B$Y = 0.061:0.061:0.061,
     tpllh$C$Y = 0.1:0.1:0.1,
     tphhl$C$Y = 0.059:0.059:0.059;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND4X2 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.14:0.14:0.14,
     tphhl$A$Y = 0.067:0.067:0.067,
     tpllh$B$Y = 0.14:0.14:0.14,
     tphhl$B$Y = 0.066:0.066:0.066,
     tpllh$C$Y = 0.14:0.14:0.14,
     tphhl$C$Y = 0.064:0.064:0.064,
     tpllh$D$Y = 0.13:0.13:0.13,
     tphhl$D$Y = 0.062:0.062:0.062;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AND4X6 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   and (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.11:0.11:0.11,
     tphhl$A$Y = 0.045:0.045:0.045,
     tpllh$B$Y = 0.1:0.1:0.1,
     tphhl$B$Y = 0.044:0.044:0.044,
     tpllh$C$Y = 0.1:0.1:0.1,
     tphhl$C$Y = 0.043:0.043:0.043,
     tpllh$D$Y = 0.092:0.092:0.092,
     tphhl$D$Y = 0.041:0.041:0.041;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI211XL (A0, A1, B0, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  C0 ;
   output Y ;

   and (I0_out, A0, A1);
   or  (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.16:0.16:0.16,
     tphlh$A0$Y = 0.24:0.24:0.24,
     tplhl$A1$Y = 0.16:0.16:0.16,
     tphlh$A1$Y = 0.23:0.23:0.23,
     tplhl$B0$Y = 0.081:0.081:0.081,
     tphlh$B0$Y = 0.19:0.21:0.23,
     tplhl$C0$Y = 0.079:0.079:0.079,
     tphlh$C0$Y = 0.18:0.2:0.22;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI22X1 (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   and (I0_out, B0, B1);
   and (I1_out, A0, A1);
   or  (I2_out, I0_out, I1_out);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.1:0.1:0.1,
     tphlh$A0$Y = 0.083:0.095:0.11,
     tplhl$A1$Y = 0.1:0.1:0.1,
     tphlh$A1$Y = 0.08:0.092:0.1,
     tplhl$B0$Y = 0.092:0.092:0.092,
     tphlh$B0$Y = 0.071:0.084:0.097,
     tplhl$B1$Y = 0.089:0.09:0.09,
     tphlh$B1$Y = 0.069:0.081:0.094;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSHQX1 (CK, D, Q, SN);
   input  CK ;
   input  D ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_SET, SN);
   udp_dff (N35, D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I5_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.16:0.16:0.16,
     tphlh$SN$Q = 0.11:0.12:0.12,
     tminpwh$CK = 0.053:0.16:0.16,
     tminpwl$CK = 0.054:0.12:0.12,
     tminpwl$SN = 0.017:0.12:0.12,
     tsetup_negedge$D$CK = 0.038:0.038:0.038,
     thold_negedge$D$CK = 0.025:0.025:0.025,
     tsetup_posedge$D$CK = 0.038:0.038:0.038,
     thold_posedge$D$CK = -0.012:-0.012:-0.012,
     trec$SN$CK = 0:0:0,
     trem$SN$CK = 0.038:0.038:0.038;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SN == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SN == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D == 1'b0, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D == 1'b0, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFSRHQX8 (CK, D, Q, RN, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SN ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   not (I6_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I6_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I10_out, D);
   and (D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1, I10_out, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I13_out, SN);
   not (I15_out, D);
   not (I16_out, RN);
   and (D_EQ_0_AN_RN_EQ_0, I15_out, I16_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.14:0.14:0.14,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tphhl$RN$Q = 0.17:0.17:0.18,
     tplhl$SN$Q = 0.15:0.15:0.16,
     tphlh$SN$Q = 0.11:0.11:0.11,
     tminpwh$CK = 0.076:0.15:0.15,
     tminpwl$CK = 0.054:0.13:0.13,
     tminpwl$RN = 0.061:0.18:0.18,
     tminpwl$SN = 0.019:0.11:0.11,
     tsetup_negedge$D$CK = 0.044:0.044:0.044,
     thold_negedge$D$CK = 0.031:0.031:0.031,
     tsetup_posedge$D$CK = 0.069:0.069:0.069,
     thold_posedge$D$CK = -0.019:-0.019:-0.019,
     trec$RN$CK = 0.062:0.062:0.062,
     trem$RN$CK = -0.013:-0.013:-0.013,
     trec$RN$SN = 0.075:0.094:0.094,
     trec$SN$CK = 0.012:0.012:0.012,
     trem$SN$CK = 0.031:0.031:0.031;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D == 1'b0, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFTRXL (CK, D, E, Q, QN, RN);
   input  CK ;
   input  D ;
   input  E ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, QBINT);
   not (I5_out, I4_out);
   and (I0_D, I2_out, I5_out, RN);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I14_out, D);
   not (I15_out, E);
   and (D_EQ_0_AN_E_EQ_0, I14_out, I15_out);
   and (D_EQ_1_AN_E_EQ_1, D, E);
   and (E_EQ_1_AN_RN_EQ_1, E, RN);
   not (I19_out, D);
   not (I20_out, E);
   not (I22_out, RN);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0, I19_out, I20_out, I22_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.18:0.18:0.18,
     tplhl$CK$Q = 0.19:0.19:0.19,
     tpllh$CK$QN = 0.2:0.2:0.2,
     tplhl$CK$QN = 0.19:0.19:0.19,
     tminpwh$CK = 0.049:0.2:0.2,
     tminpwl$CK = 0.053:0.1:0.1,
     tsetup_negedge$D$CK = 0.075:0.075:0.075,
     thold_negedge$D$CK = -0.037:-0.037:-0.037,
     tsetup_negedge$E$CK = 0.069:0.087:0.087,
     thold_negedge$E$CK = -0.081:-0.05:-0.05,
     tsetup_negedge$RN$CK = 0.069:0.069:0.069,
     thold_negedge$RN$CK = -0.031:-0.031:-0.031,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.087:-0.087:-0.087,
     tsetup_posedge$E$CK = 0.063:0.14:0.14,
     thold_posedge$E$CK = -0.12:-0.044:-0.044,
     thold_posedge$RN$CK = -0.12:-0.12:-0.12,
     tsetup_posedge$RN$CK = 0.15:0.15:0.15;

      // path delays
      (posedge CK *> (QN -: RN&(!(QBINT&!E)&!(E&!D)))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: RN&(!(QBINT&!E)&!(E&!D)))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& RN == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D_EQ_0_AN_E_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& RN == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D_EQ_1_AN_E_EQ_1 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module INVX16 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.0089:0.0089:0.0089,
     tphlh$A$Y = 0.0085:0.0085:0.0085;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module INVX8 (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.012:0.012:0.012,
     tphlh$A$Y = 0.011:0.011:0.011;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MX2X8 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.1:0.1:0.1,
     tphhl$A$Y = 0.11:0.11:0.11,
     tpllh$B$Y = 0.1:0.1:0.1,
     tphhl$B$Y = 0.11:0.11:0.11,
     tpllh$S0$Y = 0.098:0.098:0.098,
     tplhl$S0$Y = 0.12:0.12:0.12,
     tphlh$S0$Y = 0.12:0.12:0.12,
     tphhl$S0$Y = 0.11:0.11:0.11;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND2X1 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.09:0.09:0.09,
     tphlh$A$Y = 0.05:0.05:0.05,
     tplhl$B$Y = 0.088:0.088:0.088,
     tphlh$B$Y = 0.048:0.048:0.048;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND3BX2 (AN, B, C, Y);
   input  AN ;
   input  B ;
   input  C ;
   output Y ;

   not (I0_out, AN);
   and (I2_out, I0_out, B, C);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.059:0.059:0.059,
     tphhl$AN$Y = 0.11:0.11:0.11,
     tplhl$B$Y = 0.079:0.079:0.079,
     tphlh$B$Y = 0.031:0.031:0.031,
     tplhl$C$Y = 0.075:0.075:0.075,
     tphlh$C$Y = 0.029:0.029:0.029;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR2X8 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (I0_out, A, B);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.015:0.015:0.015,
     tphlh$A$Y = 0.024:0.024:0.024,
     tplhl$B$Y = 0.013:0.013:0.013,
     tphlh$B$Y = 0.02:0.02:0.02;

      // path delays
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR3XL (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.083:0.083:0.083,
     tphlh$A$Y = 0.23:0.23:0.23,
     tplhl$B$Y = 0.081:0.081:0.081,
     tphlh$B$Y = 0.22:0.22:0.22,
     tplhl$C$Y = 0.079:0.079:0.079,
     tphlh$C$Y = 0.22:0.22:0.22;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4BX1 (AN, B, C, D, Y);
   input  AN ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   or  (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.21:0.21:0.21,
     tphhl$AN$Y = 0.075:0.075:0.075,
     tplhl$B$Y = 0.055:0.055:0.055,
     tphlh$B$Y = 0.19:0.19:0.19,
     tplhl$C$Y = 0.053:0.053:0.053,
     tphlh$C$Y = 0.19:0.19:0.19,
     tplhl$D$Y = 0.051:0.051:0.051,
     tphlh$D$Y = 0.18:0.18:0.18;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4X8 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.019:0.019:0.019,
     tphlh$A$Y = 0.065:0.065:0.065,
     tplhl$B$Y = 0.018:0.018:0.018,
     tphlh$B$Y = 0.061:0.061:0.061,
     tplhl$C$Y = 0.017:0.017:0.017,
     tphlh$C$Y = 0.053:0.053:0.053,
     tplhl$D$Y = 0.014:0.014:0.014,
     tphlh$D$Y = 0.038:0.038:0.038;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI211X1 (A0, A1, B0, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  C0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.15:0.15:0.15,
     tphlh$A0$Y = 0.1:0.1:0.1,
     tplhl$A1$Y = 0.14:0.14:0.14,
     tphlh$A1$Y = 0.1:0.1:0.1,
     tplhl$B0$Y = 0.11:0.13:0.15,
     tphlh$B0$Y = 0.052:0.052:0.052,
     tplhl$C0$Y = 0.11:0.13:0.14,
     tphlh$C0$Y = 0.05:0.05:0.05;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI31X1 (A0, A1, A2, B0, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   output Y ;

   or  (I1_out, A0, A1, A2);
   and (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.1:0.1:0.1,
     tphlh$A0$Y = 0.15:0.15:0.15,
     tplhl$A1$Y = 0.1:0.1:0.1,
     tphlh$A1$Y = 0.15:0.15:0.15,
     tplhl$A2$Y = 0.094:0.094:0.094,
     tphlh$A2$Y = 0.14:0.14:0.14,
     tplhl$B0$Y = 0.061:0.08:0.099,
     tphlh$B0$Y = 0.049:0.049:0.049;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI32X1 (A0, A1, A2, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, B0, B1);
   or  (I2_out, A0, A1, A2);
   and (I3_out, I0_out, I2_out);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.087:0.1:0.11,
     tphlh$A0$Y = 0.16:0.16:0.16,
     tplhl$A1$Y = 0.084:0.097:0.11,
     tphlh$A1$Y = 0.15:0.15:0.16,
     tplhl$A2$Y = 0.08:0.092:0.1,
     tphlh$A2$Y = 0.15:0.15:0.15,
     tplhl$B0$Y = 0.066:0.086:0.11,
     tphlh$B0$Y = 0.094:0.094:0.095,
     tplhl$B1$Y = 0.062:0.082:0.1,
     tphlh$B1$Y = 0.091:0.091:0.091;

      // path delays
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR2X1 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.068:0.068:0.068,
     tphhl$A$Y = 0.087:0.087:0.087,
     tpllh$B$Y = 0.065:0.065:0.065,
     tphhl$B$Y = 0.084:0.084:0.084;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR2X2 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   or  (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.055:0.055:0.055,
     tphhl$A$Y = 0.08:0.08:0.08,
     tpllh$B$Y = 0.052:0.052:0.052,
     tphhl$B$Y = 0.077:0.077:0.077;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR4X2 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (Y, A, B, C, D);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.066:0.066:0.066,
     tphhl$A$Y = 0.16:0.16:0.16,
     tpllh$B$Y = 0.064:0.064:0.064,
     tphhl$B$Y = 0.16:0.16:0.16,
     tpllh$C$Y = 0.061:0.061:0.061,
     tphhl$C$Y = 0.15:0.15:0.15,
     tpllh$D$Y = 0.059:0.059:0.059,
     tphhl$D$Y = 0.14:0.14:0.14;

      // path delays
      (D *> Y) = (tpllh$D$Y, tphhl$D$Y);
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSRXL (CK, D, Q, QN, RN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  RN ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_CLEAR, RN);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, I0_CLEAR, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   and (RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1, RN, SE, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I12_out, D);
   not (I13_out, SE);
   not (I15_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I12_out, I13_out, I15_out);
   not (I17_out, SE);
   and (RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1, RN, I17_out, SN);
   not (I20_out, D);
   not (I22_out, SE);
   not (I24_out, SI);
   and (D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I20_out, RN, I22_out, I24_out, SN);
   not (I27_out, D);
   not (I28_out, SE);
   not (I30_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I27_out, I28_out, I30_out, SN);
   not (I33_out, D);
   not (I34_out, RN);
   not (I36_out, SE);
   not (I38_out, SI);
   and (D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I33_out, I34_out, I36_out, I38_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.18:0.18:0.18,
     tplhl$CK$Q = 0.19:0.19:0.19,
     tpllh$CK$QN = 0.2:0.2:0.2,
     tplhl$CK$QN = 0.19:0.19:0.19,
     tphhl$RN$Q = 0.22:0.22:0.23,
     tphlh$RN$QN = 0.23:0.23:0.24,
     tplhl$SN$Q = 0.2:0.21:0.21,
     tphlh$SN$Q = 0.17:0.17:0.17,
     tpllh$SN$QN = 0.21:0.22:0.22,
     tphhl$SN$QN = 0.18:0.18:0.18,
     tminpwh$CK = 0.055:0.2:0.2,
     tminpwl$CK = 0.053:0.11:0.11,
     tminpwl$RN = 0.058:0.24:0.24,
     tminpwl$SN = 0.02:0.18:0.18,
     tsetup_negedge$D$CK = 0.088:0.088:0.088,
     thold_negedge$D$CK = -0.019:-0.019:-0.019,
     tsetup_negedge$SE$CK = 0.081:0.12:0.12,
     thold_negedge$SE$CK = -0.063:-0.013:-0.013,
     tsetup_negedge$SI$CK = 0.088:0.088:0.088,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.11:0.11:0.11,
     thold_posedge$D$CK = -0.056:-0.056:-0.056,
     tsetup_posedge$SE$CK = 0.1:0.11:0.11,
     thold_posedge$SE$CK = -0.05:-0.031:-0.031,
     tsetup_posedge$SI$CK = 0.11:0.11:0.11,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056,
     trec$RN$CK = 0.056:0.056:0.056,
     trem$RN$CK = -0.013:-0.013:-0.013,
     trec$RN$SN = 0.069:0.075:0.075,
     trec$SN$CK = 0.012:0.012:0.012,
     trem$SN$CK = 0.025:0.025:0.025;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      $setup(negedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& RN_EQ_1_AN_SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge RN, posedge CK &&& SN == 1'b1, trec$RN$CK, NOTIFIER);
      $removal (posedge RN, posedge CK &&& SN == 1'b1, trem$RN$CK, NOTIFIER);
      $recovery(posedge RN, posedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$RN$SN, NOTIFIER);
      $recovery(posedge SN, posedge CK &&& RN == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& RN == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_RN_EQ_1_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_RN_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFSX4 (CK, D, Q, QN, SE, SI, SN);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   not (I0_SET, SN);
   udp_dff (N35, I0_D, CK, 1'B0, I0_SET, NOTIFIER);
   not (QBINT, N35);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I8_out, D);
   not (I9_out, SE);
   not (I11_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I8_out, I9_out, I11_out);
   and (SE_EQ_1_AN_SN_EQ_1, SE, SN);
   not (I14_out, SE);
   and (SE_EQ_0_AN_SN_EQ_1, I14_out, SN);
   not (I16_out, D);
   not (I17_out, SE);
   not (I19_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1, I16_out, I17_out, I19_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tpllh$CK$QN = 0.17:0.17:0.17,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tphlh$SN$Q = 0.11:0.11:0.11,
     tphhl$SN$QN = 0.14:0.14:0.14,
     tminpwh$CK = 0.06:0.17:0.17,
     tminpwl$CK = 0.051:0.11:0.11,
     tminpwl$SN = 0.018:0.14:0.14,
     tsetup_negedge$D$CK = 0.1:0.1:0.1,
     thold_negedge$D$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$SE$CK = 0.087:0.11:0.11,
     thold_negedge$SE$CK = -0.062:-0.0062:-0.0062,
     tsetup_negedge$SI$CK = 0.094:0.094:0.094,
     thold_negedge$SI$CK = -0.012:-0.012:-0.012,
     tsetup_posedge$D$CK = 0.094:0.094:0.094,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$SE$CK = 0.087:0.11:0.11,
     thold_posedge$SE$CK = -0.044:-0.025:-0.025,
     tsetup_posedge$SI$CK = 0.094:0.094:0.094,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05,
     trec$SN$CK = 0.013:0.013:0.013,
     trem$SN$CK = 0.025:0.025:0.025;

      // path delays
      (posedge CK *> (QN -: SE?SI:D)) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      (negedge SN *> (QN -: 1'b1)) = (0, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, 0);
      $setup(negedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& SN == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_0_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& SN == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& SN == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE_EQ_1_AN_SN_EQ_1 == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $recovery(posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trec$SN$CK, NOTIFIER);
      $removal (posedge SN, posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, trem$SN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);
      $width(negedge SN &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TIEHI (Y);
   output Y ;

   buf (Y, 'B1);


endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNCAX3 (CK, E, ECK);
   input  CK ;
   input  E ;
   output ECK ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (EINT, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, EINT);
   and (ECK, CK, EINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.11:0.11:0.11,
     tphhl$CK$ECK = 0.093:0.093:0.093,
     tminpwl$CK = 0.071:0.099:0.099,
     tsetup_negedge$E$CK = 0.012:0.012:0.012,
     thold_negedge$E$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$E$CK = 0.031:0.031:0.031,
     thold_posedge$E$CK = -0.025:-0.025:-0.025;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(negedge CK &&& E == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNCAX8 (CK, E, ECK);
   input  CK ;
   input  E ;
   output ECK ;
   reg 	  NOTIFIER ;

   not (I0_ENABLE, CK);
   udp_tlat (EINT, E, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N0, EINT);
   and (ECK, CK, EINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.11:0.11:0.11,
     tphhl$CK$ECK = 0.096:0.096:0.097,
     tminpwl$CK = 0.086:0.12:0.12,
     tsetup_negedge$E$CK = 0.012:0.012:0.012,
     thold_negedge$E$CK = -0.0062:-0.0062:-0.0062,
     tsetup_posedge$E$CK = 0.037:0.037:0.037,
     thold_posedge$E$CK = -0.031:-0.031:-0.031;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(negedge CK &&& E == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNSRX1 (D, GN, Q, QN, RN, SN);
   input  D ;
   input  GN ;
   input  RN ;
   input  SN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, GN);
   and (I0_ENABLE, I0_out, RN);
   not (I0_SET, SN);
   udp_tlat (QINT, D, I0_ENABLE, 1'B0, I0_SET, NOTIFIER);
   not (N5, QINT);
   buf (Q, QINT);
   not (QN, QINT);
   not (I9_out, D);
   and (D_EQ_0_AN_RN_EQ_1, I9_out, RN);
   and (D_EQ_1_AN_SN_EQ_1, D, SN);
   and (RN_EQ_1_AN_SN_EQ_1, RN, SN);
   not (I13_out, D);
   and (D_EQ_0_AN_SN_EQ_1, I13_out, SN);

    specify
      // delay parameters
      specparam
	tpllh$D$Q = 0.13:0.13:0.13,
     tphhl$D$Q = 0.16:0.16:0.16,
     tplhl$D$QN = 0.13:0.13:0.13,
     tphlh$D$QN = 0.15:0.15:0.15,
     tphlh$GN$Q = 0.2:0.2:0.2,
     tphhl$GN$Q = 0.2:0.2:0.2,
     tphlh$GN$QN = 0.2:0.2:0.2,
     tphhl$GN$QN = 0.19:0.19:0.19,
     tpllh$RN$Q = 0.19:0.19:0.19,
     tphhl$RN$Q = 0.17:0.18:0.2,
     tplhl$RN$QN = 0.18:0.18:0.18,
     tphlh$RN$QN = 0.16:0.18:0.19,
     tplhl$SN$Q = 0.12:0.12:0.12,
     tphlh$SN$Q = 0.092:0.093:0.093,
     tpllh$SN$QN = 0.11:0.11:0.11,
     tphhl$SN$QN = 0.086:0.086:0.087,
     tminpwl$GN = 0.075:0.2:0.2,
     tminpwl$RN = 0.037:0.17:0.17,
     tminpwl$SN = 0.024:0.093:0.093,
     tsetup_negedge$D$GN = 0.037:0.037:0.037,
     thold_negedge$D$GN = -0.025:-0.025:-0.025,
     tsetup_posedge$D$GN = 0.019:0.019:0.019,
     thold_posedge$D$GN = 0:0:0,
     tsetup_posedge$RN$GN = 0.075:0.075:0.075,
     thold_posedge$RN$GN = -0.056:-0.056:-0.056,
     trec$SN$GN = 0:0:0,
     trem$SN$GN = 0.025:0.025:0.025,
     trec$SN$RN = 0.013:0.013:0.013,
     trem$SN$RN = 0.0062:0.0062:0.0062;

      // path delays
      (posedge RN *> (QN -: 1'b1)) = (0, tplhl$RN$QN);
      (posedge RN *> (Q +: 1'b1)) = (tpllh$RN$Q, 0);
      (negedge RN *> (QN +: 1'b1)) = (tphlh$RN$QN, 0);
      (negedge RN *> (Q -: 1'b1)) = (0, tphhl$RN$Q);
      (GN *> QN) = (tphlh$GN$QN, tphhl$GN$QN);
      (GN *> Q) = (tphlh$GN$Q, tphhl$GN$Q);
      (negedge SN *> (QN -: 1'b1)) = (tpllh$SN$QN, tphhl$SN$QN);
      (negedge SN *> (Q +: 1'b1)) = (tphlh$SN$Q, tplhl$SN$Q);
      (D *> QN) = (tphlh$D$QN, tplhl$D$QN);
      (D *> Q) = (tpllh$D$Q, tphhl$D$Q);
      $setup(negedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_negedge$D$GN, NOTIFIER);
      $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, negedge D, thold_negedge$D$GN,  NOTIFIER);
      $setup(posedge D, posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$D$GN, NOTIFIER);
      $hold (posedge GN &&& RN_EQ_1_AN_SN_EQ_1 == 1'b1, posedge D, thold_posedge$D$GN,  NOTIFIER);
      $setup(posedge RN, posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, tsetup_posedge$RN$GN, NOTIFIER);
      $hold (posedge GN &&& D_EQ_1_AN_SN_EQ_1 == 1'b1, posedge RN, thold_posedge$RN$GN,  NOTIFIER);
      $recovery(posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trec$SN$GN, NOTIFIER);
      $removal (posedge SN, posedge GN &&& D_EQ_0_AN_RN_EQ_1 == 1'b1, trem$SN$GN, NOTIFIER);
      $recovery(posedge SN, posedge RN &&& GN == 1'b1, trec$SN$RN, NOTIFIER);
      $removal (posedge SN, posedge RN &&& GN == 1'b1, trem$SN$RN, NOTIFIER);
      $width(negedge GN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$GN, 0, NOTIFIER);
      $width(negedge RN &&& D_EQ_0_AN_SN_EQ_1 == 1'b1, tminpwl$RN, 0, NOTIFIER);
      $width(negedge SN &&& D == 1'b0, tminpwl$SN, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TLATNTSCAX3 (CK, E, ECK, SE);
   input  CK ;
   input  E ;
   input  SE ;
   output ECK ;
   reg 	  NOTIFIER ;

   or  (I0_D, E, SE);
   not (I0_ENABLE, CK);
   udp_tlat (EINT, I0_D, I0_ENABLE, 1'B0, 1'B0, NOTIFIER);
   not (N5, EINT);
   and (ECK, CK, EINT);
   not (I6_out, E);
   not (I7_out, SE);
   and (E_EQ_0_AN_SE_EQ_0, I6_out, I7_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$ECK = 0.11:0.11:0.11,
     tphhl$CK$ECK = 0.095:0.096:0.096,
     tminpwl$CK = 0.066:0.1:0.1,
     tsetup_negedge$E$CK = 0.044:0.044:0.044,
     thold_negedge$E$CK = -0.037:-0.037:-0.037,
     tsetup_negedge$SE$CK = 0.05:0.05:0.05,
     thold_negedge$SE$CK = -0.044:-0.044:-0.044,
     tsetup_posedge$E$CK = 0.038:0.038:0.038,
     thold_posedge$E$CK = -0.031:-0.031:-0.031,
     tsetup_posedge$SE$CK = 0.044:0.044:0.044,
     thold_posedge$SE$CK = -0.038:-0.038:-0.038;

      // path delays
      (posedge CK *> (ECK +: 1'b1)) = (tpllh$CK$ECK, 0);
      (negedge CK *> (ECK -: 1'b1)) = (0, tphhl$CK$ECK);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& E == 1'b0, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& E == 1'b0, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b0, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $width(negedge CK &&& E_EQ_0_AN_SE_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XOR3XL (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   xor (I0_out, A, B);
   xor (Y, I0_out, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.18:0.18:0.19,
     tplhl$A$Y = 0.2:0.2:0.2,
     tphlh$A$Y = 0.22:0.22:0.22,
     tphhl$A$Y = 0.16:0.16:0.16,
     tpllh$B$Y = 0.16:0.16:0.16,
     tplhl$B$Y = 0.15:0.15:0.15,
     tphlh$B$Y = 0.16:0.17:0.17,
     tphhl$B$Y = 0.13:0.14:0.14,
     tpllh$C$Y = 0.12:0.12:0.12,
     tplhl$C$Y = 0.11:0.11:0.11,
     tphlh$C$Y = 0.13:0.13:0.13,
     tphhl$C$Y = 0.1:0.1:0.1;

      // path delays
      (posedge C *> (Y +: !(B^A))) = (tpllh$C$Y, tplhl$C$Y);
      (negedge C *> (Y +: B^A)) = (tphlh$C$Y, tphhl$C$Y);
      (posedge B *> (Y +: C^!A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: C^A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: C^!B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: C^B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module AOI31X4 (A0, A1, A2, B0, Y);
   input  A0 ;
   input  A1 ;
   input  A2 ;
   input  B0 ;
   output Y ;

   and (I1_out, A0, A1, A2);
   or  (I2_out, I1_out, B0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.068:0.068:0.068,
     tphlh$A0$Y = 0.046:0.046:0.046,
     tplhl$A1$Y = 0.064:0.064:0.064,
     tphlh$A1$Y = 0.043:0.043:0.043,
     tplhl$A2$Y = 0.058:0.058:0.058,
     tphlh$A2$Y = 0.039:0.039:0.039,
     tplhl$B0$Y = 0.018:0.018:0.018,
     tphlh$B0$Y = 0.021:0.029:0.037;

      // path delays
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A2 *> Y) = (tphlh$A2$Y, tplhl$A2$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFHQX8 (CK, D, Q);
   input  CK ;
   input  D ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.12:0.12:0.12,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.067:0.13:0.13,
     tminpwl$CK = 0.053:0.11:0.11,
     tsetup_negedge$D$CK = 0.012:0.012:0.012,
     thold_negedge$D$CK = 0.031:0.031:0.031,
     tsetup_posedge$D$CK = 0.037:0.037:0.037,
     thold_posedge$D$CK = -0.013:-0.013:-0.013;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFHQX4 (CK, D, E, Q);
   input  CK ;
   input  D ;
   input  E ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I0_D, I0_out, D, E);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I6_out, D);
   and (D_EQ_0_AN_E_EQ_1, I6_out, E);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.12:0.12:0.12,
     tminpwh$CK = 0.054:0.12:0.12,
     tminpwl$CK = 0.047:0.09:0.09,
     tsetup_negedge$D$CK = 0.056:0.056:0.056,
     thold_negedge$D$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$E$CK = 0.019:0.019:0.019,
     thold_negedge$E$CK = 0.013:0.013:0.013,


     tsetup_posedge$D$CK = 0.081:0.081:0.081,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$E$CK = 0.075:0.075:0.075,
      thold_posedge$E$CK = -0.05:-0.05:-0.05;
       


      // path delays
      (posedge CK *> (Q +: E?D:!QBINT)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& D == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& D == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& D == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_1 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module INVXL (A, Y);
   input  A ;
   output Y ;

   not (Y, A);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.076:0.076:0.076,
     tphlh$A$Y = 0.077:0.077:0.077;

      // path delays
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI2X8 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.095:0.095:0.095,
     tphlh$A$Y = 0.097:0.097:0.097,
     tplhl$B$Y = 0.095:0.095:0.095,
     tphlh$B$Y = 0.098:0.098:0.098,
     tpllh$S0$Y = 0.11:0.11:0.11,
     tplhl$S0$Y = 0.089:0.089:0.089,
     tphlh$S0$Y = 0.09:0.09:0.09,
     tphhl$S0$Y = 0.11:0.11:0.11;

      // path delays
      (posedge S0 *> (Y +: !B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI4X1 (A, B, C, D, S0, S1, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   input  S0 ;
   input  S1 ;
   output Y ;

   udp_mux2 (I0_out, C, D, S0);
   udp_mux2 (I1_out, A, B, S0);
   udp_mux2 (I2_out, I1_out, I0_out, S1);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.14:0.14:0.14,
     tphlh$A$Y = 0.14:0.14:0.14,
     tplhl$B$Y = 0.14:0.14:0.14,
     tphlh$B$Y = 0.14:0.14:0.14,
     tplhl$C$Y = 0.14:0.14:0.14,
     tphlh$C$Y = 0.14:0.14:0.14,
     tplhl$D$Y = 0.14:0.14:0.14,
     tphlh$D$Y = 0.14:0.14:0.14,
     tpllh$S0$Y = 0.16:0.16:0.16,
     tplhl$S0$Y = 0.13:0.13:0.13,
     tphlh$S0$Y = 0.13:0.13:0.13,
     tphhl$S0$Y = 0.16:0.16:0.16,
     tpllh$S1$Y = 0.088:0.088:0.088,
     tplhl$S1$Y = 0.11:0.11:0.11,
     tphlh$S1$Y = 0.11:0.11:0.11,
     tphhl$S1$Y = 0.092:0.092:0.092;

      // path delays
      (posedge S1 *> (Y +: !(S0?D:C))) = (tpllh$S1$Y, tplhl$S1$Y);
      (negedge S1 *> (Y +: !(S0?B:A))) = (tphlh$S1$Y, tphhl$S1$Y);
      (posedge S0 *> (Y +: !(S1?D:B))) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !(S1?C:A))) = (tphlh$S0$Y, tphhl$S0$Y);
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4BX1 (AN, B, C, D, Y);
   input  AN ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   and (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.072:0.072:0.072,
     tphhl$AN$Y = 0.2:0.2:0.2,
     tplhl$B$Y = 0.19:0.19:0.19,
     tphlh$B$Y = 0.054:0.054:0.054,
     tplhl$C$Y = 0.18:0.18:0.18,
     tphlh$C$Y = 0.053:0.053:0.053,
     tplhl$D$Y = 0.17:0.17:0.17,
     tphlh$D$Y = 0.051:0.051:0.051;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OA21X4 (A0, A1, B0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (Y, I0_out, B0);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.075:0.075:0.075,
     tphhl$A0$Y = 0.077:0.077:0.077,
     tpllh$A1$Y = 0.069:0.069:0.069,
     tphhl$A1$Y = 0.074:0.074:0.074,
     tpllh$B0$Y = 0.054:0.062:0.07,
     tphhl$B0$Y = 0.045:0.047:0.048;

      // path delays
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI221X2 (A0, A1, B0, B1, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (I3_out, I0_out, I1_out, C0);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.083:0.094:0.11,
     tphlh$A0$Y = 0.067:0.068:0.068,
     tplhl$A1$Y = 0.079:0.089:0.1,
     tphlh$A1$Y = 0.064:0.064:0.065,
     tplhl$B0$Y = 0.077:0.088:0.099,
     tphlh$B0$Y = 0.062:0.062:0.062,
     tplhl$B1$Y = 0.072:0.083:0.093,
     tphlh$B1$Y = 0.058:0.058:0.059,
     tplhl$C0$Y = 0.052:0.071:0.09,
     tphlh$C0$Y = 0.029:0.029:0.029;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR3X6 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.04:0.04:0.04,
     tphhl$A$Y = 0.082:0.082:0.082,
     tpllh$B$Y = 0.039:0.039:0.039,
     tphhl$B$Y = 0.079:0.079:0.079,
     tpllh$C$Y = 0.036:0.036:0.036,
     tphhl$C$Y = 0.073:0.073:0.073;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OR3XL (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (Y, A, B, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.1:0.1:0.1,
     tphhl$A$Y = 0.14:0.14:0.14,
     tpllh$B$Y = 0.099:0.099:0.099,
     tphhl$B$Y = 0.14:0.14:0.14,
     tpllh$C$Y = 0.097:0.097:0.097,
     tphhl$C$Y = 0.13:0.13:0.13;

      // path delays
      (C *> Y) = (tpllh$C$Y, tphhl$C$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SDFFQX2 (CK, D, Q, SE, SI);
   input  CK ;
   input  D ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_mux2 (I0_D, D, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I5_out, D);
   and (D_EQ_0_AN_SI_EQ_1, I5_out, SI);
   not (I7_out, SI);
   and (D_EQ_1_AN_SI_EQ_0, D, I7_out);
   not (I9_out, D);
   not (I10_out, SE);
   not (I12_out, SI);
   and (D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.049:0.13:0.13,
     tminpwl$CK = 0.05:0.091:0.091,
     tsetup_negedge$D$CK = 0.062:0.062:0.062,
     thold_negedge$D$CK = -0.013:-0.013:-0.013,
     tsetup_negedge$SE$CK = 0.094:0.094:0.094,
     thold_negedge$SE$CK = -0.062:-0.062:-0.062,


     tsetup_negedge$SI$CK = 0.062:0.062:0.062,
     thold_negedge$SI$CK = -0.012:-0.012:-0.012,
     tsetup_posedge$D$CK = 0.087:0.087:0.087,
     thold_posedge$D$CK = -0.05:-0.05:-0.05,
     tsetup_posedge$SE$CK = 0.069:0.069:0.069,
     thold_posedge$SE$CK = -0.019:-0.019:-0.019,


     tsetup_posedge$SI$CK = 0.081:0.081:0.081,
     thold_posedge$SI$CK = -0.05:-0.05:-0.05;

      // path delays
      (posedge CK *> (Q +: SE?SI:D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& SE == 1'b0, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& SE == 1'b0, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_SE_EQ_0_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFHQX4 (CK, D, E, Q, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I7_out, D);
   not (I8_out, E);
   not (I10_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0, I7_out, I8_out, I10_out);
   not (I12_out, D);
   not (I13_out, E);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1, I12_out, I13_out, SI);
   not (I16_out, D);
   and (D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1, I16_out, E, SI);
   not (I20_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0, D, E, I20_out);
   not (I22_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I22_out);
   not (I24_out, D);
   not (I25_out, E);
   not (I28_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0, I24_out, I25_out, SE, I28_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.054:0.13:0.13,
     tminpwl$CK = 0.05:0.097:0.097,
     tsetup_negedge$D$CK = 0.094:0.094:0.094,
     thold_negedge$D$CK = -0.025:-0.025:-0.025,
     tsetup_negedge$E$CK = 0.062:0.11:0.11,
     thold_negedge$E$CK = -0.094:-0.019:-0.019,
     thold_negedge$SE$CK = -0.0062:-0.0062:-0.0062,
     tsetup_negedge$SE$CK = 0.094:0.094:0.094,
     tsetup_negedge$SI$CK = 0.05:0.05:0.05,
     thold_negedge$SI$CK = -0.0063:-0.0063:-0.0063,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$E$CK = 0.11:0.12:0.12,
     thold_posedge$E$CK = -0.087:-0.087:-0.087,
     tsetup_posedge$SE$CK = 0.069:0.069:0.069,
     thold_posedge$SE$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$SI$CK = 0.075:0.075:0.075,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:(E?D:!QBINT))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFX4 (CK, D, E, Q, QN, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  SE ;
   input  SI ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, NET536);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (NET536, N30);
   not (Q, NET536);
   buf (QN, NET536);
   not (I9_out, D);
   not (I10_out, E);
   not (I12_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0, I9_out, I10_out, I12_out);
   not (I14_out, D);
   not (I15_out, E);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1, I14_out, I15_out, SI);
   not (I18_out, D);
   and (D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1, I18_out, E, SI);
   not (I22_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0, D, E, I22_out);
   not (I24_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I24_out);
   not (I26_out, D);
   not (I27_out, E);
   not (I30_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0, I26_out, I27_out, SE, I30_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.12:0.12:0.12,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.054:0.16:0.16,
     tminpwl$CK = 0.046:0.094:0.094,
     tsetup_negedge$D$CK = 0.13:0.13:0.13,
     thold_negedge$D$CK = -0.037:-0.037:-0.037,
     tsetup_negedge$E$CK = 0.087:0.12:0.12,
     thold_negedge$E$CK = -0.11:-0.031:-0.031,
     thold_negedge$SE$CK = -0.012:-0.012:-0.012,
     tsetup_negedge$SE$CK = 0.11:0.11:0.11,
     tsetup_negedge$SI$CK = 0.075:0.075:0.075,
     thold_negedge$SI$CK = -0.019:-0.019:-0.019,
     tsetup_posedge$D$CK = 0.15:0.15:0.15,
     thold_posedge$D$CK = -0.1:-0.1:-0.1,
     tsetup_posedge$E$CK = 0.14:0.14:0.14,
     thold_posedge$E$CK = -0.12:-0.11:-0.11,
     tsetup_posedge$SE$CK = 0.087:0.087:0.087,
     thold_posedge$SE$CK = -0.025:-0.025:-0.025,
     tsetup_posedge$SI$CK = 0.094:0.094:0.094,
     thold_posedge$SI$CK = -0.056:-0.056:-0.056;

      // path delays
      (posedge CK *> (QN -: SE?SI:(E?D:!NET536))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: SE?SI:(E?D:!NET536))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module TBUFX1 (A, OE, Y);
   input  A ;
   input  OE ;
   output Y ;

   bufif1 (Y, A, OE);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.083:0.083:0.083,
     tphhl$A$Y = 0.077:0.077:0.077,
     tpzh$OE$Y = 0.081:0.081:0.081,
     tpzl$OE$Y = 0.086:0.086:0.086,
     tplz$OE$Y = 0.029:0.029:0.029,
     tphz$OE$Y = 0.02:0.02:0.02;

      // path delays
      (OE *> Y) = (0, 0, tplz$OE$Y, tpzh$OE$Y, tphz$OE$Y, tpzl$OE$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKXOR2X8 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   xor (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.12:0.12:0.12,
     tplhl$A$Y = 0.14:0.14:0.14,
     tphlh$A$Y = 0.13:0.13:0.13,
     tphhl$A$Y = 0.13:0.13:0.13,
     tpllh$B$Y = 0.1:0.1:0.1,
     tplhl$B$Y = 0.13:0.13:0.13,
     tphlh$B$Y = 0.1:0.1:0.1,
     tphhl$B$Y = 0.11:0.11:0.11;

      // path delays
      (posedge B *> (Y +: !A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: !B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module MXI2X4 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (I0_out, A, B, S0);
   not (Y, I0_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.098:0.098:0.098,
     tphlh$A$Y = 0.099:0.099:0.099,
     tplhl$B$Y = 0.098:0.098:0.098,
     tphlh$B$Y = 0.1:0.1:0.1,
     tpllh$S0$Y = 0.11:0.11:0.11,
     tplhl$S0$Y = 0.091:0.091:0.091,
     tphlh$S0$Y = 0.092:0.092:0.092,
     tphhl$S0$Y = 0.11:0.11:0.11;

      // path delays
      (posedge S0 *> (Y +: !B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: !A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NAND4BBX1 (AN, BN, C, D, Y);
   input  AN ;
   input  BN ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, BN);
   not (I1_out, AN);
   and (I4_out, I0_out, I1_out, C, D);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.072:0.072:0.072,
     tphhl$AN$Y = 0.21:0.21:0.21,
     tpllh$BN$Y = 0.073:0.073:0.073,
     tphhl$BN$Y = 0.2:0.2:0.2,
     tplhl$C$Y = 0.18:0.18:0.18,
     tphlh$C$Y = 0.053:0.053:0.053,
     tplhl$D$Y = 0.18:0.18:0.18,
     tphlh$D$Y = 0.052:0.052:0.052;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (BN *> Y) = (tpllh$BN$Y, tphhl$BN$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR3X8 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.018:0.018:0.018,
     tphlh$A$Y = 0.042:0.042:0.042,
     tplhl$B$Y = 0.016:0.016:0.016,
     tphlh$B$Y = 0.038:0.038:0.038,
     tplhl$C$Y = 0.014:0.014:0.014,
     tphlh$C$Y = 0.031:0.031:0.031;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4BXL (AN, B, C, D, Y);
   input  AN ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   not (I0_out, AN);
   or  (I3_out, I0_out, B, C, D);
   not (Y, I3_out);

    specify
      // delay parameters
      specparam
	tpllh$AN$Y = 0.32:0.32:0.32,
     tphhl$AN$Y = 0.1:0.1:0.1,
     tplhl$B$Y = 0.085:0.085:0.085,
     tphlh$B$Y = 0.31:0.31:0.31,
     tplhl$C$Y = 0.082:0.082:0.082,
     tphlh$C$Y = 0.3:0.3:0.3,
     tplhl$D$Y = 0.08:0.08:0.08,
     tphlh$D$Y = 0.29:0.29:0.29;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (AN *> Y) = (tpllh$AN$Y, tphhl$AN$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR4X4 (A, B, C, D, Y);
   input  A ;
   input  B ;
   input  C ;
   input  D ;
   output Y ;

   or  (I2_out, A, B, C, D);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.025:0.025:0.025,
     tphlh$A$Y = 0.088:0.088:0.088,
     tplhl$B$Y = 0.024:0.024:0.024,
     tphlh$B$Y = 0.084:0.084:0.084,
     tplhl$C$Y = 0.023:0.023:0.023,
     tphlh$C$Y = 0.075:0.075:0.075,
     tplhl$D$Y = 0.02:0.02:0.02,
     tphlh$D$Y = 0.06:0.06:0.06;

      // path delays
      (D *> Y) = (tphlh$D$Y, tplhl$D$Y);
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OA22XL (A0, A1, B0, B1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   output Y ;

   or  (I0_out, A0, A1);
   or  (I1_out, B0, B1);
   and (Y, I0_out, I1_out);

    specify
      // delay parameters
      specparam
	tpllh$A0$Y = 0.12:0.13:0.13,
     tphhl$A0$Y = 0.13:0.13:0.14,
     tpllh$A1$Y = 0.11:0.12:0.13,
     tphhl$A1$Y = 0.13:0.13:0.13,
     tpllh$B0$Y = 0.11:0.12:0.12,
     tphhl$B0$Y = 0.12:0.12:0.12,
     tpllh$B1$Y = 0.1:0.11:0.12,
     tphhl$B1$Y = 0.11:0.12:0.12;

      // path delays
      (B1 *> Y) = (tpllh$B1$Y, tphhl$B1$Y);
      (B0 *> Y) = (tpllh$B0$Y, tphhl$B0$Y);
      (A1 *> Y) = (tpllh$A1$Y, tphhl$A1$Y);
      (A0 *> Y) = (tpllh$A0$Y, tphhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI222XL (A0, A1, B0, B1, C0, C1, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  B1 ;
   input  C0 ;
   input  C1 ;
   output Y ;

   or  (I0_out, C0, C1);
   or  (I1_out, A0, A1);
   or  (I3_out, B0, B1);
   and (I4_out, I0_out, I1_out, I3_out);
   not (Y, I4_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.17:0.22:0.26,
     tphlh$A0$Y = 0.17:0.18:0.18,
     tplhl$A1$Y = 0.17:0.21:0.25,
     tphlh$A1$Y = 0.17:0.17:0.17,
     tplhl$B0$Y = 0.17:0.21:0.25,
     tphlh$B0$Y = 0.17:0.17:0.17,
     tplhl$B1$Y = 0.16:0.2:0.25,
     tphlh$B1$Y = 0.16:0.16:0.16,
     tplhl$C0$Y = 0.15:0.19:0.23,
     tphlh$C0$Y = 0.16:0.16:0.16,
     tplhl$C1$Y = 0.14:0.19:0.23,
     tphlh$C1$Y = 0.15:0.15:0.15;

      // path delays
      (C1 *> Y) = (tphlh$C1$Y, tplhl$C1$Y);
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B1 *> Y) = (tphlh$B1$Y, tplhl$B1$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module XOR3X1 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   xor (I0_out, A, B);
   xor (Y, I0_out, C);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.14:0.15:0.15,
     tplhl$A$Y = 0.2:0.2:0.2,
     tphlh$A$Y = 0.18:0.18:0.18,
     tphhl$A$Y = 0.14:0.15:0.15,
     tpllh$B$Y = 0.13:0.13:0.13,
     tplhl$B$Y = 0.14:0.14:0.15,
     tphlh$B$Y = 0.12:0.13:0.14,
     tphhl$B$Y = 0.12:0.14:0.15,
     tpllh$C$Y = 0.088:0.089:0.09,
     tplhl$C$Y = 0.11:0.11:0.11,
     tphlh$C$Y = 0.095:0.096:0.097,
     tphhl$C$Y = 0.098:0.1:0.1;

      // path delays
      (posedge C *> (Y +: !(B^A))) = (tpllh$C$Y, tplhl$C$Y);
      (negedge C *> (Y +: B^A)) = (tphlh$C$Y, tphhl$C$Y);
      (posedge B *> (Y +: C^!A)) = (tpllh$B$Y, tplhl$B$Y);
      (negedge B *> (Y +: C^A)) = (tphlh$B$Y, tphhl$B$Y);
      (posedge A *> (Y +: C^!B)) = (tpllh$A$Y, tplhl$A$Y);
      (negedge A *> (Y +: C^B)) = (tphlh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKMX2X8 (A, B, S0, Y);
   input  A ;
   input  B ;
   input  S0 ;
   output Y ;

   udp_mux2 (Y, A, B, S0);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.1:0.1:0.1,
     tphhl$A$Y = 0.11:0.11:0.11,
     tpllh$B$Y = 0.1:0.1:0.1,
     tphhl$B$Y = 0.11:0.11:0.11,
     tpllh$S0$Y = 0.098:0.098:0.098,
     tplhl$S0$Y = 0.12:0.12:0.12,
     tphlh$S0$Y = 0.12:0.12:0.12,
     tphhl$S0$Y = 0.11:0.11:0.11;

      // path delays
      (posedge S0 *> (Y +: B)) = (tpllh$S0$Y, tplhl$S0$Y);
      (negedge S0 *> (Y +: A)) = (tphlh$S0$Y, tphhl$S0$Y);
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module DFFHQX4 (CK, D, Q);
   input  CK ;
   input  D ;
   output Q ;
   reg 	  NOTIFIER ;

   udp_dff (N30, D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.11:0.11:0.11,
     tplhl$CK$Q = 0.13:0.13:0.13,
     tminpwh$CK = 0.061:0.13:0.13,
     tminpwl$CK = 0.058:0.11:0.11,
     tsetup_negedge$D$CK = 0.0062:0.0062:0.0062,
     thold_negedge$D$CK = 0.031:0.031:0.031,
     tsetup_posedge$D$CK = 0.037:0.037:0.037,
     thold_posedge$D$CK = -0.012:-0.012:-0.012;

      // path delays
      (posedge CK *> (Q +: D)) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(posedge D, posedge CK, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $width(posedge CK &&& D == 1'b0, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D == 1'b0, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module NOR3X4 (A, B, C, Y);
   input  A ;
   input  B ;
   input  C ;
   output Y ;

   or  (I1_out, A, B, C);
   not (Y, I1_out);

    specify
      // delay parameters
      specparam
	tplhl$A$Y = 0.023:0.023:0.023,
     tphlh$A$Y = 0.056:0.056:0.056,
     tplhl$B$Y = 0.021:0.021:0.021,
     tphlh$B$Y = 0.053:0.053:0.053,
     tplhl$C$Y = 0.019:0.019:0.019,
     tphlh$C$Y = 0.045:0.045:0.045;

      // path delays
      (C *> Y) = (tphlh$C$Y, tplhl$C$Y);
      (B *> Y) = (tphlh$B$Y, tplhl$B$Y);
      (A *> Y) = (tphlh$A$Y, tplhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module EDFFTRX2 (CK, D, E, Q, QN, RN);
   input  CK ;
   input  D ;
   input  E ;
   input  RN ;
   output Q ;
   output QN ;
   reg 	  NOTIFIER ;

   not (I0_out, D);
   and (I1_out, I0_out, E);
   not (I2_out, I1_out);
   not (I3_out, E);
   and (I4_out, I3_out, QBINT);
   not (I5_out, I4_out);
   and (I0_D, I2_out, I5_out, RN);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   buf (QN, QBINT);
   not (I14_out, D);
   not (I15_out, E);
   and (D_EQ_0_AN_E_EQ_0, I14_out, I15_out);
   and (D_EQ_1_AN_E_EQ_1, D, E);
   and (E_EQ_1_AN_RN_EQ_1, E, RN);
   not (I19_out, D);
   not (I20_out, E);
   not (I22_out, RN);
   and (D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0, I19_out, I20_out, I22_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.14:0.14:0.14,
     tpllh$CK$QN = 0.16:0.16:0.16,
     tplhl$CK$QN = 0.15:0.15:0.15,
     tminpwh$CK = 0.054:0.16:0.16,
     tminpwl$CK = 0.054:0.11:0.11,
     tsetup_negedge$D$CK = 0.075:0.075:0.075,
     thold_negedge$D$CK = -0.031:-0.031:-0.031,
     tsetup_negedge$E$CK = 0.069:0.087:0.087,
     thold_negedge$E$CK = -0.075:-0.05:-0.05,
     tsetup_negedge$RN$CK = 0.069:0.069:0.069,
     thold_negedge$RN$CK = -0.025:-0.025:-0.025,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$E$CK = 0.062:0.14:0.14,
     thold_posedge$E$CK = -0.12:-0.044:-0.044,
     thold_posedge$RN$CK = -0.12:-0.12:-0.12,
     tsetup_posedge$RN$CK = 0.15:0.15:0.15;

      // path delays
      (posedge CK *> (QN -: RN&(!(QBINT&!E)&!(E&!D)))) = (tpllh$CK$QN, tplhl$CK$QN);
      (posedge CK *> (Q +: RN&(!(QBINT&!E)&!(E&!D)))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& RN == 1'b1, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $setup(negedge RN, posedge CK &&& D_EQ_0_AN_E_EQ_0 == 1'b1, tsetup_negedge$RN$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1 == 1'b1, negedge RN, thold_negedge$RN$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_RN_EQ_1 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& RN == 1'b1, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& RN == 1'b1, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0 == 1'b1, posedge RN, thold_posedge$RN$CK,  NOTIFIER);
      $setup(posedge RN, posedge CK &&& D_EQ_1_AN_E_EQ_1 == 1'b1, tsetup_posedge$RN$CK, NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_RN_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module SEDFFHQX1 (CK, D, E, Q, SE, SI);
   input  CK ;
   input  D ;
   input  E ;
   input  SE ;
   input  SI ;
   output Q ;
   reg 	  NOTIFIER ;

   not (I0_out, QBINT);
   udp_mux2 (I1_out, I0_out, D, E);
   udp_mux2 (I0_D, I1_out, SI, SE);
   udp_dff (N30, I0_D, CK, 1'B0, 1'B0, NOTIFIER);
   not (QBINT, N30);
   not (Q, QBINT);
   not (I7_out, D);
   not (I8_out, E);
   not (I10_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0, I7_out, I8_out, I10_out);
   not (I12_out, D);
   not (I13_out, E);
   and (D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1, I12_out, I13_out, SI);
   not (I16_out, D);
   and (D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1, I16_out, E, SI);
   not (I20_out, SI);
   and (D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0, D, E, I20_out);
   not (I22_out, SE);
   and (E_EQ_1_AN_SE_EQ_0, E, I22_out);
   not (I24_out, D);
   not (I25_out, E);
   not (I28_out, SI);
   and (D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0, I24_out, I25_out, SE, I28_out);

    specify
      // delay parameters
      specparam
	tpllh$CK$Q = 0.13:0.13:0.13,
     tplhl$CK$Q = 0.15:0.15:0.15,
     tminpwh$CK = 0.048:0.15:0.15,
     tminpwl$CK = 0.049:0.094:0.094,
     tsetup_negedge$D$CK = 0.094:0.094:0.094,
     thold_negedge$D$CK = -0.038:-0.038:-0.038,
     tsetup_negedge$E$CK = 0.063:0.11:0.11,
     thold_negedge$E$CK = -0.1:-0.031:-0.031,
     thold_negedge$SE$CK = -0.0063:-0.0063:-0.0063,
     tsetup_negedge$SE$CK = 0.087:0.087:0.087,
     tsetup_negedge$SI$CK = 0.05:0.05:0.05,
     thold_negedge$SI$CK = -0.012:-0.012:-0.012,
     tsetup_posedge$D$CK = 0.12:0.12:0.12,
     thold_posedge$D$CK = -0.081:-0.081:-0.081,
     tsetup_posedge$E$CK = 0.11:0.11:0.11,
     thold_posedge$E$CK = -0.088:-0.087:-0.087,
     tsetup_posedge$SE$CK = 0.062:0.062:0.062,
     thold_posedge$SE$CK = -0.025:-0.025:-0.025,
     tsetup_posedge$SI$CK = 0.069:0.069:0.069,
     thold_posedge$SI$CK = -0.044:-0.044:-0.044;

      // path delays
      (posedge CK *> (Q +: SE?SI:(E?D:!QBINT))) = (tpllh$CK$Q, tplhl$CK$Q);
      $setup(negedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_negedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, negedge D, thold_negedge$D$CK,  NOTIFIER);
      $setup(negedge E, posedge CK &&& SE == 1'b0, tsetup_negedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, negedge E, thold_negedge$E$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, negedge SE, thold_negedge$SE$CK,  NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SE, posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, tsetup_negedge$SE$CK, NOTIFIER);
      $setup(negedge SI, posedge CK &&& SE == 1'b1, tsetup_negedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, negedge SI, thold_negedge$SI$CK,  NOTIFIER);
      $setup(posedge D, posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, tsetup_posedge$D$CK, NOTIFIER);
      $hold (posedge CK &&& E_EQ_1_AN_SE_EQ_0 == 1'b1, posedge D, thold_posedge$D$CK,  NOTIFIER);
      $setup(posedge E, posedge CK &&& SE == 1'b0, tsetup_posedge$E$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b0, posedge E, thold_posedge$E$CK,  NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_0 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $setup(posedge SE, posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SI_EQ_1 == 1'b1, tsetup_posedge$SE$CK, NOTIFIER);
      $hold (posedge CK &&& D_EQ_0_AN_E_EQ_1_AN_SI_EQ_1 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $hold (posedge CK &&& D_EQ_1_AN_E_EQ_1_AN_SI_EQ_0 == 1'b1, posedge SE, thold_posedge$SE$CK,  NOTIFIER);
      $setup(posedge SI, posedge CK &&& SE == 1'b1, tsetup_posedge$SI$CK, NOTIFIER);
      $hold (posedge CK &&& SE == 1'b1, posedge SI, thold_posedge$SI$CK,  NOTIFIER);
      $width(posedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwh$CK, 0, NOTIFIER);
      $width(negedge CK &&& D_EQ_0_AN_E_EQ_0_AN_SE_EQ_1_AN_SI_EQ_0 == 1'b1, tminpwl$CK, 0, NOTIFIER);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module CLKAND2X4 (A, B, Y);
   input  A ;
   input  B ;
   output Y ;

   and (Y, A, B);

    specify
      // delay parameters
      specparam
	tpllh$A$Y = 0.046:0.046:0.046,
     tphhl$A$Y = 0.05:0.05:0.05,
     tpllh$B$Y = 0.044:0.044:0.044,
     tphhl$B$Y = 0.047:0.047:0.047;

      // path delays
      (B *> Y) = (tpllh$B$Y, tphhl$B$Y);
      (A *> Y) = (tpllh$A$Y, tphhl$A$Y);

   endspecify  

endmodule
`endcelldefine

`timescale 1ns/10ps
  `celldefine
    module OAI211XL (A0, A1, B0, C0, Y);
   input  A0 ;
   input  A1 ;
   input  B0 ;
   input  C0 ;
   output Y ;

   or  (I0_out, A0, A1);
   and (I2_out, I0_out, B0, C0);
   not (Y, I2_out);

    specify
      // delay parameters
      specparam
	tplhl$A0$Y = 0.23:0.23:0.23,
     tphlh$A0$Y = 0.16:0.16:0.16,
     tplhl$A1$Y = 0.22:0.22:0.22,
     tphlh$A1$Y = 0.16:0.16:0.16,
     tplhl$B0$Y = 0.18:0.2:0.22,
     tphlh$B0$Y = 0.082:0.083:0.083,
     tplhl$C0$Y = 0.17:0.2:0.22,
     tphlh$C0$Y = 0.081:0.081:0.081;

      // path delays
      (C0 *> Y) = (tphlh$C0$Y, tplhl$C0$Y);
      (B0 *> Y) = (tphlh$B0$Y, tplhl$B0$Y);
      (A1 *> Y) = (tphlh$A1$Y, tplhl$A1$Y);
      (A0 *> Y) = (tphlh$A0$Y, tplhl$A0$Y);

   endspecify  

endmodule
`endcelldefine

  primitive udp_dff (out, in, clk, clr, set, NOTIFIER);
   output out;
   input  in, clk, clr, set, NOTIFIER;
   reg    out;

   table

      // in  clk  clr   set  NOT  : Qt : Qt+1
      //
      0  r   ?   0   ?   : ?  :  0  ; // clock in 0
      1  r   0   ?   ?   : ?  :  1  ; // clock in 1
      1  *   0   ?   ?   : 1  :  1  ; // reduce pessimism
      0  *   ?   0   ?   : 0  :  0  ; // reduce pessimism
      ?  f   ?   ?   ?   : ?  :  -  ; // no changes on negedge clk
      *  b   ?   ?   ?   : ?  :  -  ; // no changes when in switches
      ?  ?   ?   1   ?   : ?  :  1  ; // set output
      ?  b   0   *   ?   : 1  :  1  ; // cover all transistions on set
      1  x   0   *   ?   : 1  :  1  ; // cover all transistions on set
      ?  ?   1   0   ?   : ?  :  0  ; // reset output
      ?  b   *   0   ?   : 0  :  0  ; // cover all transistions on clr
      0  x   *   0   ?   : 0  :  0  ; // cover all transistions on clr
      ?  ?   ?   ?   *   : ?  :  x  ; // any notifier changed

   endtable
endprimitive // udp_dff

primitive udp_tlat (out, in, enable, clr, set, NOTIFIER);

   output out;
   input  in, enable, clr, set, NOTIFIER;
   reg    out;

   table

      // in  enable  clr   set  NOT  : Qt : Qt+1
      //
      1  1   0   ?   ?   : ?  :  1  ; //
      0  1   ?   0   ?   : ?  :  0  ; //
      1  *   0   ?   ?   : 1  :  1  ; // reduce pessimism
      0  *   ?   0   ?   : 0  :  0  ; // reduce pessimism
      *  0   ?   ?   ?   : ?  :  -  ; // no changes when in switches
      ?  ?   ?   1   ?   : ?  :  1  ; // set output
      ?  0   0   *   ?   : 1  :  1  ; // cover all transistions on set
      1  ?   0   *   ?   : 1  :  1  ; // cover all transistions on set
      ?  ?   1   0   ?   : ?  :  0  ; // reset output
      ?  0   *   0   ?   : 0  :  0  ; // cover all transistions on clr
      0  ?   *   0   ?   : 0  :  0  ; // cover all transistions on clr
      ?  ?   ?   ?   *   : ?  :  x  ; // any notifier changed

   endtable
endprimitive // udp_tlat

primitive udp_mux2 (out, in0, in1, sel);
   output out;
   input  in0, in1, sel;

   table

      // in0 in1 sel :  out
      //
      1  ?  0 :  1 ;
      0  ?  0 :  0 ;
      ?  1  1 :  1 ;
      ?  0  1 :  0 ;
      0  0  x :  0 ;
      1  1  x :  1 ;

   endtable
endprimitive // udp_mux2

