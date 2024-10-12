
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
    #(  parameter DATA_WIDTH = 8,
        parameter POLYNOMIAL_BITS = 1 ,
        parameter ADDR_WIDTH = 8
    )
    (
		input logic                        clk,
		input logic                        rst_n,
		input logic                        mem_wr,
        input logic [ADDR_WIDTH-1:0]       mem_addr,
		input logic [DATA_WIDTH-1:0]       mem_data_in,
		input logic [POLYNOMIAL_BITS-1:0]  crc_data_in,
		output logic [DATA_WIDTH-1:0]      mem_data_out,
		output logic [POLYNOMIAL_BITS-1:0] crc_data_out
   );
    parameter DEPTH_WIDTH = 2 ** ADDR_WIDTH ;
    //bin2onhot();
    logic [DATA_WIDTH-1:0] mem [0:DEPTH_WIDTH-1];
    logic [POLYNOMIAL_BITS-1:0] mem_crc [0:DEPTH_WIDTH-1];

    genvar i;
    generate 
        for(i=0;i<DEPTH_WIDTH;i=i+1) begin
            always @(posedge clk or negedge rst_n) begin
                if (~rst_n) begin
                    mem[i]     <= '0;
	        		mem_crc[i] <= '0;
                end
                else begin
                    if (mem_wr&&(mem_addr==i)) begin
                        mem[i]     <= mem_data_in;
                        mem_crc[i] <= crc_data_in;
	        		end
	        	end
	        end
        end
    endgenerate
    assign mem_data_out = mem[mem_addr];
    assign crc_data_out = mem_crc[mem_addr];
    

endmodule

