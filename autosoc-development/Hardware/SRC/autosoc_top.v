/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: AutoSoC top level mapping

  For more information access: http://www.autosoc.org

***************************************************************************** */

module autosoc_top
#(
    parameter MEM_SIZE          = 32'h02000000,
    parameter OPTION_CPU        = "CAPPUCCINO",
    parameter OPTION_PARITY     = "DISABLED",
    parameter OPTION_CHECKPOINT = "DISABLED",
    parameter OPTION_MEMECC     = "DISABLED"
)
(
    input wb_clk_i,
    input wb_rst_i,
    // JTAG Connections
    output tdo_pad_o,
    input tms_pad_i,
    input tck_pad_i,
    input tdi_pad_i,
    // UART Connections
    output uart_stx,
    output uart_srx,
    // CAN Connections                
    input can_rx_i,
    output can_tx_o,
    output can_bus_off_on
);

localparam wb_aw = 32;
localparam wb_dw = 32;

////////////////////////////////////////////////////////////////////////
//
// Wishbone interconnect
//
////////////////////////////////////////////////////////////////////////
wire wb_clk = wb_clk_i;
wire wb_rst = wb_rst_i;

`include "wb_intercon.vh"


////////////////////////////////////////////////////////////////////////
//
// GENERIC JTAG TAP
//
////////////////////////////////////////////////////////////////////////

wire dbg_if_select;
wire dbg_if_tdo;
wire jtag_tap_tdo;
wire jtag_tap_shift_dr;
wire jtag_tap_pause_dr;
wire jtag_tap_update_dr;
wire jtag_tap_capture_dr;

tap_top jtag_tap0 (
	.tdo_pad_o			(tdo_pad_o),
	.tms_pad_i			(tms_pad_i),
	.tck_pad_i			(tck_pad_i),
	.trst_pad_i			(wb_rst),
	.tdi_pad_i			(tdi_pad_i),

	.tdo_padoe_o			(),

	.tdo_o				(jtag_tap_tdo),

	.shift_dr_o			(jtag_tap_shift_dr),
	.pause_dr_o			(jtag_tap_pause_dr),
	.update_dr_o			(jtag_tap_update_dr),
	.capture_dr_o			(jtag_tap_capture_dr),

	.extest_select_o		(),
	.sample_preload_select_o	(),
	.mbist_select_o			(),
	.debug_select_o			(dbg_if_select),


	.bs_chain_tdi_i			(1'b0),
	.mbist_tdi_i			(1'b0),
	.debug_tdi_i			(dbg_if_tdo)
);

////////////////////////////////////////////////////////////////////////
//
// Debug Interface
//
////////////////////////////////////////////////////////////////////////
wire [31:0]	or1k_dbg_dat_i;
wire [31:0]	or1k_dbg_adr_i;
wire		or1k_dbg_we_i;
wire		or1k_dbg_stb_i;
wire		or1k_dbg_ack_o;
wire [31:0]	or1k_dbg_dat_o;

wire		or1k_dbg_stall_i;
wire		or1k_dbg_ewt_i;
wire [3:0]	or1k_dbg_lss_o;
wire [1:0]	or1k_dbg_is_o;
wire [10:0]	or1k_dbg_wp_o;
wire		or1k_dbg_bp_o;
wire		or1k_dbg_rst;


adbg_top dbg_if0 (
	// OR1K interface
	.cpu0_clk_i	(wb_clk),
	.cpu0_rst_o	(or1k_dbg_rst),
	.cpu0_addr_o	(or1k_dbg_adr_i),
	.cpu0_data_o	(or1k_dbg_dat_i),
	.cpu0_stb_o	(or1k_dbg_stb_i),
	.cpu0_we_o	(or1k_dbg_we_i),
	.cpu0_data_i	(or1k_dbg_dat_o),
	.cpu0_ack_i	(or1k_dbg_ack_o),
	.cpu0_stall_o	(or1k_dbg_stall_i),
	.cpu0_bp_i	(or1k_dbg_bp_o),

	// TAP interface
	.tck_i		(tck_pad_i),
	.tdi_i		(jtag_tap_tdo),
	.tdo_o		(dbg_if_tdo),
	.rst_i		(wb_rst),
	.capture_dr_i	(jtag_tap_capture_dr),
	.shift_dr_i	(jtag_tap_shift_dr),
	.pause_dr_i	(jtag_tap_pause_dr),
	.update_dr_i	(jtag_tap_update_dr),
	.debug_select_i	(dbg_if_select),

	// Wishbone debug master
	.wb_clk_i	(wb_clk),
	.wb_dat_i	(wb_s2m_dbg_dat),
	.wb_ack_i	(wb_s2m_dbg_ack),
	.wb_err_i	(wb_s2m_dbg_err),

	.wb_adr_o	(wb_m2s_dbg_adr),
	.wb_dat_o	(wb_m2s_dbg_dat),
	.wb_cyc_o	(wb_m2s_dbg_cyc),
	.wb_stb_o	(wb_m2s_dbg_stb),
	.wb_sel_o	(wb_m2s_dbg_sel),
	.wb_we_o	(wb_m2s_dbg_we),
	.wb_cti_o	(wb_m2s_dbg_cti),
	.wb_bte_o	(wb_m2s_dbg_bte),

        // Not Connected Ports (FSMOD)
        .wb_cab_o       (),
        .cpu1_addr_o    (),
        .cpu1_data_o    (),
        .cpu1_stall_o   (),
        .cpu1_stb_o     (),
        .cpu1_we_o      (),
        .cpu1_rst_o     (),
        .wb_jsp_dat_o   (),
        .wb_jsp_ack_o   (),
        .wb_jsp_err_o   (),
        .int_o          (),
        .wb_rst_i       (),
        .cpu1_clk_i     (),
        .cpu1_data_i    (),
        .cpu1_bp_i      (),
        .cpu1_ack_i     (),
        .wb_jsp_adr_i   (),
        .wb_jsp_dat_i   (),
        .wb_jsp_cyc_i   (),
        .wb_jsp_stb_i   (),
        .wb_jsp_sel_i   (),
        .wb_jsp_we_i    (),
        .wb_jsp_cab_i   (),
        .wb_jsp_cti_i   (),
        .wb_jsp_bte_i   ()

);

////////////////////////////////////////////////////////////////////////
//
// mor1kx cpu
//
////////////////////////////////////////////////////////////////////////

wire [31:0]	or1k_irq;
wire		or1k_clk;
wire		or1k_rst;

// Lockstep error indication signal
wire    lockstep_error_o;

assign or1k_clk = wb_clk;
assign or1k_rst = wb_rst | or1k_dbg_rst;

mor1kx #(
/* MINIMUM PARAMETERS FOR RTEMS EXECUTION */
/*        
        .FEATURE_DEBUGUNIT		("DISABLED"),
	.FEATURE_IMMU			("DISABLED"),
	.FEATURE_DMMU			("DISABLED"),
	.OPTION_RF_NUM_SHADOW_GPR	(0),
*/
/* -----------------------------------------------------*/

/* PARAMETERS USED FOR THE AUTOSOC PAPER ON VTS 2020 */
/* LINUX BOOT CONFIGURATIONS (https://github.com/openrisc/mor1kx) */ 
        .FEATURE_DEBUGUNIT		("ENABLED"),
	.FEATURE_IMMU			("ENABLED"),
	.FEATURE_DMMU			("ENABLED"),
	.OPTION_RF_NUM_SHADOW_GPR	(1),
/* -----------------------------------------------------*/
	.FEATURE_CMOV			("ENABLED"),
	.FEATURE_INSTRUCTIONCACHE	("ENABLED"),
	.OPTION_ICACHE_BLOCK_WIDTH	(5),
	.OPTION_ICACHE_SET_WIDTH	(8),
	.OPTION_ICACHE_WAYS		(2),
	.OPTION_ICACHE_LIMIT_WIDTH	(32),
	.FEATURE_DATACACHE		("ENABLED"),
	.OPTION_DCACHE_BLOCK_WIDTH	(5),
	.OPTION_DCACHE_SET_WIDTH	(8),
	.OPTION_DCACHE_WAYS		(2),
	.OPTION_DCACHE_LIMIT_WIDTH	(31),
	.OPTION_RF_CLEAR_ON_INIT 	(1), //Clear GPR on initialization

	.OPTION_CPU0			(OPTION_CPU),
	.OPTION_RESET_PC		(32'h00000100)
        
) mor1kx0 (
	.iwbm_adr_o			(wb_m2s_or1k_i_adr),
	.iwbm_stb_o			(wb_m2s_or1k_i_stb),
	.iwbm_cyc_o			(wb_m2s_or1k_i_cyc),
	.iwbm_sel_o			(wb_m2s_or1k_i_sel),
	.iwbm_we_o			(wb_m2s_or1k_i_we),
	.iwbm_cti_o			(wb_m2s_or1k_i_cti),
	.iwbm_bte_o			(wb_m2s_or1k_i_bte),
	.iwbm_dat_o			(wb_m2s_or1k_i_dat),

	.dwbm_adr_o			(wb_m2s_or1k_d_adr),
	.dwbm_stb_o			(wb_m2s_or1k_d_stb),
	.dwbm_cyc_o			(wb_m2s_or1k_d_cyc),
	.dwbm_sel_o			(wb_m2s_or1k_d_sel),
	.dwbm_we_o			(wb_m2s_or1k_d_we ),
	.dwbm_cti_o			(wb_m2s_or1k_d_cti),
	.dwbm_bte_o			(wb_m2s_or1k_d_bte),
	.dwbm_dat_o			(wb_m2s_or1k_d_dat),

	.clk				(or1k_clk),
	.rst				(or1k_rst),

	.iwbm_err_i			(wb_s2m_or1k_i_err),
	.iwbm_ack_i			(wb_s2m_or1k_i_ack),
	.iwbm_dat_i			(wb_s2m_or1k_i_dat),
	.iwbm_rty_i			(wb_s2m_or1k_i_rty),

	.dwbm_err_i			(wb_s2m_or1k_d_err),
	.dwbm_ack_i			(wb_s2m_or1k_d_ack),
	.dwbm_dat_i			(wb_s2m_or1k_d_dat),
	.dwbm_rty_i			(wb_s2m_or1k_d_rty),

	.irq_i				(or1k_irq),

	.du_addr_i			(or1k_dbg_adr_i[15:0]),
	.du_stb_i			(or1k_dbg_stb_i),
	.du_dat_i			(or1k_dbg_dat_i),
	.du_we_i			(or1k_dbg_we_i),
	.du_dat_o			(or1k_dbg_dat_o),
	.du_ack_o			(or1k_dbg_ack_o),
	.du_stall_i			(or1k_dbg_stall_i),
	.du_stall_o			(or1k_dbg_bp_o),

        // Not Connected Ports 
        .traceport_exec_valid_o       (),
        .traceport_exec_pc_o          (),
        .traceport_exec_jb_o          (),
        .traceport_exec_jal_o         (),
        .traceport_exec_jr_o          (),
        .traceport_exec_jbtarget_o    (),
        .traceport_exec_insn_o        (),
        .traceport_exec_wbdata_o      (),
        .traceport_exec_wbreg_o       (),
        .traceport_exec_wben_o        (),
        .multicore_coreid_i           (),
        .multicore_numcores_i         (),
        .snoop_adr_i                  (),
        .snoop_en_i                   (),

        // Lockstep error indication
        .lockstep_error_o           (lockstep_error_o)
);



////////////////////////////////////////////////////////////////////////
//
// Generic main RAM
//
////////////////////////////////////////////////////////////////////////
wb_ram #(
        // Parameter for ECC Enable
        .OPTION_MEMECC  (OPTION_MEMECC),

	.depth	        (MEM_SIZE)
) wb_bfm_memory0 (
	//Wishbone Master interface
	.wb_clk_i	(wb_clk_i),
	.wb_rst_i	(wb_rst_i),
	.wb_adr_i	(wb_m2s_mem_adr[$clog2(MEM_SIZE)-1:0]),
	.wb_dat_i	(wb_m2s_mem_dat),
	.wb_sel_i	(wb_m2s_mem_sel),
	.wb_we_i	(wb_m2s_mem_we),
	.wb_cyc_i	(wb_m2s_mem_cyc),
	.wb_stb_i	(wb_m2s_mem_stb),
	.wb_cti_i	(wb_m2s_mem_cti),
	.wb_bte_i	(wb_m2s_mem_bte),
	.wb_dat_o	(wb_s2m_mem_dat),
	.wb_ack_o	(wb_s2m_mem_ack),
	.wb_err_o	(wb_s2m_mem_err)
);
   assign wb_s2m_mem_rty = 1'b0;

wire uart_irq;

uart_top #(
	.debug	(0),
	.SIM	(1)
) uart16550 (
	//Wishbone Master interface
	.wb_clk_i	(wb_clk_i),
	.wb_rst_i	(wb_rst_i),
	.wb_adr_i	(wb_m2s_uart_adr[2:0]),
	.wb_dat_i	(wb_m2s_uart_dat),
	.wb_sel_i	(4'h0),
	.wb_we_i	(wb_m2s_uart_we),
	.wb_cyc_i	(wb_m2s_uart_cyc),
	.wb_stb_i	(wb_m2s_uart_stb),
	.wb_dat_o	(wb_s2m_uart_dat),
	.wb_ack_o	(wb_s2m_uart_ack),
        .int_o		(uart_irq),
        //Signals below were connected for UART debug
	.srx_pad_i	(uart_srx),
	.stx_pad_o	(uart_stx),
	.rts_pad_o	(),
	.cts_pad_i	(1'b0),
	.dtr_pad_o	(),
	.dsr_pad_i	(1'b0),
	.ri_pad_i	(1'b0),
	.dcd_pad_i	(1'b0)
);
   assign wb_s2m_uart_err = 1'b0;
   assign wb_s2m_uart_rty = 1'b0;

////////////////////////////////////////////////////////////////////////
//
// Interrupt Generator
//
////////////////////////////////////////////////////////////////////////

wire intgen_irq;

intgen intgen0 (
	//Wishbone Master Interface
	.clk_i		(wb_clk_i),
	.rst_i		(wb_rst_i),
	.wb_adr_i	(wb_m2s_intgen_adr[0]),
	.wb_dat_i	(wb_m2s_intgen_dat),
	.wb_we_i	(wb_m2s_intgen_we),
	.wb_cyc_i	(wb_m2s_intgen_cyc),
	.wb_stb_i	(wb_m2s_intgen_stb),
	.wb_dat_o	(wb_s2m_intgen_dat),
	.wb_ack_o	(wb_s2m_intgen_ack),
	.irq_o		(intgen_irq)
);

    assign wb_s2m_intgen_err = 1'b0;
    assign wb_s2m_intgen_rty = 1'b0;


////////////////////////////////////////////////////////////////////////
//
// CAN Controller
//
////////////////////////////////////////////////////////////////////////

// CAN Interrupt to CPU
wire can_irq;
wire can_rx;
wire can_tx;
wire can_self_test;

can_top #(0) can_top
    (
        // Wishbone Bus
	.wb_clk_i       (wb_clk_i),
	.wb_rst_i       (wb_rst_i),
	//.wb_adr_i     (wb_m2s_can_adr[7:0]),
	.wb_adr_i       ({2'b00,wb_m2s_can_adr[7:2]}),
	.wb_dat_i       (wb_m2s_can_dat),
	.wb_we_i        (wb_m2s_can_we),
	.wb_cyc_i       (wb_m2s_can_cyc),
	.wb_stb_i       (wb_m2s_can_stb),
	.wb_dat_o       (wb_s2m_can_dat),
	.wb_ack_o       (wb_s2m_can_ack),
        //Can Controller Signals
	.clk_i          (wb_clk_i),
	.rx_i           (can_rx),
	.tx_o           (can_tx),
	.bus_off_on     (can_bus_off_on),
	.irq_on         (can_irq),
	.clkout_o       (),
        .self_test_ctrl_o (can_self_test)
    );

// CAN transceiver Connection
can_transceiver can_transceiver
    (
	// CAN Controller section
        .tx_can(can_tx),
	.selftest_ctrl(can_self_test),
	.rx_can(can_rx),
	// BUS section
	.tx_bus(can_tx_o),
	.rx_bus(can_rx_i)
    );
////////////////////////////////////////////////////////////////////////
//
// CPU Interrupt assignments
//
////////////////////////////////////////////////////////////////////////
assign or1k_irq[0] = 0;
assign or1k_irq[1] = 0;
assign or1k_irq[2] = uart_irq;
assign or1k_irq[3] = 0;
assign or1k_irq[4] = 0;
assign or1k_irq[5] = 0;
assign or1k_irq[6] = 0;
assign or1k_irq[7] = 0;
assign or1k_irq[8] = 0;
assign or1k_irq[9] = 0;
assign or1k_irq[10] = 0;
assign or1k_irq[11] = 0;
assign or1k_irq[12] = 0;
assign or1k_irq[13] = 0;
assign or1k_irq[14] = 0;
assign or1k_irq[15] = 0;
assign or1k_irq[16] = 0;
assign or1k_irq[17] = 0;
assign or1k_irq[18] = 0;
assign or1k_irq[19] = intgen_irq;
assign or1k_irq[20] = ~can_irq;
assign or1k_irq[21] = 0;
assign or1k_irq[22] = 0;
assign or1k_irq[23] = 0;
assign or1k_irq[24] = 0;
assign or1k_irq[25] = 0;
assign or1k_irq[26] = 0;
assign or1k_irq[27] = 0;
assign or1k_irq[28] = 0;
assign or1k_irq[29] = 0;
assign or1k_irq[30] = 0;
//assign or1k_irq[31] = 0; //Added missing initialization


////////////////////////////////////////////////////////////////////////
//
// Parity Control Blocks
//
////////////////////////////////////////////////////////////////////////

// Parity Error Indication Signals
wire    parityMemToCpuInst_error;
wire    parityMemToCpuData_error;
wire    parityCpuDataToMem_error;

// Check IF Parity SM is Enabled
if (OPTION_PARITY=="ENABLED") begin : parityControl

    // Calculate Parity of Memory Data In
    wire    parityBit_MemDataIn;
    assign  parityBit_MemDataIn = ~^wb_m2s_mem_dat;

    // Calculate Parity of Memory Data Out
    wire    parityBit_MemDataOut;
    assign  parityBit_MemDataOut = ~^wb_s2m_mem_dat;

    // Calculate Parity of CPU Instructions-Data In
    wire    parityBit_CpuInstDataIn;
    assign  parityBit_CpuInstDataIn = ~^wb_s2m_or1k_i_dat;

    // Calculate Parity of CPU Data-Data In
    wire    parityBit_CpuDatDataIn;
    assign  parityBit_CpuDatDataIn = ~^wb_s2m_or1k_d_dat;

    // Calculate Parity of CPU Data-Data Out
    wire    parityBit_CpuDatDataOut;
    assign  parityBit_CpuDatDataOut = ~^wb_m2s_or1k_d_dat;

    // -- Parity Control Data from Memory Output to CPU Instructions Input

    parity_ctrl parityMemToCpuInst (
        .parity_in1 (parityBit_MemDataOut),
        .parity_in2 (parityBit_CpuInstDataIn),
        .enable (1'b1),
        .parity_error (parityMemToCpuInst_error)
    );

    // -- Parity Control Data from Memory Output to CPU Data Input
    // Enable only if wb_m2s_or1k_d_sel == 4'hF 
    wire    parityEn_MemToCpuData;
    assign  parityEn_MemToCpuData = (wb_m2s_or1k_d_sel == 4'hF) ? 1'b1 : 1'b0;

    parity_ctrl parityMemToCpuData (
        .parity_in1 (parityBit_MemDataOut),
        .parity_in2 (parityBit_CpuDatDataIn),
        .enable (parityEn_MemToCpuData),
        .parity_error (parityMemToCpuData_error)
    );

    // -- Parity Control Data from CPU Data Output to Memory Input
    // Enable only if (wb_m2s_mem_sel == 4'h1)
    wire    parityEn_CpuDataToMem;
    assign  parityEn_CpuDataToMem = (wb_m2s_mem_sel == 4'h1) ? 1'b1 : 1'b0;

    parity_ctrl parityCpuDataToMem (
        .parity_in1 (parityBit_MemDataIn),
        .parity_in2 (parityBit_CpuDatDataOut),
        .enable (parityEn_CpuDataToMem),
        .parity_error (parityCpuDataToMem_error)
    );

//Parity Enabled
end 

//Parity Disabled
else begin

    assign    parityMemToCpuInst_error = 1'b1;
    assign    parityMemToCpuData_error = 1'b1;
    assign    parityCpuDataToMem_error = 1'b1;

end

////////////////////////////////////////////////////////////////////////
//
// Checkpoint Control Block
//
////////////////////////////////////////////////////////////////////////

wire    cp_ctrl_error;

// Check IF Checkpoint SM is Enabled
if (OPTION_CHECKPOINT=="ENABLED") begin : checkpointControl

    // Checkpoint Controller Instance
    checkpoint_ctrl cp_ctrl (
        .clk                (or1k_clk),
        .rst                (or1k_rst),

        // Bus Data to Monitor Checkpoints
        .checkpoint_data_i  (wb_m2s_mem_dat),
        .checkpoint_addr_i  (wb_m2s_mem_adr),

        // Error Indication Output
        .cp_error_alarm_o    (cp_ctrl_error)
    );

//Checkpoint Enabled
end 

//Checkpoint Disabled
else
    assign    cp_ctrl_error = 1'b1;


////////////////////////////////////////////////////////////////////////
//
// Safety Monitor Block
//
////////////////////////////////////////////////////////////////////////

// Error Indication Registers
wire        safeMon_error_alarm;
wire [4:0]  safeMon_error_code;

safety_monitor safety_mon (
    .clk                (or1k_clk),
    .rst                (or1k_rst),

    // Mapping of SM error indications
    .alarm_in1          (lockstep_error_o),
    .alarm_in2          (parityMemToCpuInst_error),
    .alarm_in3          (parityMemToCpuData_error),
    .alarm_in4          (parityCpuDataToMem_error),
    .alarm_in5          (cp_ctrl_error),

    // Error Indication Output
    .sf_error_alarm_o   (safeMon_error_alarm),
    .sf_error_code_o    (safeMon_error_code)
);

    

endmodule
