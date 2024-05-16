//***********************************************************************************
// Encoder for DEC BCH code
// Version 0.2
// Modified 25.04.11
// Written by Ruslan Lepetenok (lepetenokr@yahoo.com)
//***********************************************************************************

//`ifndef C_DIS_DEFAULT_NETTYPE
 // All nets must be declared
// `default_nettype none
//`endif

//synthesis translate_off
`include "timescale.vh"
//synthesis translate_on

module bch_dec_enc_univ_top #(
	                        parameter P_D_WIDTH   = 16
	                        )
	                        (
							 input wire[P_D_WIDTH-1:0]                     d_i,
							 output wire[fn_ecc_synd_width(P_D_WIDTH)-1:0] p_o
							);

//####################################################################################							

`include "bch_dec_fn.vh"						

//####################################################################################							


 enc_synd_calc_univ #(
                      .P_D_WIDTH  (P_D_WIDTH),
                      .P_SYND_GEN (0)
                      )
enc_synd_calc_univ_inst(
					 .d_i (d_i),
					 .p_o (p_o)
					);

endmodule // bch_dec_enc_univ_top
