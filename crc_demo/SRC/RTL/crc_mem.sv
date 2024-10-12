
//__CDS_SVN_TAG__
// $URL: file:///projects/cdnsfs/svn_repo/ifss_vmgr_flow_proj/trunk/demo/SRC/RTL/crc_mem.sv $ $Id: crc_mem.sv 667 2016-11-15 17:44:59Z ferlini $
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

module crc_mem
  #(parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8,
    parameter POLYNOMIAL_BITS = 1,
    parameter OUTPUT_FF = 1
    )

  (input logic clk,
   input logic 			 rst_n,
   input logic 			 mem_wr,
   input logic [ADDR_WIDTH-1:0]  mem_addr,
   input logic [DATA_WIDTH-1:0]  mem_data_in,
   output logic [DATA_WIDTH-1:0] mem_data_out ,
   output logic 		 err_detected,
   output logic 		 err_corrected
   );

   //----------------------------------------------------------------------
   // Intermediat signals for calculation
   //----------------------------------------------------------------------
   logic [POLYNOMIAL_BITS-1:0] crc_wr;
   logic [DATA_WIDTH-1:0] mem_data_tmp;
   logic [DATA_WIDTH-1:0] mem_data_ff_tmp;


   //----------------------------------------------------------------------
   // Memory model: here just a register
   //----------------------------------------------------------------------
   logic [DATA_WIDTH-1:0] mem;
   logic [POLYNOMIAL_BITS-1:0] mem_crc;

   mem_with_crc
     #(.DATA_WIDTH      (DATA_WIDTH),
       .POLYNOMIAL_BITS (POLYNOMIAL_BITS),
       .ADDR_WIDTH      (ADDR_WIDTH)
       )
   mem_with_crc_i
     (.clk          (clk),
      .rst_n        (rst_n),
      .mem_wr       (mem_wr),
      .mem_addr     (mem_addr),
      .mem_data_in  (mem_data_in),
      .crc_data_in  (crc_wr),
      .mem_data_out (mem),
      .crc_data_out (mem_crc)
   );

   //----------------------------------------------------------------------
   // CRC generation for storing data in MEM
   //----------------------------------------------------------------------
   crc_gen
     #(.DATA_WIDTH      (DATA_WIDTH),
       .POLYNOMIAL_BITS (POLYNOMIAL_BITS)
       )
   crc_gen_wr_i
     (.clk     (clk),
      .rst_n   (rst_n),
      .data_in (mem_data_in),
      .crc_val (crc_wr)
      );

   //----------------------------------------------------------------------
   // CRC error detection and correction
   //----------------------------------------------------------------------
   crc_chk
     #(.DATA_WIDTH      (DATA_WIDTH),
       .POLYNOMIAL_BITS (POLYNOMIAL_BITS)
       )
   crc_chk_i
     (.clk           (clk),
      .rst_n         (rst_n),
      .data_in       (mem),
      .crc_in        (mem_crc),
      .data_out      (mem_data_tmp),
      .err_detected  (err_detected),
      .err_corrected (err_corrected)
      );

   //----------------------------------------------------------------------
   // Output DFF stage for data if selected
   //----------------------------------------------------------------------
   always @(posedge clk or negedge rst_n) begin
      if (~rst_n) begin
	 mem_data_ff_tmp  <= '0;
      end
      else begin
	 mem_data_ff_tmp  <= mem_data_tmp;
      end
   end

   assign mem_data_out = (OUTPUT_FF == 1) ? mem_data_ff_tmp : mem_data_tmp;


endmodule // crc_mem

