/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

 Description: 
        Safety Monitor Unit
        Monitor all error indications and generate an overal SoC error indication.

  For more information access: http://www.autosoc.org

***************************************************************************** */
module safety_monitor
(
    input           clk,
    input           rst,
    input           alarm_in1,
    input           alarm_in2,
    input           alarm_in3,
    input           alarm_in4,
    input           alarm_in5,

    // Error Indication Output
    output          sf_error_alarm_o,
    output [4:0]    sf_error_code_o
);

    // Auxiliary Registers
    reg         sf_error_alarm;
    reg [4:0]   sf_error_code;
    wire        alarms_logic;

    // Connection
    assign sf_error_alarm_o = sf_error_alarm;
    assign sf_error_code_o  = sf_error_code;
    assign alarms_logic = (alarm_in1 & alarm_in2 & alarm_in3 & alarm_in4 & alarm_in5);

    //Compare the outputs from the Main and Shadow CPUs
    always @(posedge clk `OR_ASYNC_RST) begin

        if (rst) begin 
            sf_error_alarm      <= 1'b1;
            sf_error_code[4:0]  <= 5'b0;
        end 
        else begin
            // In case any of the alarms is active, active the sf_error_alarm_o (active_low)
            if ( alarms_logic != 1'b1 ) sf_error_alarm <= 1'b0;

            // Generate a Error Code to indicate what SM detected the fault
            sf_error_code <= {alarm_in5 , alarm_in4 , alarm_in3 , alarm_in2 , alarm_in1};

        end //else
    end //always

endmodule
