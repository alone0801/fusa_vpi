//***********************************************************************************
// Parity generator / Syndrome generator for DEC BCH code
// Version 0.4
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

module enc_synd_calc_univ #(
	                        parameter P_D_WIDTH   = 16,
	                        parameter P_SYND_GEN  = 1   // 0 -> parity generator, 1-> syndrome generator 
	                        )
	                        (
							 input wire[fn_calc_dat_ecc_width(P_D_WIDTH,P_SYND_GEN)-1:0] d_i,
							 output wire[fn_ecc_synd_width(P_D_WIDTH)-1:0]               p_o
							);

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~							

`include "bch_dec_fn.vh" 							

// Encoder/Syndrome calculation functions 

`include "enc_synd_gen_fn_31.vh"
`include "enc_synd_gen_fn_63.vh"
`include "enc_synd_gen_fn_127.vh"
`include "enc_synd_gen_fn_255.vh" 

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

// Internal data bus
localparam LP_INT_DATA_BUS_WIDTH = fn_int_width(P_D_WIDTH);
wire[LP_INT_DATA_BUS_WIDTH-1:0] dat_int; 

// Difference between internal and external data buses
localparam LP_DB_DIFF = LP_INT_DATA_BUS_WIDTH-fn_calc_dat_ecc_width(P_D_WIDTH,P_SYND_GEN);

//----------------------------------------------------------------------------------------

generate
 if(!LP_DB_DIFF) begin : db_width_matches
  assign dat_int = d_i;	
 end // db_width_matches
 else begin : db_width_does_not_match
 if(P_SYND_GEN) begin : synd_gen_impl	
  assign dat_int = {d_i,{LP_DB_DIFF{1'b0}}}; // Syndrome generation	 
 end // synd_gen_impl
 else begin : ecc_gen_impl
  assign dat_int = {{LP_DB_DIFF{1'b0}},d_i}; // ECC generation 
 end // ecc_gen_impl	 
 end // db_width_does_not_match	 
 
 // Encoder / Decoder
 if(LP_INT_DATA_BUS_WIDTH == 31) begin : enc_dcd_gf5
  assign p_o =	fn_bch_dec_gf5(dat_int);
 end // enc_dcd_gf5
 else if(LP_INT_DATA_BUS_WIDTH == 63) begin : enc_dcd_gf6 
  assign p_o =	fn_bch_dec_gf6(dat_int);
 end	 
 else if(LP_INT_DATA_BUS_WIDTH == 127) begin : enc_dcd_gf7 
  // Not implemented for the moment	 
  assign p_o = fn_bch_dec_gf7(dat_int); // {LP_INT_DATA_BUS_WIDTH{1'b0}};
 end	  
 else if(LP_INT_DATA_BUS_WIDTH == 255) begin : enc_dcd_gf8 
  // Not implemented for the moment	 	 
  assign p_o = fn_bch_dec_gf8(dat_int); // {LP_INT_DATA_BUS_WIDTH{1'b0}};
 end	   
 
endgenerate

endmodule // enc_synd_calc_univ
