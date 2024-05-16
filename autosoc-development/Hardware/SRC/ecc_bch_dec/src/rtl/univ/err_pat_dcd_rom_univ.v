//***********************************************************************************
// Error pattern decoder for DEC BCH code
// Version 0.3
// Modified 26.04.11
// Written by Ruslan Lepetenok (lepetenokr@yahoo.com)
//*********************************************************************************** 

//`ifndef C_DIS_DEFAULT_NETTYPE
 // All nets must be declared
// `default_nettype none
//`endif

//synthesis translate_off
`include "timescale.vh"
//synthesis translate_on

module err_pat_dcd_rom_univ #(
	                          parameter P_D_WIDTH = 16
	                         )
	                         (
	                          input  wire[fn_ecc_synd_width(P_D_WIDTH)-1:0] syndromes_i,
						      output wire[P_D_WIDTH-1:0]                    msk_o 
	                          );
						
//######################################################################					 

`include "bch_dec_fn.vh"

`include "err_patt_dcd_fn_31.vh"
`include "err_patt_dcd_fn_63.vh"
`include "err_patt_dcd_fn_127.vh"
`include "err_patt_dcd_fn_255.vh"

//######################################################################						


// Internal mask bus
localparam LP_INT_MASK_BUS_WIDTH = fn_int_width(P_D_WIDTH);
wire[LP_INT_MASK_BUS_WIDTH-1:0] msk_int; 

generate
/*
 if(LP_INT_MASK_BUS_WIDTH == 31) begin : enc_dcd_gf5
  assign msk_int =	fn_err_pat_dcd_gf5_rom(syndromes_i);
 end // enc_dcd_gf5
 else if(LP_INT_MASK_BUS_WIDTH == 63) begin : enc_dcd_gf6 
  assign msk_int =	fn_err_pat_dcd_gf6_rom(syndromes_i);
 end // enc_dcd_gf6	 
 else if(LP_INT_MASK_BUS_WIDTH == 127) begin : enc_dcd_gf7 
  assign msk_int = fn_err_pat_dcd_gf7_rom(syndromes_i); 
 end // enc_dcd_gf7	
 // Comment the following lines if you have a problems
 // with the synthisizer(due to the size of err_patt_dcd_fn_255.vh)	 
 else if(LP_INT_MASK_BUS_WIDTH == 255) begin : enc_dcd_gf8 
  assign msk_int = fn_err_pat_dcd_gf8_rom(syndromes_i); 
 end // enc_dcd_gf8	   
 */
 assign msk_int = 'b0;
endgenerate

//  assign msk_o = msk_int[P_D_WIDTH-1:0];	 
  assign msk_o = msk_int[LP_INT_MASK_BUS_WIDTH-1:LP_INT_MASK_BUS_WIDTH-P_D_WIDTH];	 

endmodule // err_pat_dcd_rom_univ
