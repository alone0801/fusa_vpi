/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: Memory Model including ECC correction per word

  For more information access: http://www.autosoc.org

***************************************************************************** */

module wb_ram_ecc
#(
    parameter depth =256,
    parameter dw    = 32
)
(
    input clk,
    input [3:0]	 we,
    input [31:0]  din,
    input [$clog2(depth)-1:0] 	 waddr,
    input [$clog2(depth)-1:0] 	 raddr,
    output [31:0] dout
);

    // Memory Registers
   reg [31:0] 	 mem    [0:depth-1];
   reg [11:0] 	 memEcc [0:depth-1];
   reg  	 memEccEn [0:depth-1];
   
    // ECC signature has 12 bits for a 32 bits dataword memory
    wire [11:0] calcEccSignature;
    reg [11:0]  storedEccSignature;

    wire [dw-1:0]    eccDataInput;

    // Error Detection Logic
    reg             eccMaskEnable;
    wire            eccErrorDetected;
    wire [dw-1:0]   eccErrorMask;

    // Data out correction
    reg [31:0]  dataFromMemory;

    // Memory Access Control Logic
    always @(posedge clk) begin
        if (we[0]) mem[waddr][7:0]   <= din[7:0];
        if (we[1]) mem[waddr][15:8]  <= din[15:8];
        if (we[2]) mem[waddr][23:16] <= din[23:16];
        if (we[3]) mem[waddr][31:24] <= din[31:24];
        dataFromMemory <= mem[raddr];
    end

    //Get updated Data from memory
    assign eccDataInput = din;

    // ECC Memory Control Logic
    always @(posedge clk) begin
        // Store ECC
        if (we == 4'hF) memEcc[waddr]   <= calcEccSignature;
        if (we == 4'hF) 
            memEccEn[waddr] <= 1'b1;
        else 
            if ((we > 4'h0) && (we < 4'hF)) memEccEn[waddr] <= 1'b0;
        // Read ECC
        storedEccSignature  <= memEcc[raddr];
        eccMaskEnable       <= memEccEn[raddr];
    end

    // Output data with ECC Correction
    assign dout = (eccMaskEnable) ? (dataFromMemory ^ eccErrorMask) : dataFromMemory;

    // Debug
    //assign debug_dout = (dout != dataFromMemory) ? 1'b1 : 1'b0;
    //assign debug_we = (we == 4'h1) ? 1'b1 : 1'b0;

//####################################################################################
// ECC Signature Calculation Logic

    // ECC Encoder Mapping
    bch_dec_enc_univ_top
    #(
        // Memory data word size
        .P_D_WIDTH  (dw)
    )
    memecc_encoder
    (
        // Data Input for ECC
        .d_i    (eccDataInput),
        // Calculated ECC
        .p_o    (calcEccSignature)
    );

    // ECC Decoder Mapping
    bch_dec_dcd_univ_top
    #(
        // Memory data word size
        .P_D_WIDTH  (dw)
    )
    memecc_decoder
    (
        // Data Input for ECC
        .d_i        (dataFromMemory),
        // Calculated ECC
        .ecc_i      (storedEccSignature),
        // Error Detection Logic
        .msk_o      (eccErrorMask),
        .err_det_o  (eccErrorDetected)
    );

endmodule
