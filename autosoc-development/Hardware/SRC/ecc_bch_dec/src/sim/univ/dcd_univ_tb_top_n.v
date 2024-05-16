

`ifndef C_DIS_DEFAULT_NETTYPE
 // All nets must be declared
 `default_nettype none
`endif

`timescale 1 ns / 1 ps

//`define C_DEBUG TRUE
//`define C_RANDOM_TEST TRUE

//`define C_NO_ENCODER TRUE

module dcd_univ_tb_top_n;
	
`include "../../rtl/univ/bch_dec_fn.vh"	
	
localparam LP_NUM_OF_REP = 8192; 	
	
localparam LP_D_WIDTH = 16; // 255-2*8; // 127-2*7; //63-2*6; //31-2*5;	

localparam LP_SYNDROMES_WIDTH = fn_ecc_synd_width(LP_D_WIDTH);

//                                (LP_D_WIDTH == 8) ?   (3+1) * 2 :
//                                (LP_D_WIDTH == 16) ?  (4+1) * 2 : 					 
//                                (LP_D_WIDTH == 32) ?  (5+1) * 2 : 					 								
//                                (LP_D_WIDTH == 64) ?  (6+1) * 2 : 					 																
//                                (LP_D_WIDTH == 128) ? (7+1) * 2 : 0; 
							  	
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^								
								
// Decoder related signals								
reg[LP_D_WIDTH-1:0]          dcd_d_i;     
reg[LP_SYNDROMES_WIDTH-1:0]  dcd_ecc_i;
wire[LP_D_WIDTH-1:0]         dcd_msk_o;
wire                         dcd_err_det_o;	

// Encoder related signals								
reg[LP_D_WIDTH-1:0]          enc_d_i;  
wire[LP_SYNDROMES_WIDTH-1:0] enc_ecc_o; 


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`ifdef C_NO_ENCODER

