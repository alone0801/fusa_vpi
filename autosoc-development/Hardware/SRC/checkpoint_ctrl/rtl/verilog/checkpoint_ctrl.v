/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

 Description: 
        Checkpoint Controller
        Verify SW Control Path by Checking signatures from each SW Task.
        Execution Sequence and Time are checked. In case of unexpected behavior
            and alarm is set.
 
  For more information access: http://www.autosoc.org

***************************************************************************** */

module checkpoint_ctrl #(
    // Configuration Parameters
    parameter NUM_OF_TASKS      = 4,
    parameter SIGNATURE_ADDR    = 32'h00070000,
    parameter SIGNATURE_TASK1   = 32'hCAFEAAA1,
    parameter SIGNATURE_TASK2   = 32'hCAFEAAA2,
    parameter SIGNATURE_TASK3   = 32'hCAFEAAA3,
    parameter SIGNATURE_TASK4   = 32'hCAFEAAA4,
    // Timeout in clockcycles
    parameter TIMEOUT_TASKS     = 24'd3500000,
    parameter TIMEOUT_TASKHK    = 24'd9000000
)
(
    // Module Ports
    input           clk,
    input           rst,
    input [31:0]    checkpoint_data_i,
    input [31:0]    checkpoint_addr_i,

    // Error Indication Output
    output          cp_error_alarm_o
);

    // Auxiliary Registers
    reg [23:0]  wd_counter_task1;
    reg [23:0]  wd_counter_task2;
    reg [23:0]  wd_counter_task3;
    reg [23:0]  wd_counter_task4;

//    reg [31:0]  last_detected_signature;

    reg        cp_error_alarm;

    // Connectiony
    assign cp_error_alarm_o = cp_error_alarm;

    //Compare the outputs from the Main and Shadow CPUs
    always @(posedge clk or posedge rst) begin

        if (rst) begin
            wd_counter_task1    <= 24'd0;
            wd_counter_task2    <= 24'd0;
            wd_counter_task3    <= 24'd0;
            wd_counter_task4    <= 24'd0;
            cp_error_alarm      <= 1'b1;
        end 
        else begin
            // Increment timeout counters
            wd_counter_task1    <= wd_counter_task1 + 1;
            wd_counter_task2    <= wd_counter_task2 + 1;
            wd_counter_task3    <= wd_counter_task3 + 1;
            wd_counter_task4    <= wd_counter_task4 + 1;
    
            // Check for Expired Counters
            if ( (wd_counter_task1 > TIMEOUT_TASKS) || (wd_counter_task2 > TIMEOUT_TASKS) ||
                (wd_counter_task3 > TIMEOUT_TASKS) || (wd_counter_task4 > TIMEOUT_TASKHK) )
                        // Set Error Alarm
                        cp_error_alarm <= 1'b0;

            // If an access was made to the Signature Address,
            // Check execution sequence and timeouts
            if (checkpoint_addr_i == SIGNATURE_ADDR ) begin

                // Logic for Task1
                if (checkpoint_data_i == SIGNATURE_TASK1 )  wd_counter_task1 <= 24'd0; 
                // Logic for Task2
                if (checkpoint_data_i == SIGNATURE_TASK2 )  wd_counter_task2 <= 24'd0; 
                // Logic for Task3
                if (checkpoint_data_i == SIGNATURE_TASK3 )  wd_counter_task3 <= 24'd0; 
                // Logic for Task4
                if (checkpoint_data_i == SIGNATURE_TASK4 )  wd_counter_task4 <= 24'd0; 

            end // if SIGNATURE_ADDR

        end //else
    end //always

endmodule
