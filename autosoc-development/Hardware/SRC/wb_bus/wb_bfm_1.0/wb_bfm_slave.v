/*
* Wishbone Slave BFM
* Copyright (C) 2013-2015 Olof Kindgren <olof.kindgren@gmail.com>
*
* This library is free software; you can redistribute it and/or
* modify it under the terms of the GNU Lesser General Public
* License as published by the Free Software Foundation; either
* version 2.1 of the License, or (at your option) any later version.
*
* This library is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
* Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public
* License along with this library; if not, write to the Free Software
* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
*/

module wb_bfm_slave
  #(parameter dw = 32,
    parameter aw = 32,
    parameter DEBUG = 0)
   (input                  wb_clk,
    input 		wb_rst,
    input [aw-1:0] 	wb_adr_i,
    input [dw-1:0] 	wb_dat_i,
    input [dw/8-1:0] 	wb_sel_i,
    input 		wb_we_i,
    input 		wb_cyc_i,
    input 		wb_stb_i,
    input [2:0] 	wb_cti_i,
    input [1:0] 	wb_bte_i,
    output reg [dw-1:0] wb_dat_o,
    output reg 		wb_ack_o,
    output reg 		wb_err_o,
    output reg 		wb_rty_o);

`include "wb_common.v"

   localparam Tp = 1;
   
   reg 			   has_next = 1'b0;

   reg 			   op = READ;
   reg [aw-1:0] 	   address;
   reg [dw-1:0] 		   data;
   reg [dw/8-1:0] 		   mask;
   reg 			   cycle_type;
   reg [2:0] 		   burst_type;

   reg 			   err = 0;
   
   task init;
      begin
	 wb_ack_o <= #Tp 1'b0;
	 wb_dat_o <= #Tp {dw{1'b0}};
	 wb_err_o <= #Tp 1'b0;
	 wb_rty_o <= #Tp 1'b0;

	 if(wb_rst !== 1'b0) begin
	    if(DEBUG) $display("%0d : waiting for reset release", $time);
	    @(negedge wb_rst);
	    @(posedge wb_clk);
	    if(DEBUG) $display("%0d : Reset was released", $time);
	 end

	 //Catch start of next cycle
	 if (!wb_cyc_i)
	   @(posedge wb_cyc_i);
	 @(posedge wb_clk);
	 
	 //Make sure that wb_cyc_i is still asserted at next clock edge to avoid glitches
	 while(wb_cyc_i !== 1'b1)
	   @(posedge wb_clk);
	 if(DEBUG) $display("%0d : Got wb_cyc_i", $time);

	 cycle_type = get_cycle_type(wb_cti_i);
	 
	 op      = wb_we_i;
	 address = wb_adr_i;
	 mask    = wb_sel_i;

	 has_next = 1'b1;
      end
   endtask

   task error_response;
      begin
	 err = 1'b1;
	 next();
	 err = 1'b0;
      end
   endtask

   task read_ack;
      input [dw-1:0] data_i;
      begin

	 data = data_i;
	 next();
      end
   endtask

   task write_ack;
      output [dw-1:0] data_o;
      begin
	 if(DEBUG) $display("%0d : Write ack", $time);
	 next();
	 data_o = data;
      end
   endtask
   
      
   task next;
      begin
	 if(DEBUG) $display("%0d : next address=0x%h, data=0x%h, op=%b", $time, address, data, op);

	 wb_dat_o <= #Tp {dw{1'b0}};
	 wb_ack_o <= #Tp 1'b0;
	 wb_err_o <= #Tp 1'b0;
	 wb_rty_o <= #Tp 1'b0; //TODO : rty not supported

	 if(err) begin
	    if(DEBUG) $display("%0d, Error", $time);
	    wb_err_o <= #Tp 1'b1;
	    has_next = 1'b0;
	 end else begin
	    if(op === READ)
	      wb_dat_o <= #Tp data;
	    wb_ack_o <= #Tp 1'b1;
	 end

	 @(posedge wb_clk);

	 wb_ack_o <= #Tp 1'b0;
	 wb_err_o <= #Tp 1'b0;

	 has_next = !wb_is_last(wb_cti_i) & !err;

	 if(op === WRITE) begin
	   data = wb_dat_i;
	    mask = wb_sel_i;
	 end
	 address = wb_adr_i;
	 
      end
   endtask

endmodule
