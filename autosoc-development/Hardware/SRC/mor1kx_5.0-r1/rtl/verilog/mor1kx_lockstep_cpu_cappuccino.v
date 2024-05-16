/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: Implementation of Dual Lock Step Safety 
  Mechanism on the Cappuccino CPU

  For more information access: http://www.autosoc.org

***************************************************************************** */

`include "mor1kx-defines.v"

module mor1kx_lockstep_cappuccino
  #(

// AutoSoC Parameters for synthesis:
    parameter FEATURE_DEBUGUNIT = "ENABLED",
    parameter FEATURE_CMOV = "ENABLED",
    parameter FEATURE_INSTRUCTIONCACHE = "ENABLED",
    parameter OPTION_ICACHE_SET_WIDTH = 8,
    parameter FEATURE_IMMU = "ENABLED",
    parameter FEATURE_DATACACHE = "ENABLED",
    parameter OPTION_DCACHE_SET_WIDTH = 8,
    parameter OPTION_DCACHE_LIMIT_WIDTH = 31,
    parameter FEATURE_DMMU = "ENABLED",
    parameter OPTION_RF_NUM_SHADOW_GPR = 1,
    parameter OPTION_RF_CLEAR_ON_INIT = 1,
    parameter OPTION_RESET_PC = 32'h00000100,

// Original Default Parameters:
    parameter OPTION_OPERAND_WIDTH = 32,
    //parameter FEATURE_DATACACHE = "NONE",
    parameter OPTION_DCACHE_BLOCK_WIDTH = 5,
    //parameter OPTION_DCACHE_SET_WIDTH = 9,
    parameter OPTION_DCACHE_WAYS = 2,
    //parameter OPTION_DCACHE_LIMIT_WIDTH = 32,
    parameter OPTION_DCACHE_SNOOP = "NONE",
    //parameter FEATURE_DMMU = "NONE",
    parameter FEATURE_DMMU_HW_TLB_RELOAD = "NONE",
    parameter OPTION_DMMU_SET_WIDTH = 6,
    parameter OPTION_DMMU_WAYS = 1,
    //parameter FEATURE_INSTRUCTIONCACHE = "NONE",
    parameter OPTION_ICACHE_BLOCK_WIDTH = 5,
    //parameter OPTION_ICACHE_SET_WIDTH = 9,
    parameter OPTION_ICACHE_WAYS = 2,
    parameter OPTION_ICACHE_LIMIT_WIDTH = 32,
    //parameter FEATURE_IMMU = "NONE",
    parameter FEATURE_IMMU_HW_TLB_RELOAD = "NONE",
    parameter OPTION_IMMU_SET_WIDTH = 6,
    parameter OPTION_IMMU_WAYS = 1,
    parameter FEATURE_TIMER = "ENABLED",
    //parameter FEATURE_DEBUGUNIT = "NONE",
    parameter FEATURE_PERFCOUNTERS = "NONE",
    parameter OPTION_PERFCOUNTERS_NUM = 0,
    parameter FEATURE_MAC = "NONE",

    parameter FEATURE_SYSCALL = "ENABLED",
    parameter FEATURE_TRAP = "ENABLED",
    parameter FEATURE_RANGE = "ENABLED",

    parameter FEATURE_PIC = "ENABLED",
    parameter OPTION_PIC_TRIGGER = "LEVEL",
    parameter OPTION_PIC_NMI_WIDTH = 0,

    parameter FEATURE_DSX = "NONE",
    parameter FEATURE_OVERFLOW = "NONE",
    parameter FEATURE_CARRY_FLAG = "ENABLED",

    parameter FEATURE_FASTCONTEXTS = "NONE",
    //parameter OPTION_RF_CLEAR_ON_INIT = 0,
    //parameter OPTION_RF_NUM_SHADOW_GPR = 0,
    parameter OPTION_RF_ADDR_WIDTH = 5,
    parameter OPTION_RF_WORDS = 32,

    //parameter OPTION_RESET_PC = {{(OPTION_OPERAND_WIDTH-13){1'b0}},
    //				 `OR1K_RESET_VECTOR,8'd0},

    parameter FEATURE_MULTIPLIER = "THREESTAGE",
    parameter FEATURE_DIVIDER = "NONE",

    parameter OPTION_SHIFTER = "BARREL",

    parameter FEATURE_ADDC = "NONE",
    parameter FEATURE_SRA = "ENABLED",
    parameter FEATURE_ROR = "NONE",
    parameter FEATURE_EXT = "NONE",
    //parameter FEATURE_CMOV = "NONE",
    parameter FEATURE_FFL1 = "NONE",
    parameter FEATURE_MSYNC = "ENABLED",
    parameter FEATURE_PSYNC = "NONE",
    parameter FEATURE_CSYNC = "NONE",

    parameter FEATURE_ATOMIC = "ENABLED",

    parameter FEATURE_FPU   = "NONE", // ENABLED|NONE: pipeline cappuccino

    parameter FEATURE_CUST1 = "NONE",
    parameter FEATURE_CUST2 = "NONE",
    parameter FEATURE_CUST3 = "NONE",
    parameter FEATURE_CUST4 = "NONE",
    parameter FEATURE_CUST5 = "NONE",
    parameter FEATURE_CUST6 = "NONE",
    parameter FEATURE_CUST7 = "NONE",
    parameter FEATURE_CUST8 = "NONE",

    parameter FEATURE_STORE_BUFFER = "ENABLED",
    parameter OPTION_STORE_BUFFER_DEPTH_WIDTH = 8,

    parameter FEATURE_MULTICORE = "NONE",

    parameter FEATURE_TRACEPORT_EXEC = "NONE",
    parameter FEATURE_BRANCH_PREDICTOR = "SIMPLE"  // SIMPLE|SAT_COUNTER|GSHARE
    )
   (
    input 			      clk,
    input 			      rst,

    // Instruction bus
    input 			      ibus_err_i,
    input 			      ibus_ack_i,
    input [`OR1K_INSN_WIDTH-1:0]      ibus_dat_i,
    output [OPTION_OPERAND_WIDTH-1:0] ibus_adr_o,
    output 			      ibus_req_o,
    output 			      ibus_burst_o,

    // Data bus
    input 			      dbus_err_i,
    input 			      dbus_ack_i,
    input [OPTION_OPERAND_WIDTH-1:0]  dbus_dat_i,
    output [OPTION_OPERAND_WIDTH-1:0] dbus_adr_o,
    output [OPTION_OPERAND_WIDTH-1:0] dbus_dat_o,
    output 			      dbus_req_o,
    output [3:0] 		      dbus_bsel_o,
    output 			      dbus_we_o,
    output 			      dbus_burst_o,

    // Interrupts
    input [31:0] 		      irq_i,

    // Debug interface
    input [15:0] 		      du_addr_i,
    input 			      du_stb_i,
    input [OPTION_OPERAND_WIDTH-1:0]  du_dat_i,
    input 			      du_we_i,
    output [OPTION_OPERAND_WIDTH-1:0] du_dat_o,
    output 			      du_ack_o,
    // Stall control from debug interface
    input 			      du_stall_i,
    output 			      du_stall_o,

    output                        traceport_exec_valid_o,
    output [31:0]                 traceport_exec_pc_o,
    output                        traceport_exec_jb_o,
    output                        traceport_exec_jal_o,
    output                        traceport_exec_jr_o,
    output [31:0]                 traceport_exec_jbtarget_o,
    output [`OR1K_INSN_WIDTH-1:0] traceport_exec_insn_o,
    output [OPTION_OPERAND_WIDTH-1:0] traceport_exec_wbdata_o,
    output [OPTION_RF_ADDR_WIDTH-1:0] traceport_exec_wbreg_o,
    output                            traceport_exec_wben_o,
   
    // SPR accesses to external units (cache, mmu, etc.)
    output [15:0] 		      spr_bus_addr_o,
    output 			      spr_bus_we_o,
    output 			      spr_bus_stb_o,
    output [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_o,
    input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_mac_i,
    input 			      spr_bus_ack_mac_i,
    input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_pmu_i,
    input 			      spr_bus_ack_pmu_i,
    input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_pcu_i,
    input 			      spr_bus_ack_pcu_i,
    input [OPTION_OPERAND_WIDTH-1:0]  spr_bus_dat_fpu_i,
    input 			      spr_bus_ack_fpu_i,
    output [15:0] 		      spr_sr_o,

    input [OPTION_OPERAND_WIDTH-1:0]  multicore_coreid_i,
    input [OPTION_OPERAND_WIDTH-1:0]  multicore_numcores_i,

    input [31:0] 		     snoop_adr_i,
    input 			     snoop_en_i,

    // Error Detection indication
    output                            lockstep_error_o
   );

/*=============================================================================*/
// Wire and Regs 
/*=============================================================================*/
   // Save error indication
    reg lockstep_error;

    // Inputs for Shadow CPU
    wire                            rst_delay;
    wire                            ibus_err_delay;
    wire                            ibus_ack_delay;
    wire                            dbus_err_delay;
    wire                            dbus_ack_delay;
    wire                            du_stb_delay;
    wire                            du_we_delay;
    wire                            du_stall_delay;
    wire                            spr_bus_ack_mac_delay;
    wire                            spr_bus_ack_pmu_delay;
    wire                            spr_bus_ack_pcu_delay;
    wire                            spr_bus_ack_fpu_delay;
    wire [31:0]                     irq_delay;
    wire [15:0]                     du_addr_delay;
    wire [`OR1K_INSN_WIDTH-1:0]     ibus_dat_delay;
    wire [OPTION_OPERAND_WIDTH-1:0] dbus_dat_delay;
    wire [OPTION_OPERAND_WIDTH-1:0] du_dat_delay;
    wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_mac_delay;
    wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_pmu_delay;
    wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_pcu_delay;
    wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_fpu_delay;
    wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_immu_delay;
    wire [OPTION_OPERAND_WIDTH-1:0] multicore_coreid_delay;
    wire [OPTION_OPERAND_WIDTH-1:0] multicore_numcores_delay;
    wire [31:0]                     snoop_adr_delay;
    wire                            snoop_en_delay;

    // Outputs from Shadow CPU
    wire                            ibus_req_shadow_o;
    wire                            ibus_burst_shadow_o;
    wire                            dbus_req_shadow_o;
    wire                            dbus_we_shadow_o;
    wire                            dbus_burst_shadow_o;
    wire                            du_ack_shadow_o;
    wire                            du_stall_shadow_o;
    wire                            spr_bus_we_shadow_o;
    wire                            spr_bus_stb_shadow_o;
    wire [3:0]                      dbus_bsel_shadow_o;
    wire [15:0]                     spr_bus_addr_shadow_o;
    wire [15:0]                     spr_sr_shadow_o;
    wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_shadow_o;
    wire [OPTION_OPERAND_WIDTH-1:0] du_dat_shadow_o;
    wire [OPTION_OPERAND_WIDTH-1:0] dbus_dat_shadow_o;
    wire [OPTION_OPERAND_WIDTH-1:0] dbus_adr_shadow_o;
    wire [OPTION_OPERAND_WIDTH-1:0] ibus_adr_shadow_o;
    wire                            traceport_exec_wben_shadow_o;
    wire                            traceport_exec_valid_shadow_o;
    wire                            traceport_exec_jb_shadow_o;
    wire                            traceport_exec_jal_shadow_o;
    wire                            traceport_exec_jr_shadow_o;
    wire [31:0]                     traceport_exec_jbtarget_shadow_o;
    wire [31:0]                     traceport_exec_pc_shadow_o;
    wire [`OR1K_INSN_WIDTH-1:0]     traceport_exec_insn_shadow_o;
    wire [OPTION_OPERAND_WIDTH-1:0] traceport_exec_wbdata_shadow_o;
    wire [OPTION_OPERAND_WIDTH-1:0] traceport_exec_wbreg_shadow_o;

    // Outputs from Main CPU - Delayed for comparison
    wire                            ibus_req_main_delay_o;
    wire                            ibus_burst_main_delay_o;
    wire                            dbus_req_main_delay_o;
    wire                            dbus_we_main_delay_o;
    wire                            dbus_burst_main_delay_o;
    wire                            du_ack_main_delay_o;
    wire                            du_stall_main_delay_o;
    wire                            spr_bus_we_main_delay_o;
    wire                            spr_bus_stb_main_delay_o;
    wire [3:0]                      dbus_bsel_main_delay_o;
    wire [15:0]                     spr_bus_addr_main_delay_o;
    wire [15:0]                     spr_sr_main_delay_o;
    wire [OPTION_OPERAND_WIDTH-1:0] spr_bus_dat_main_delay_o;
    wire [OPTION_OPERAND_WIDTH-1:0] du_dat_main_delay_o;
    wire [OPTION_OPERAND_WIDTH-1:0] dbus_dat_main_delay_o;
    wire [OPTION_OPERAND_WIDTH-1:0] dbus_adr_main_delay_o;
    wire [OPTION_OPERAND_WIDTH-1:0] ibus_adr_main_delay_o;
    wire                            traceport_exec_wben_main_delay_o;
    wire                            traceport_exec_valid_main_delay_o;
    wire                            traceport_exec_jb_main_delay_o;
    wire                            traceport_exec_jal_main_delay_o;
    wire                            traceport_exec_jr_main_delay_o;
    wire [31:0]                     traceport_exec_jbtarget_main_delay_o;
    wire [31:0]                     traceport_exec_pc_main_delay_o;
    wire [`OR1K_INSN_WIDTH-1:0]     traceport_exec_insn_main_delay_o;
    wire [OPTION_OPERAND_WIDTH-1:0] traceport_exec_wbdata_main_delay_o;
    wire [OPTION_RF_ADDR_WIDTH-1:0] traceport_exec_wbreg_main_delay_o;
/*=============================================================================*/
// Delay Shadow CPU Input signals by two clock cycles
/*=============================================================================*/
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in1 ( .clk (clk), .signal_i (rst), .delayed_o(rst_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in2 ( .clk (clk), .signal_i (ibus_err_i), .delayed_o(ibus_err_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in3 ( .clk (clk), .signal_i (ibus_ack_i), .delayed_o(ibus_ack_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in4 ( .clk (clk), .signal_i (dbus_err_i), .delayed_o(dbus_err_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in5 ( .clk (clk), .signal_i (dbus_ack_i), .delayed_o(dbus_ack_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in6 ( .clk (clk), .signal_i (du_stb_i), .delayed_o(du_stb_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in7 ( .clk (clk), .signal_i (du_we_i), .delayed_o(du_we_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in8 ( .clk (clk), .signal_i (du_stall_i), .delayed_o(du_stall_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in9 ( .clk (clk), .signal_i (snoop_en_i), .delayed_o(snoop_en_delay)); 
    delay_unit #( .OPERAND_WIDTH(32) ) 
        delay_in10 ( .clk (clk), .signal_i (snoop_adr_i), .delayed_o(snoop_adr_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in11 ( .clk (clk), .signal_i (spr_bus_ack_mac_i), .delayed_o(spr_bus_ack_mac_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in12 ( .clk (clk), .signal_i (spr_bus_ack_pmu_i), .delayed_o(spr_bus_ack_pmu_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in13 ( .clk (clk), .signal_i (spr_bus_ack_pcu_i), .delayed_o(spr_bus_ack_pcu_delay)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_in14 ( .clk (clk), .signal_i (spr_bus_ack_fpu_i), .delayed_o(spr_bus_ack_fpu_delay)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_in15 ( .clk (clk), .signal_i (multicore_coreid_i), .delayed_o(multicore_coreid_delay)); 
    delay_unit #( .OPERAND_WIDTH(32) ) 
        delay_in16 ( .clk (clk), .signal_i (irq_i), .delayed_o(irq_delay)); 
    delay_unit #( .OPERAND_WIDTH(16) ) 
        delay_in17 ( .clk (clk), .signal_i (du_addr_i), .delayed_o(du_addr_delay)); 
    delay_unit #( .OPERAND_WIDTH(`OR1K_INSN_WIDTH) ) 
        delay_in18 ( .clk (clk), .signal_i (ibus_dat_i), .delayed_o(ibus_dat_delay)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_in19 ( .clk (clk), .signal_i (dbus_dat_i), .delayed_o(dbus_dat_delay)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_in20 ( .clk (clk), .signal_i (du_dat_i), .delayed_o(du_dat_delay)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_in21 ( .clk (clk), .signal_i (spr_bus_dat_mac_i), .delayed_o(spr_bus_dat_mac_delay)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_in22 ( .clk (clk), .signal_i (spr_bus_dat_pmu_i), .delayed_o(spr_bus_dat_pmu_delay)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_in23 ( .clk (clk), .signal_i (spr_bus_dat_pcu_i), .delayed_o(spr_bus_dat_pcu_delay)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_in24 ( .clk (clk), .signal_i (spr_bus_dat_fpu_i), .delayed_o(spr_bus_dat_fpu_delay)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_in25 ( .clk (clk), .signal_i (multicore_numcores_i), .delayed_o(multicore_numcores_delay)); 

/*=============================================================================*/
// Delay Main CPU Outputs by two clock cycles for Comparison
/*=============================================================================*/
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out1 ( .clk (clk), .signal_i (ibus_req_o), .delayed_o(ibus_req_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out2 ( .clk (clk), .signal_i (ibus_burst_o), .delayed_o(ibus_burst_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out3 ( .clk (clk), .signal_i (dbus_req_o), .delayed_o(dbus_req_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out4 ( .clk (clk), .signal_i (dbus_we_o), .delayed_o(dbus_we_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out5 ( .clk (clk), .signal_i (du_ack_o), .delayed_o(du_ack_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out6 ( .clk (clk), .signal_i (du_stall_o), .delayed_o(du_stall_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out7 ( .clk (clk), .signal_i (spr_bus_we_o), .delayed_o(spr_bus_we_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out8 ( .clk (clk), .signal_i (spr_bus_stb_o), .delayed_o(spr_bus_stb_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out9 ( .clk (clk), .signal_i (dbus_burst_o), .delayed_o(dbus_burst_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(4) ) 
        delay_out10 ( .clk (clk), .signal_i (dbus_bsel_o), .delayed_o(dbus_bsel_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(16) ) 
        delay_out11 ( .clk (clk), .signal_i (spr_bus_addr_o), .delayed_o(spr_bus_addr_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(16) ) 
        delay_out12 ( .clk (clk), .signal_i (spr_sr_o), .delayed_o(spr_sr_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_out13 ( .clk (clk), .signal_i (spr_bus_dat_o), .delayed_o(spr_bus_dat_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_out14 ( .clk (clk), .signal_i (du_dat_o), .delayed_o(du_dat_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_out15 ( .clk (clk), .signal_i (dbus_dat_o), .delayed_o(dbus_dat_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_out16 ( .clk (clk), .signal_i (dbus_adr_o), .delayed_o(dbus_adr_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_out17 ( .clk (clk), .signal_i (ibus_adr_o), .delayed_o(ibus_adr_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out18 ( .clk (clk), .signal_i (traceport_exec_wben_o), .delayed_o(traceport_exec_wben_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out19 ( .clk (clk), .signal_i (traceport_exec_valid_o), .delayed_o(traceport_exec_valid_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out20 ( .clk (clk), .signal_i (traceport_exec_jb_o), .delayed_o(traceport_exec_jb_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out21 ( .clk (clk), .signal_i (traceport_exec_jal_o), .delayed_o(traceport_exec_jal_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(1) ) 
        delay_out22 ( .clk (clk), .signal_i (traceport_exec_jr_o), .delayed_o(traceport_exec_jr_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(32) ) 
        delay_out23 ( .clk (clk), .signal_i (traceport_exec_jbtarget_o), .delayed_o(traceport_exec_jbtarget_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(32) ) 
        delay_out24 ( .clk (clk), .signal_i (traceport_exec_pc_o), .delayed_o(traceport_exec_pc_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(`OR1K_INSN_WIDTH) ) 
        delay_out25 ( .clk (clk), .signal_i (traceport_exec_insn_o), .delayed_o(traceport_exec_insn_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_RF_ADDR_WIDTH) ) 
        delay_out26 ( .clk (clk), .signal_i (traceport_exec_wbreg_o), .delayed_o(traceport_exec_wbreg_main_delay_o)); 
    delay_unit #( .OPERAND_WIDTH(OPTION_OPERAND_WIDTH) ) 
        delay_out27 ( .clk (clk), .signal_i (traceport_exec_wbdata_o), .delayed_o(traceport_exec_wbdata_main_delay_o)); 

/*=============================================================================*/
// CPUs Output Comparison Logic
/*=============================================================================*/
    // Map Error Detection to Output
    assign lockstep_error_o = lockstep_error;

    //Compare the outputs from the Main and Shadow CPUs
    always @(posedge clk `OR_ASYNC_RST) begin

        if (rst) 
            lockstep_error <= 1'b1;
        else 
          begin
            //Compare all outputs
            if (ibus_adr_shadow_o       != ibus_adr_main_delay_o)      lockstep_error <= 1'b0;
            if (ibus_req_shadow_o       != ibus_req_main_delay_o)      lockstep_error <= 1'b0;
            if (ibus_burst_shadow_o     != ibus_burst_main_delay_o)    lockstep_error <= 1'b0;  
            if (dbus_adr_shadow_o       != dbus_adr_main_delay_o)      lockstep_error <= 1'b0;    
            if (dbus_dat_shadow_o       != dbus_dat_main_delay_o)      lockstep_error <= 1'b0;    
            if (dbus_req_shadow_o       != dbus_req_main_delay_o)      lockstep_error <= 1'b0;    
            if (dbus_bsel_shadow_o      != dbus_bsel_main_delay_o)     lockstep_error <= 1'b0;   
            if (dbus_we_shadow_o        != dbus_we_main_delay_o)       lockstep_error <= 1'b0;     
            if (dbus_burst_shadow_o     != dbus_burst_main_delay_o)    lockstep_error <= 1'b0;  
            if (du_dat_shadow_o         != du_dat_main_delay_o)        lockstep_error <= 1'b0;      
            if (du_ack_shadow_o         != du_ack_main_delay_o)        lockstep_error <= 1'b0;      
            if (du_stall_shadow_o       != du_stall_main_delay_o)      lockstep_error <= 1'b0;    
            if (spr_bus_addr_shadow_o   != spr_bus_addr_main_delay_o)  lockstep_error <= 1'b0;
            if (spr_bus_we_shadow_o     != spr_bus_we_main_delay_o)    lockstep_error <= 1'b0;  
            if (spr_bus_stb_shadow_o    != spr_bus_stb_main_delay_o)   lockstep_error <= 1'b0; 
            if (spr_bus_dat_shadow_o    != spr_bus_dat_main_delay_o)   lockstep_error <= 1'b0; 
            if (spr_sr_shadow_o         != spr_sr_main_delay_o)        lockstep_error <= 1'b0;      
            if (traceport_exec_wben_shadow_o	 != traceport_exec_wben_main_delay_o)	    lockstep_error <= 1'b0;     
            if (traceport_exec_valid_shadow_o	 != traceport_exec_valid_main_delay_o)	    lockstep_error <= 1'b0;    
            if (traceport_exec_jb_shadow_o	 != traceport_exec_jb_main_delay_o)	    lockstep_error <= 1'b0;        
            if (traceport_exec_jal_shadow_o	 != traceport_exec_jal_main_delay_o)	    lockstep_error <= 1'b0;      
            if (traceport_exec_jr_shadow_o	 != traceport_exec_jr_main_delay_o)	    lockstep_error <= 1'b0;        
            if (traceport_exec_jbtarget_shadow_o != traceport_exec_jbtarget_main_delay_o)   lockstep_error <= 1'b0; 
            if (traceport_exec_pc_shadow_o	 != traceport_exec_pc_main_delay_o)	    lockstep_error <= 1'b0;        
            if (traceport_exec_insn_shadow_o	 != traceport_exec_insn_main_delay_o)	    lockstep_error <= 1'b0;     
            if (traceport_exec_wbdata_shadow_o	 != traceport_exec_wbdata_main_delay_o)	    lockstep_error <= 1'b0;   
            if (traceport_exec_wbreg_shadow_o	 != traceport_exec_wbreg_main_delay_o)	    lockstep_error <= 1'b0;    

        end //else
   end //always

/*=============================================================================*/
// Instance of Main CPU
/*=============================================================================*/
   mor1kx_cpu_cappuccino
        #(
     .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
     .FEATURE_DATACACHE(FEATURE_DATACACHE),
     .OPTION_DCACHE_BLOCK_WIDTH(OPTION_DCACHE_BLOCK_WIDTH),
     .OPTION_DCACHE_SET_WIDTH(OPTION_DCACHE_SET_WIDTH),
     .OPTION_DCACHE_WAYS(OPTION_DCACHE_WAYS),
     .OPTION_DCACHE_LIMIT_WIDTH(OPTION_DCACHE_LIMIT_WIDTH),
     .OPTION_DCACHE_SNOOP(OPTION_DCACHE_SNOOP),
     .FEATURE_DMMU(FEATURE_DMMU),
     .FEATURE_DMMU_HW_TLB_RELOAD(FEATURE_DMMU_HW_TLB_RELOAD),
     .OPTION_DMMU_SET_WIDTH(OPTION_DMMU_SET_WIDTH),
     .OPTION_DMMU_WAYS(OPTION_DMMU_WAYS),
     .FEATURE_INSTRUCTIONCACHE(FEATURE_INSTRUCTIONCACHE),
     .OPTION_ICACHE_BLOCK_WIDTH(OPTION_ICACHE_BLOCK_WIDTH),
     .OPTION_ICACHE_SET_WIDTH(OPTION_ICACHE_SET_WIDTH),
     .OPTION_ICACHE_WAYS(OPTION_ICACHE_WAYS),
     .OPTION_ICACHE_LIMIT_WIDTH(OPTION_ICACHE_LIMIT_WIDTH),
     .FEATURE_IMMU(FEATURE_IMMU),
     .FEATURE_IMMU_HW_TLB_RELOAD(FEATURE_IMMU_HW_TLB_RELOAD),
     .OPTION_IMMU_SET_WIDTH(OPTION_IMMU_SET_WIDTH),
     .OPTION_IMMU_WAYS(OPTION_IMMU_WAYS),
     .FEATURE_PIC(FEATURE_PIC),
     .FEATURE_TIMER(FEATURE_TIMER),
     .FEATURE_DEBUGUNIT(FEATURE_DEBUGUNIT),
     .FEATURE_PERFCOUNTERS(FEATURE_PERFCOUNTERS),
     .OPTION_PERFCOUNTERS_NUM(OPTION_PERFCOUNTERS_NUM),
     .FEATURE_MAC(FEATURE_MAC),
     .FEATURE_MULTICORE(FEATURE_MULTICORE),
     .FEATURE_TRACEPORT_EXEC(FEATURE_TRACEPORT_EXEC),
     .FEATURE_SYSCALL(FEATURE_SYSCALL),
     .FEATURE_TRAP(FEATURE_TRAP),
     .FEATURE_RANGE(FEATURE_RANGE),
     .OPTION_PIC_TRIGGER(OPTION_PIC_TRIGGER),
     .OPTION_PIC_NMI_WIDTH(OPTION_PIC_NMI_WIDTH),
     .FEATURE_DSX(FEATURE_DSX),
     .FEATURE_FASTCONTEXTS(FEATURE_FASTCONTEXTS),
     .OPTION_RF_CLEAR_ON_INIT(OPTION_RF_CLEAR_ON_INIT),
     .OPTION_RF_NUM_SHADOW_GPR(OPTION_RF_NUM_SHADOW_GPR),
     .FEATURE_OVERFLOW(FEATURE_OVERFLOW),
     .FEATURE_CARRY_FLAG(FEATURE_CARRY_FLAG),
     .OPTION_RF_ADDR_WIDTH(OPTION_RF_ADDR_WIDTH),
     .OPTION_RF_WORDS(OPTION_RF_WORDS),
     .OPTION_RESET_PC(OPTION_RESET_PC),
     .FEATURE_MULTIPLIER(FEATURE_MULTIPLIER),
     .FEATURE_DIVIDER(FEATURE_DIVIDER),
     .FEATURE_ADDC(FEATURE_ADDC),
     .FEATURE_SRA(FEATURE_SRA),
     .FEATURE_ROR(FEATURE_ROR),
     .FEATURE_EXT(FEATURE_EXT),
     .FEATURE_CMOV(FEATURE_CMOV),
     .FEATURE_FFL1(FEATURE_FFL1),
     .FEATURE_MSYNC(FEATURE_MSYNC),
     .FEATURE_PSYNC(FEATURE_PSYNC),
     .FEATURE_CSYNC(FEATURE_CSYNC),
     .FEATURE_ATOMIC(FEATURE_ATOMIC),
     .FEATURE_FPU(FEATURE_FPU),
     .FEATURE_CUST1(FEATURE_CUST1),
     .FEATURE_CUST2(FEATURE_CUST2),
     .FEATURE_CUST3(FEATURE_CUST3),
     .FEATURE_CUST4(FEATURE_CUST4),
     .FEATURE_CUST5(FEATURE_CUST5),
     .FEATURE_CUST6(FEATURE_CUST6),
     .FEATURE_CUST7(FEATURE_CUST7),
     .FEATURE_CUST8(FEATURE_CUST8),
     .OPTION_SHIFTER(OPTION_SHIFTER),
     .FEATURE_STORE_BUFFER(FEATURE_STORE_BUFFER),
     .OPTION_STORE_BUFFER_DEPTH_WIDTH(OPTION_STORE_BUFFER_DEPTH_WIDTH)
   )
   mor1kx_cpu
   (/*AUTOINST*/
    // Outputs
    .ibus_adr_o			(ibus_adr_o[OPTION_OPERAND_WIDTH-1:0]),
    .ibus_req_o			(ibus_req_o),
    .ibus_burst_o		(ibus_burst_o),
    .dbus_adr_o			(dbus_adr_o[OPTION_OPERAND_WIDTH-1:0]),
    .dbus_dat_o			(dbus_dat_o[OPTION_OPERAND_WIDTH-1:0]),
    .dbus_req_o			(dbus_req_o),
    .dbus_bsel_o		(dbus_bsel_o[3:0]),
    .dbus_we_o			(dbus_we_o),
    .dbus_burst_o		(dbus_burst_o),
    .du_dat_o			(du_dat_o[OPTION_OPERAND_WIDTH-1:0]),
    .du_ack_o			(du_ack_o),
    .du_stall_o			(du_stall_o),
    .traceport_exec_valid_o     (traceport_exec_valid_o),
    .traceport_exec_pc_o        (traceport_exec_pc_o[31:0]),
    .traceport_exec_jb_o        (traceport_exec_jb_o),
    .traceport_exec_jal_o       (traceport_exec_jal_o),
    .traceport_exec_jr_o        (traceport_exec_jr_o),
    .traceport_exec_jbtarget_o  (traceport_exec_jbtarget_o[31:0]),
    .traceport_exec_insn_o      (traceport_exec_insn_o[`OR1K_INSN_WIDTH-1:0]),
    .traceport_exec_wbdata_o    (traceport_exec_wbdata_o[OPTION_OPERAND_WIDTH-1:0]),
    .traceport_exec_wbreg_o     (traceport_exec_wbreg_o[OPTION_RF_ADDR_WIDTH-1:0]),
    .traceport_exec_wben_o      (traceport_exec_wben_o),
    .spr_bus_addr_o		(spr_bus_addr_o[15:0]),
    .spr_bus_we_o		(spr_bus_we_o),
    .spr_bus_stb_o		(spr_bus_stb_o),
    .spr_bus_dat_o		(spr_bus_dat_o[OPTION_OPERAND_WIDTH-1:0]),
    .spr_sr_o			(spr_sr_o[15:0]),
    // Inputs
    .clk			(clk),
    .rst			(rst),
    .ibus_err_i			(ibus_err_i),
    .ibus_ack_i			(ibus_ack_i),
    .ibus_dat_i			(ibus_dat_i[`OR1K_INSN_WIDTH-1:0]),
    .dbus_err_i			(dbus_err_i),
    .dbus_ack_i			(dbus_ack_i),
    .dbus_dat_i			(dbus_dat_i[OPTION_OPERAND_WIDTH-1:0]),
    .irq_i			(irq_i[31:0]),
    .du_addr_i			(du_addr_i[15:0]),
    .du_stb_i			(du_stb_i),
    .du_dat_i			(du_dat_i[OPTION_OPERAND_WIDTH-1:0]),
    .du_we_i			(du_we_i),
    .du_stall_i			(du_stall_i),
    .spr_bus_dat_mac_i		(spr_bus_dat_mac_i[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_mac_i		(spr_bus_ack_mac_i),
    .spr_bus_dat_pmu_i		(spr_bus_dat_pmu_i[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_pmu_i		(spr_bus_ack_pmu_i),
    .spr_bus_dat_pcu_i		(spr_bus_dat_pcu_i[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_pcu_i		(spr_bus_ack_pcu_i),
    .spr_bus_dat_fpu_i		(spr_bus_dat_fpu_i[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_fpu_i		(spr_bus_ack_fpu_i),
    .multicore_coreid_i		(multicore_coreid_i[OPTION_OPERAND_WIDTH-1:0]),
    .multicore_numcores_i	(multicore_numcores_i[OPTION_OPERAND_WIDTH-1:0]),
    .snoop_adr_i		(snoop_adr_i[31:0]),
    .snoop_en_i			(snoop_en_i));

/*=============================================================================*/
// Mapping of Shadow CPU
/*=============================================================================*/
    // Shadow CPU mapping
    mor1kx_cpu_cappuccino
        #(
     .OPTION_OPERAND_WIDTH(OPTION_OPERAND_WIDTH),
     .FEATURE_DATACACHE(FEATURE_DATACACHE),
     .OPTION_DCACHE_BLOCK_WIDTH(OPTION_DCACHE_BLOCK_WIDTH),
     .OPTION_DCACHE_SET_WIDTH(OPTION_DCACHE_SET_WIDTH),
     .OPTION_DCACHE_WAYS(OPTION_DCACHE_WAYS),
     .OPTION_DCACHE_LIMIT_WIDTH(OPTION_DCACHE_LIMIT_WIDTH),
     .OPTION_DCACHE_SNOOP(OPTION_DCACHE_SNOOP),
     .FEATURE_DMMU(FEATURE_DMMU),
     .FEATURE_DMMU_HW_TLB_RELOAD(FEATURE_DMMU_HW_TLB_RELOAD),
     .OPTION_DMMU_SET_WIDTH(OPTION_DMMU_SET_WIDTH),
     .OPTION_DMMU_WAYS(OPTION_DMMU_WAYS),
     .FEATURE_INSTRUCTIONCACHE(FEATURE_INSTRUCTIONCACHE),
     .OPTION_ICACHE_BLOCK_WIDTH(OPTION_ICACHE_BLOCK_WIDTH),
     .OPTION_ICACHE_SET_WIDTH(OPTION_ICACHE_SET_WIDTH),
     .OPTION_ICACHE_WAYS(OPTION_ICACHE_WAYS),
     .OPTION_ICACHE_LIMIT_WIDTH(OPTION_ICACHE_LIMIT_WIDTH),
     .FEATURE_IMMU(FEATURE_IMMU),
     .FEATURE_IMMU_HW_TLB_RELOAD(FEATURE_IMMU_HW_TLB_RELOAD),
     .OPTION_IMMU_SET_WIDTH(OPTION_IMMU_SET_WIDTH),
     .OPTION_IMMU_WAYS(OPTION_IMMU_WAYS),
     .FEATURE_PIC(FEATURE_PIC),
     .FEATURE_TIMER(FEATURE_TIMER),
     .FEATURE_DEBUGUNIT(FEATURE_DEBUGUNIT),
     .FEATURE_PERFCOUNTERS(FEATURE_PERFCOUNTERS),
     .OPTION_PERFCOUNTERS_NUM(OPTION_PERFCOUNTERS_NUM),
     .FEATURE_MAC(FEATURE_MAC),
     .FEATURE_MULTICORE(FEATURE_MULTICORE),
     .FEATURE_TRACEPORT_EXEC(FEATURE_TRACEPORT_EXEC),
     .FEATURE_SYSCALL(FEATURE_SYSCALL),
     .FEATURE_TRAP(FEATURE_TRAP),
     .FEATURE_RANGE(FEATURE_RANGE),
     .OPTION_PIC_TRIGGER(OPTION_PIC_TRIGGER),
     .OPTION_PIC_NMI_WIDTH(OPTION_PIC_NMI_WIDTH),
     .FEATURE_DSX(FEATURE_DSX),
     .FEATURE_FASTCONTEXTS(FEATURE_FASTCONTEXTS),
     .OPTION_RF_CLEAR_ON_INIT(OPTION_RF_CLEAR_ON_INIT),
     .OPTION_RF_NUM_SHADOW_GPR(OPTION_RF_NUM_SHADOW_GPR),
     .FEATURE_OVERFLOW(FEATURE_OVERFLOW),
     .FEATURE_CARRY_FLAG(FEATURE_CARRY_FLAG),
     .OPTION_RF_ADDR_WIDTH(OPTION_RF_ADDR_WIDTH),
     .OPTION_RF_WORDS(OPTION_RF_WORDS),
     .OPTION_RESET_PC(OPTION_RESET_PC),
     .FEATURE_MULTIPLIER(FEATURE_MULTIPLIER),
     .FEATURE_DIVIDER(FEATURE_DIVIDER),
     .FEATURE_ADDC(FEATURE_ADDC),
     .FEATURE_SRA(FEATURE_SRA),
     .FEATURE_ROR(FEATURE_ROR),
     .FEATURE_EXT(FEATURE_EXT),
     .FEATURE_CMOV(FEATURE_CMOV),
     .FEATURE_FFL1(FEATURE_FFL1),
     .FEATURE_MSYNC(FEATURE_MSYNC),
     .FEATURE_PSYNC(FEATURE_PSYNC),
     .FEATURE_CSYNC(FEATURE_CSYNC),
     .FEATURE_ATOMIC(FEATURE_ATOMIC),
     .FEATURE_FPU(FEATURE_FPU),
     .FEATURE_CUST1(FEATURE_CUST1),
     .FEATURE_CUST2(FEATURE_CUST2),
     .FEATURE_CUST3(FEATURE_CUST3),
     .FEATURE_CUST4(FEATURE_CUST4),
     .FEATURE_CUST5(FEATURE_CUST5),
     .FEATURE_CUST6(FEATURE_CUST6),
     .FEATURE_CUST7(FEATURE_CUST7),
     .FEATURE_CUST8(FEATURE_CUST8),
     .OPTION_SHIFTER(OPTION_SHIFTER),
     .FEATURE_STORE_BUFFER(FEATURE_STORE_BUFFER),
     .OPTION_STORE_BUFFER_DEPTH_WIDTH(OPTION_STORE_BUFFER_DEPTH_WIDTH)
    )
    mor1kx_cpu_shadow
    (/*AUTOINST*/
    // Outputs
    .ibus_adr_o			(ibus_adr_shadow_o[OPTION_OPERAND_WIDTH-1:0]),
    .ibus_req_o			(ibus_req_shadow_o),
    .ibus_burst_o		(ibus_burst_shadow_o),
    .dbus_adr_o			(dbus_adr_shadow_o[OPTION_OPERAND_WIDTH-1:0]),
    .dbus_dat_o			(dbus_dat_shadow_o[OPTION_OPERAND_WIDTH-1:0]),
    .dbus_req_o			(dbus_req_shadow_o),
    .dbus_bsel_o		(dbus_bsel_shadow_o[3:0]),
    .dbus_we_o			(dbus_we_shadow_o),
    .dbus_burst_o		(dbus_burst_shadow_o),
    .du_dat_o			(du_dat_shadow_o[OPTION_OPERAND_WIDTH-1:0]),
    .du_ack_o			(du_ack_shadow_o),
    .du_stall_o			(du_stall_shadow_o),
    .traceport_exec_valid_o     (traceport_exec_valid_shadow_o),
    .traceport_exec_pc_o        (traceport_exec_pc_shadow_o[31:0]),
    .traceport_exec_jb_o        (traceport_exec_jb_shadow_o),
    .traceport_exec_jal_o       (traceport_exec_jal_shadow_o),
    .traceport_exec_jr_o        (traceport_exec_jr_shadow_o),
    .traceport_exec_jbtarget_o  (traceport_exec_jbtarget_shadow_o[31:0]),
    .traceport_exec_insn_o      (traceport_exec_insn_shadow_o[`OR1K_INSN_WIDTH-1:0]),
    .traceport_exec_wbdata_o    (traceport_exec_wbdata_shadow_o[OPTION_OPERAND_WIDTH-1:0]),
    .traceport_exec_wbreg_o     (traceport_exec_wbreg_shadow_o[OPTION_RF_ADDR_WIDTH-1:0]),
    .traceport_exec_wben_o      (traceport_exec_wben_shadow_o),
    .spr_bus_addr_o		(spr_bus_addr_shadow_o[15:0]),
    .spr_bus_we_o		(spr_bus_we_shadow_o),
    .spr_bus_stb_o		(spr_bus_stb_shadow_o),
    .spr_bus_dat_o		(spr_bus_dat_shadow_o[OPTION_OPERAND_WIDTH-1:0]),
    .spr_sr_o			(spr_sr_shadow_o[15:0]),
    // Inputs
    .clk		    (clk),
    .rst		    (rst_delay),
    .ibus_err_i		    (ibus_err_delay),
    .ibus_ack_i		    (ibus_ack_delay),
    .ibus_dat_i		    (ibus_dat_delay[`OR1K_INSN_WIDTH-1:0]),
    .dbus_err_i		    (dbus_err_delay),
    .dbus_ack_i		    (dbus_ack_delay),
    .dbus_dat_i		    (dbus_dat_delay[OPTION_OPERAND_WIDTH-1:0]),
    .irq_i		    (irq_delay[31:0]),
    .du_addr_i	            (du_addr_delay[15:0]),
    .du_stb_i	            (du_stb_delay),
    .du_dat_i	            (du_dat_delay[OPTION_OPERAND_WIDTH-1:0]),
    .du_we_i	            (du_we_delay),
    .du_stall_i	            (du_stall_delay),
    .spr_bus_dat_mac_i	    (spr_bus_dat_mac_delay[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_mac_i	    (spr_bus_ack_mac_delay),
    .spr_bus_dat_pmu_i	    (spr_bus_dat_pmu_delay[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_pmu_i	    (spr_bus_ack_pmu_delay),
    .spr_bus_dat_pcu_i	    (spr_bus_dat_pcu_delay[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_pcu_i	    (spr_bus_ack_pcu_delay),
    .spr_bus_dat_fpu_i	    (spr_bus_dat_fpu_delay[OPTION_OPERAND_WIDTH-1:0]),
    .spr_bus_ack_fpu_i	    (spr_bus_ack_fpu_delay),
    .multicore_coreid_i	    (multicore_coreid_delay[OPTION_OPERAND_WIDTH-1:0]),
    .multicore_numcores_i   (multicore_numcores_delay[OPTION_OPERAND_WIDTH-1:0]),
    .snoop_adr_i	    (snoop_adr_delay[31:0]),
    .snoop_en_i		    (snoop_en_delay) 
    );

endmodule // mor1kx_lockstep_cpu_cappuccino

