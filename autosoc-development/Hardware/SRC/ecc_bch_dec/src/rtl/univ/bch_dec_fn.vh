
//*********************************************************************************
// Filename : bch_dec_fn.vh
// Version 0.2
// Modified 25.04.11
// Written by Ruslan Lepetenok (lepetenokr@yahoo.com)
//*********************************************************************************

// Replacement for 2**n expression
function integer fn_pwr_of_two;
input integer arg;

integer i;
integer	result;
begin
 result = 1;	
 for(i=0;i<arg;i=i+1)
  result = result * 2;	
  
 fn_pwr_of_two = result;
end
endfunction // fn_pwr_of_two;	

// Calculates m for given data width and t(number of correctable errors)
function integer fn_gf_m;
input integer d_width;
input integer t;           
			
integer i;
integer tmp;
integer done; 
begin
 tmp = 0;
 done = 0;
 for(i=0;i<17;i=i+1) begin
  if(fn_pwr_of_two(i)-1-t*i >= d_width) begin 
   if(!done) begin tmp = i; done = 1; end 
  end
 end
	  
  fn_gf_m = tmp;	  
end
endfunction // fn_gf_m


// Calculate the length of ecc/syndromes 
function integer fn_ecc_synd_width;
input integer d_width;
begin
  fn_ecc_synd_width = fn_gf_m(d_width, 2) * 2;	  
end
endfunction // fn_ecc_synd_width


// Calculates the length of the data or data + ecc input							
function integer fn_calc_dat_ecc_width;
input integer d_width;
input integer synd_gen;

integer tmp;
begin
 if(synd_gen) begin
  tmp = d_width + fn_ecc_synd_width(d_width);
 end
 else begin
  tmp = d_width;	 
 end
 fn_calc_dat_ecc_width = tmp;
end
endfunction // fn_calc_dat_ecc_width


// Calculate the width of internal data bus  
function integer fn_int_width;
input integer d_width;
begin
  fn_int_width = fn_pwr_of_two(fn_gf_m(d_width, 2)) - 1;	  
end
endfunction // fn_int_width


//*********************************************************************************















































