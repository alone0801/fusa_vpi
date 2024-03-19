
//__CDS_SVN_TAG__
// $URL: file:///projects/cdnsfs/svn_repo/ifss_vmgr_flow_proj/trunk/demo/SRC/RTL/crc_chk.sv $ $Id: crc_chk.sv 667 2016-11-15 17:44:59Z ferlini $
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

module crc_chk
   #(
        parameter DATA_WIDTH = 8,
        parameter POLYNOMIAL_BITS = 1
    )
    (
        input  logic clk,
		input  logic rst_n,
        input  logic [DATA_WIDTH-1:0] data_in,
        input  logic [POLYNOMIAL_BITS-1:0] crc_in,
        output logic [DATA_WIDTH-1:0] data_out,
        output logic err_detected,
        output logic err_corrected
    );

    logic [POLYNOMIAL_BITS-1:0] crc_calc;
    logic err_detected_tmp;


    //----------------------------------------------------------------------
    // CRC generation
    //----------------------------------------------------------------------
    crc_gen
        #(
			.DATA_WIDTH      (DATA_WIDTH),
			.POLYNOMIAL_BITS (POLYNOMIAL_BITS)
        ) crc_gen_i (
			.clk     (clk),
			.rst_n   (rst_n),
			.data_in (data_in),
			.crc_val (crc_calc)
		);

    //----------------------------------------------------------------------
    // Error detection
    //----------------------------------------------------------------------
    always_comb begin
	     if (crc_calc == crc_in) err_detected_tmp = 1'b0;
         else                    err_detected_tmp = 1'b1;
    end

    //----------------------------------------------------------------------
    // No Error correction so far
    //----------------------------------------------------------------------

    //----------------------------------------------------------------------
    // Outputs :
    //   data registered by selection
    //   check always registered
    //----------------------------------------------------------------------
    // checker
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
	         err_detected  <= 1'b0;
	         err_corrected <= 1'b0;
		end
        else err_detected  <= err_detected_tmp;
	end
    initial begin
        err_detected <= 0;
    end
    assign data_out = data_in;

    //----------------------------------------------------------------------
    // Assertion nas checker
    //----------------------------------------------------------------------
    // Assert, that if an error is corrceted, it is also detected
    // assert_each_corrected_error_is_detected : assert property
    // (@(posedge clk)
    // disable iff (rst_n == 1'b0)
    // (err_corrected) |-> (err_detected)
    // );

    // Assert, that if an error is corrceted, it is also detected
    // assert_each_detected_error_is_not_corrected : assert property
    // (@(posedge clk)
    // disable iff (rst_n == 1'b0)
    // (err_detected) |-> (err_corrected)
    // );


    // always @(posedge clk or negedge rst_n) begin
    //     if(err_corrected&err_detected) ;
    //     else $error;
    // end

    // always @(posedge clk or negedge rst_n) begin
    //     if(err_detected&err_corrected) ;
    //     else $error;
    // end
endmodule // crc_chk


