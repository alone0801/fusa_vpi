/*
* Wishbone BFM-based Memory Model
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

module wb_bfm_memory
 #(//Wishbone parameters
   parameter dw = 32,
   parameter aw = 32,
   parameter DEBUG = 0,
   // Memory parameters
   parameter memory_file = "",
   parameter mem_size_bytes = 32'h0000_8000, // 32KBytes
   parameter rd_min_delay = 0,
   parameter rd_max_delay = 4)
  (input 	   wb_clk_i,
   input 	   wb_rst_i,
   
   input [aw-1:0]  wb_adr_i,
   input [dw-1:0]  wb_dat_i,
   input [dw/8-1:0] 	   wb_sel_i,
   input 	   wb_we_i,
   input [1:0] 	   wb_bte_i,
   input [2:0] 	   wb_cti_i,
   input 	   wb_cyc_i,
   input 	   wb_stb_i,
   
   output 	   wb_ack_o,
   output 	   wb_err_o,
   output 	   wb_rty_o,
   output [dw-1:0] wb_dat_o);

`include "wb_common.v"
   
   localparam bytes_per_dw = (dw/8);
   localparam mem_words = (mem_size_bytes/bytes_per_dw);   

   localparam ADR_LSB = $clog2(bytes_per_dw);

   //Counters for read and write accesses
   integer 		   reads  = 0;
   integer 		   writes = 0;

   // synthesis attribute ram_style of mem is block
   reg [dw-1:0] 	mem [ 0 : mem_words-1 ]   /* verilator public */ /* synthesis ram_style = no_rw_check */;

   wb_bfm_slave
     #(.aw (aw),
       .dw (dw),
       .DEBUG (DEBUG))
   bfm0
     (.wb_clk   (wb_clk_i),
      .wb_rst   (wb_rst_i),
      .wb_adr_i (wb_adr_i),
      .wb_dat_i (wb_dat_i),
      .wb_sel_i (wb_sel_i),
      .wb_we_i  (wb_we_i), 
      .wb_cyc_i (wb_cyc_i),
      .wb_stb_i (wb_stb_i),
      .wb_cti_i (wb_cti_i),
      .wb_bte_i (wb_bte_i),
      .wb_dat_o (wb_dat_o),
      .wb_ack_o (wb_ack_o),
      .wb_err_o (wb_err_o),
      .wb_rty_o (wb_rty_o));

   reg [aw-1:0] 	address;
   reg [dw-1:0] 	data;

   integer 		i;
   integer 		delay;
   integer 		seed;
   
   always begin
      bfm0.init();
      address = bfm0.address; //Fetch start address

      if(bfm0.op === WRITE)
	writes = writes + 1;
      else
	reads = reads + 1;
      while(bfm0.has_next) begin
	 //Set error on out of range accesses
	 if(address[31:ADR_LSB] > mem_words) begin
	    $display("%0d : Error : Attempt to access %x, which is outside of memory", $time, address);
	    bfm0.error_response();
	 end else begin
	    if(bfm0.op === WRITE) begin
	       bfm0.write_ack(data);
	       if(DEBUG) $display("%d : ram Write 0x%h = 0x%h %b", $time, address, data, bfm0.mask);
	       for(i=0;i < dw/8; i=i+1)
		 if(bfm0.mask[i])
		   mem[address[31:ADR_LSB]][i*8+:8] = data[i*8+:8];
	    end else begin
	       data = {aw{1'b0}};
	       for(i=0;i < dw/8; i=i+1)
		 if(bfm0.mask[i])
		   data[i*8+:8] = mem[address[31:ADR_LSB]][i*8+:8];
	       if(DEBUG) $display("%d : ram Read  0x%h = 0x%h %b", $time, address, data, bfm0.mask);
	       delay = $dist_uniform(seed, rd_min_delay, rd_max_delay);
	       repeat(delay) @(posedge wb_clk_i);
	       bfm0.read_ack(data);
	    end
	 end
	 if(bfm0.cycle_type === BURST_CYCLE)
	   address = wb_next_adr(address, wb_cti_i, wb_bte_i, dw);
      end
   end

endmodule // wb_bfm_memory
