
//__CDS_SVN_TAG__
// $URL: file:///projects/cdnsfs/svn_repo/ifss_vmgr_flow_proj/trunk/demo/SRC/RTL/mem_with_crc.sv $ $Id: mem_with_crc.sv 667 2016-11-15 17:44:59Z ferlini $
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

module mem_with_crc
    #(parameter DATA_WIDTH = 8,
        parameter POLYNOMIAL_BITS = 1
    )
    (
		input logic                        clk,                 //1
		input logic                        rst_n,               //1
		input logic                        mem_wr,              //1
		input logic [DATA_WIDTH-1:0]       mem_data_in,         //8
		input logic [POLYNOMIAL_BITS-1:0]  crc_data_in,         //1
		output logic [DATA_WIDTH-1:0]      mem_data_out,        //8
		output logic [POLYNOMIAL_BITS-1:0] crc_data_out         //1     ports_instrument = 1+1+1+8+1+8+1 = 21
   );

    //----------------------------------------------------------------------
    // Memory model: here just a register
    //----------------------------------------------------------------------
    logic [DATA_WIDTH-1:0] mem;                                 //8
    logic [POLYNOMIAL_BITS-1:0] mem_crc;                        //1

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            mem     <= '0;
			mem_crc <= '0;
        end
        else begin
            if (mem_wr) begin
                mem     <= mem_data_in;
                mem_crc <= crc_data_in;
			end
		end
	end

    assign mem_data_out = mem;
    assign crc_data_out = mem_crc;
    initial begin
    end
endmodule

