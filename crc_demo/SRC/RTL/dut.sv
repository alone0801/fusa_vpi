
//__CDS_SVN_TAG__
// $URL: file:///projects/cdnsfs/svn_repo/ifss_vmgr_flow_proj/trunk/demo/SRC/RTL/dut.sv $ $Id: dut.sv 667 2016-11-15 17:44:59Z ferlini $
// ------------------------------------------------------------------------------
// Copyright (c) 2016 by Cadence Design Systems, All Rights Reserved.
//
// This software is provided as is without warranty of any kind.  The entire risk
// as to the results and performance of this software is assumed by the user.
//
// Cadence Design Systems disclaims all warranties, either express or implied,
// including but not limited, the implied warranties of merchantability, fitness
// for a particular purpose, title and no infringement, with respect to this
// software.
//
// No technical support is guaranteed for this code. If you have any suggestion
// or improvement feel free to contact your Cadence representative.
// ------------------------------------------------------------------------------
//__CDS_SVN_TAG__

module dut
  (input logic clk,
   input logic 	       rst_n,

   // MEM1, 128-bit, ASILD,
   input logic 	       mem1_wr,
   input logic [31:0]  mem1_data_in,
   output logic [31:0] mem1_data_out ,
   output logic        mem1_err_detected,
   output logic        mem1_err_corrected,

   // MEM2, 64-bit, ASILB,
   input logic 	       mem2_wr,
   input logic [7:0]   mem2_data_in,
   output logic [7:0]  mem2_data_out ,
   output logic        mem2_err_detected,
   output logic        mem2_err_corrected

   );

   //----------------------------------------------------------------------
   // MEM 1
   //----------------------------------------------------------------------
   crc_mem
     #(.DATA_WIDTH      (32),
       .POLYNOMIAL_BITS (8),
       .OUTPUT_FF       (1)
       )
   mem1_i
     ( .clk           (clk),
       .rst_n         (rst_n),
       .mem_wr        (mem1_wr),
       .mem_data_in   (mem1_data_in),
       .mem_data_out  (mem1_data_out),
       .err_detected  (mem1_err_detected),
       .err_corrected (mem1_err_corrected)
       );


   //----------------------------------------------------------------------
   // MEM 2
   //----------------------------------------------------------------------
    crc_mem
     #(.DATA_WIDTH      (8),
       .POLYNOMIAL_BITS (4),
       .OUTPUT_FF       (0)
       )
   mem2_i
     ( .clk           (clk),
       .rst_n         (rst_n),
       .mem_wr        (mem2_wr),
       .mem_data_in   (mem2_data_in),
       .mem_data_out  (mem2_data_out),
       .err_detected  (mem2_err_detected),
       .err_corrected (mem2_err_corrected)
       );
endmodule // dut
