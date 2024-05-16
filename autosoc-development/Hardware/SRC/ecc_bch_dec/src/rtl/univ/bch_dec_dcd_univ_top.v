//***********************************************************************************
// Decoder top for DEC BCH code
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


module bch_dec_dcd_univ_top #(parameter P_D_WIDTH = 32) 
	                (
					 input  wire[P_D_WIDTH-1:0]                     d_i,
					 input  wire[fn_ecc_synd_width(P_D_WIDTH)-1:0]  ecc_i, 
					 output wire[P_D_WIDTH-1:0]                     msk_o, 
					 output wire                                    err_det_o
					 );
					 
//######################################################################					 

`include "bch_dec_fn.vh"

//######################################################################					 
				 
wire[fn_ecc_synd_width(P_D_WIDTH)-1:0]           syndromes;

//****** *************************************************************************************					 

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//                      Syndrome generator
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

       enc_synd_calc_univ #(
	                        .P_D_WIDTH   (P_D_WIDTH),
	                        .P_SYND_GEN  (1)           // 0 -> parity generator, 1-> syndrome generator 
	                        )
	 enc_synd_calc_univ_inst(
							 .d_i ({d_i,ecc_i}),
							 .p_o (syndromes)
							);

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//                      Error pattern decoder
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@							
							
       err_pat_dcd_rom_univ #(
	                         .P_D_WIDTH   (P_D_WIDTH)
	                         )
    err_pat_dcd_rom_univ_inst(
	                          .syndromes_i (syndromes),
						      .msk_o 	   (msk_o)
	                          );

assign err_det_o = |syndromes;

endmodule // bch_dec_dcd_univ_top
