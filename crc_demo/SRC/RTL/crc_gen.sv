
//__CDS_SVN_TAG__
// $URL: file:///projects/cdnsfs/svn_repo/ifss_vmgr_flow_proj/trunk/demo/SRC/RTL/crc_gen.sv $ $Id: crc_gen.sv 667 2016-11-15 17:44:59Z ferlini $
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

module crc_gen
  #(parameter DATA_WIDTH = 8,
    parameter POLYNOMIAL_BITS = 1
    )

   (input logic clk,
    input logic 		 rst_n,
    input logic [DATA_WIDTH-1:0] data_in,
    output logic [POLYNOMIAL_BITS-1:0] crc_val
   );

   logic 			       d;
   integer 			       i, j;
   logic [POLYNOMIAL_BITS-1:0] 	       crc_tmp;

   //----------------------------------------------------------------------
   // Polynomilas
   //----------------------------------------------------------------------
   localparam logic [32:0] 	      CRC_1_PARITY  = 33'b000000000000000000000000000000011;
   localparam logic [32:0] 	      CRC_4_CCITT   = 33'b000000000000000000000000000010011;
   localparam logic [32:0] 	      CRC_5_USB     = 33'b000000000000000000000000000100101;
   localparam logic [32:0] 	      CRC_6_ITU     = 33'b000000000000000000000000001000111;
   localparam logic [32:0] 	      CRC_7_SD_CARD = 33'b000000000000000000000000010001001;
   localparam logic [32:0] 	      CRC_8_WCDMA   = 33'b000000000000000000000000110011011;
   localparam logic [32:0] 	      CRC_10_ATMA   = 33'b000000000000000000000011000110011;
   localparam logic [32:0] 	      CRC_12        = 33'b000000000000000000001100000001111;
   localparam logic [32:0] 	      CRC_15_CAN    = 33'b000000000000000001100010110011001;
   localparam logic [32:0] 	      CRC_16_ANSI   = 33'b000000000000000011000000000000101;
   localparam logic [32:0] 	      CRC_24_MODE_S = 33'b000000001111111111111010000001001;
   localparam logic [32:0] 	      CRC_32_IEEE   = 33'b100000100110000010001110110110111;

   logic [POLYNOMIAL_BITS:0] 	      polynomial;

   always_comb begin
      case (POLYNOMIAL_BITS)
	1  :  polynomial = CRC_1_PARITY;
	4  :  polynomial = CRC_4_CCITT;
	5  :  polynomial = CRC_5_USB;
	6  :  polynomial = CRC_6_ITU;
	7  :  polynomial = CRC_7_SD_CARD;
	8  :  polynomial = CRC_8_WCDMA;
	10 :  polynomial = CRC_10_ATMA;
	12 :  polynomial = CRC_12;
	15 :  polynomial = CRC_15_CAN;
	16 :  polynomial = CRC_16_ANSI;
	24 :  polynomial = CRC_24_MODE_S;
	32 :  polynomial = CRC_32_IEEE;

	default : begin
	   assert (1'b0) $error("-E- Unsupported Polynomial selected");
	end
      endcase
   end

   //----------------------------------------------------------------------
   // Parallel CRC calculation
   //----------------------------------------------------------------------
//   always_comb begin
    always @* begin
      // set default to all 1
      crc_tmp = '0;

      for (i=0; i < DATA_WIDTH; i=i+1) begin
	 d = data_in[DATA_WIDTH-1-i] ^ crc_tmp[POLYNOMIAL_BITS-1];

	 for (j=POLYNOMIAL_BITS-1; j>=0; j=j-1) begin

	    if (j==0) begin
	       crc_tmp[j] = d;     //二进制除法每次添0，而生成多项式一定为1，所以如果上次计算最高位相加为0就得添加0，相加为1就添0+1 = 1
	    end
	    else if (polynomial[j] == 1'b1) begin
	       crc_tmp[j] = crc_tmp[j-1] ^ d;  
	    end
	    else begin
	     crc_tmp[j] = crc_tmp[j-1];
	    end

	 end
      end
   end

   //----------------------------------------------------------------------
   // output
   //----------------------------------------------------------------------
   assign crc_val = crc_tmp;

endmodule // crc_gen
