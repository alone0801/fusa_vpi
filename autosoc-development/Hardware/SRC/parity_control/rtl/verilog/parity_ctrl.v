/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

 Description: 
        Parity Control Unit
        When enable signal is set, check if parities are the same.
        If not, set an error indication

  For more information access: http://www.autosoc.org

***************************************************************************** */
module parity_ctrl
(
    input   parity_in1,
    input   parity_in2,
    input   enable,
    output  parity_error
);

// Check parity signals when enable is activated
// In case enable is 0, parity error is clear
// in case enable is 1 and parity_in1 != parity_in2, parity error is set
assign parity_error = (enable == 1'b1) ? ((parity_in1 == parity_in2) ? 1'b1 : 1'b0) : 1'b1;

endmodule