assign enc_ecc_o = {LP_SYNDROMES_WIDTH{1'b0}};

`else

     bch_dec_enc_univ_top #(
	                       .P_D_WIDTH(LP_D_WIDTH)
	                       )
  bch_dec_enc_univ_top_inst(
							.d_i (enc_d_i),
							.p_o (enc_ecc_o)              
							);					 

`endif							
							
	   		  
bch_dec_dcd_univ_top #(
                       .P_D_WIDTH(LP_D_WIDTH)
                       ) 
bch_dec_dcd_univ_top_inst(
					      .d_i       (dcd_d_i      ),
					      .ecc_i     (dcd_ecc_i    ), // TBD					
					      .msk_o     (dcd_msk_o    ), // TBD
					      .err_det_o (dcd_err_det_o)
					      );					 
					 
					 
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

//Input: Data (16 bits)
//Output: ECC (10 bits)

reg [LP_D_WIDTH-1:0]  data_for_enc;
reg [LP_SYNDROMES_WIDTH-1:0]  ecc_calc;

task tsk_set_data;
input[LP_D_WIDTH-1:0]  data;
begin
`ifdef C_NO_ENCODER	
 data_for_enc = {LP_D_WIDTH{1'b0}};
`else
 data_for_enc = data;
`endif 
 
end
endtask // tsk_set_data

task tsk_encode;
begin
 enc_d_i = data_for_enc;
 #1;
 ecc_calc = enc_ecc_o; // Get ECC
end
endtask // tsk_encode

// Inject errors
//Input: Data (16 bits) + ECC (10 bits)
//Output: Data (16 bits) + ECC (10 bits)

reg [LP_D_WIDTH-1:0]                     data_for_dcd; // Corrupted Data 
reg [LP_SYNDROMES_WIDTH-1:0]             ecc_for_dcd;  // Corrupted ECC

task tsk_data_ecc;
begin
 data_for_dcd = data_for_enc; 
 ecc_for_dcd  = ecc_calc;  
end
endtask // tsk_data_ecc

integer err_loc1;
integer err_loc2;

task tsk_set_err_loc;
input integer loc1;
input integer loc2;
begin
 err_loc1 = loc1;
 err_loc2 = loc2;
end
endtask // tsk_set_err_loc

integer stat_dcd_no_errs;
integer stat_dcd_corrected;
integer stat_dcd_faults;

reg [LP_D_WIDTH-1:0]         stat_data_err_pos;
reg [LP_SYNDROMES_WIDTH-1:0] stat_ecc_err_pos;

task tsk_inj_sing_err;
input integer err_loc;
begin					  
 if(err_loc < LP_D_WIDTH) begin  data_for_dcd[err_loc] = ~data_for_dcd[err_loc]; stat_data_err_pos[err_loc] = 1'b1; end
 else if(err_loc < LP_D_WIDTH + LP_SYNDROMES_WIDTH) begin ecc_for_dcd[err_loc-LP_D_WIDTH] = ~ecc_for_dcd[err_loc-LP_D_WIDTH]; stat_ecc_err_pos[err_loc-LP_D_WIDTH] = 1'b1; end	
end	
endtask // tsk_inj_sing_err

task tsk_inj_errs;
begin
 if(err_loc1 !== err_loc2) begin	
  tsk_inj_sing_err(err_loc1);
  tsk_inj_sing_err(err_loc2);
 end 
 else begin 
  tsk_inj_sing_err(err_loc1);
 end  
end
endtask // tsk_inj_errs

// Decode
//Input:  Data (16 bits) + ECC (10 bits)
//Output: Data (16 bits)

task tsk_decode;
begin
 dcd_d_i   = data_for_dcd;    
 dcd_ecc_i = ecc_for_dcd;   	
 #1;	
end
endtask // tsk_decode

// Compare (Data/Errors)

task tsk_init_stat;
begin
stat_dcd_no_errs   = 0;  	
stat_dcd_corrected = 0;	
stat_dcd_faults    = 0 ;   	

stat_data_err_pos  = {LP_D_WIDTH{1'b0}};
stat_ecc_err_pos   = {LP_SYNDROMES_WIDTH{1'b0}};
end	
endtask // tsk_init_stat

task tsk_comp;
begin
 if(dcd_err_det_o === 1'b0)	stat_dcd_no_errs = stat_dcd_no_errs + 1;
 if((dcd_msk_o ^ data_for_dcd) === data_for_enc) stat_dcd_corrected = stat_dcd_corrected + 1;
 if((dcd_msk_o ^ data_for_dcd) !== data_for_enc) stat_dcd_faults = stat_dcd_faults + 1;
	 
`ifdef C_DEBUG 
 $display ("%m. Mask = %b.",dcd_msk_o);
 $display ("%m. Data = %b. Data = %b ",data_for_enc,data_for_dcd);
`endif	 
	 
end	
endtask // tsk_comp

task tsk_disp_info;
begin
 $display("***********************************************");
 $display("BCH DEC Encoder / Decoder test.");
 $display("Memory data width = %d.",LP_D_WIDTH);    
 $display("Num. of ECC bits = %d.",LP_SYNDROMES_WIDTH);		 
 $display("***********************************************");
end	
endtask // tsk_disp_info


task tsk_disp_stat;
begin
 $display("***********************************************");	
 $display("stat_dcd_no_errs   = %d.",stat_dcd_no_errs);    
 $display("Num. of succefully corrected errors = %d.",stat_dcd_corrected);      
 $display("Num. of decoder faults              = %d.",stat_dcd_faults);         
 $display("Tested error positions (Data bits)  = %b.",stat_data_err_pos);     
 $display("Tested error positions (ECC bits)   = %b.",stat_ecc_err_pos);      
 $display("***********************************************");
end	
endtask // tsk_disp_stat

//??????????

task tsk_rnd_err_loc;
begin			
 err_loc1 = $urandom % (LP_D_WIDTH + LP_SYNDROMES_WIDTH);
 err_loc2 = $urandom % (LP_D_WIDTH + LP_SYNDROMES_WIDTH);

`ifdef C_DEBUG 
 $display ("%m. err_loc1 = %d. err_loc2 = %d.",err_loc1,err_loc2);
`endif
 
 
end
endtask // tsk_rnd_err_loc


task tsk_disp_syndromes;
begin			
 $display("Syndromes = %x.",bch_dec_dcd_univ_top_inst.enc_synd_calc_univ_inst.p_o);
end
endtask // tsk_disp_syndromes



//{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{{	

initial begin
  tsk_init_stat;	
  
`ifdef C_RANDOM_TEST
 $display("Random test.");
 tsk_disp_info;
 repeat(LP_NUM_OF_REP) begin  
//  tsk_set_data(0); 
  tsk_set_data(16'hADC6); 
  tsk_encode;
  tsk_data_ecc;
//  tsk_set_err_loc(0,19);tsk_set_err_loc(4,19);	
  tsk_rnd_err_loc;
  tsk_inj_errs;
  tsk_decode;
  tsk_disp_syndromes;
  tsk_comp;
  end  
  tsk_disp_stat;
  //tsk_disp_syndromes;
  $stop; //???
  `else
  
  $display("Full test.");
  tsk_disp_info;
  for(err_loc1=0;err_loc1<(LP_D_WIDTH + LP_SYNDROMES_WIDTH);err_loc1=err_loc1+1)begin 
   for(err_loc2=0;err_loc2<(LP_D_WIDTH + LP_SYNDROMES_WIDTH);err_loc2=err_loc2+1)begin    	 
    tsk_set_data(32'hFDBCADC6); 
    tsk_encode;
    tsk_data_ecc;	
    tsk_inj_errs;
    tsk_decode;
	tsk_disp_syndromes;
    tsk_comp;	
   end	   
  end
  
   tsk_disp_stat;
   $stop; //???  
 `endif    
  
end	


endmodule // dcd_univ_tb_top_n
