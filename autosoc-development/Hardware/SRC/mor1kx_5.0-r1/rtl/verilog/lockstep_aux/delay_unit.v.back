/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: Delay Input signals by two clock cycle

  For more information access: http://www.autosoc.org

***************************************************************************** */

`include "mor1kx-defines.v"

module delay_unit
    #( 
        // Configuration Parameters
        parameter OPERAND_WIDTH = 32 
    )
        // Inputs/Outputs
    (
        input                       clk,
        input   [OPERAND_WIDTH-1:0] signal_i,
        output  [OPERAND_WIDTH-1:0] delayed_o
    );

    // Shift Register for Input Signal delay
    reg   [OPERAND_WIDTH-1:0] input_signal_shift;
    reg   [OPERAND_WIDTH-1:0] delayed_signal;

    assign delayed_o = delayed_signal;

    // Signal Delay
    always @(posedge clk) begin
        input_signal_shift <= signal_i;
        delayed_signal <= input_signal_shift;
    end

endmodule //delay_unit
