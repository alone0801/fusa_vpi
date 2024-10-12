/* ****************************************************************************
  This Source Code Form is subject to the terms of the
  Open Hardware Description License, v. 1.0. If a copy
  of the OHDL was not distributed with this file, You
  can obtain one at http://juliusbaxter.net/ohdl/ohdl.txt

  Description: AutoSoC Testbench

  For more information access: http://www.autosoc.org

***************************************************************************** */
`include "test-defines.v"
module autosoc_tb;

   localparam MEM_SIZE = 32'h02000000; //Set default memory size to 32MB

   vlog_tb_utils vlog_tb_utils0();

    ////////////////////////////////////////////////////////////////////////
    //
    // JTAG VPI interface
    //
    ////////////////////////////////////////////////////////////////////////

    wire tms;
    wire tck;
    wire tdi;
    wire tdo;

    reg enable_jtag_vpi;
    initial enable_jtag_vpi = $test$plusargs("enable_jtag_vpi");

    jtag_vpi jtag_vpi0
    (
        .tms		(tms),
        .tck		(tck),
        .tdi		(tdi),
        .tdo		(tdo),
        .enable		(enable_jtag_vpi),
        .init_done	(autosoc_tb.dut.wb_rst)
    );

   ////////////////////////////////////////////////////////////////////////
   //
   // ELF program loading
   //
   ////////////////////////////////////////////////////////////////////////
   integer mem_words;
   integer i;
   reg [31:0] mem_word;
   reg [1023:0] elf_file;

   initial begin
      if ($test$plusargs("clear_ram")) begin
	$display("Clearing RAM");
        for(i=0; i < MEM_SIZE; i = i+1) begin
            // Zeroize Memory
	    autosoc_tb.dut.wb_bfm_memory0.memECC.ram0.mem[i] = 32'h00000000;
        end
      end
        
      if($value$plusargs("elf_load=%s", elf_file)) begin
	 $elf_load_file(elf_file);

	 mem_words = $elf_get_size/4;
	 $display("Loading %d words", mem_words);

        for(i=0; i < mem_words; i = i+1) begin
	    autosoc_tb.dut.wb_bfm_memory0.memECC.ram0.mem[i] = $elf_read_32(i*4);
        end

      end else
	$display("No ELF file specified");
    
   end

   ////////////////////////////////////////////////////////////////////////
   //
   // Clock and reset generation
   //
   ////////////////////////////////////////////////////////////////////////
    reg syst_clk = 1;
    reg syst_rst;
    
    // Clock Frequency: 200Mhz
    //always #2.5 syst_clk <= ~syst_clk;
    
    // Clock Frequency: 100Mhz
    //always #5 syst_clk <= ~syst_clk;
    
    // Clock Frequency: 50Mhz
    always #10 syst_clk <= ~syst_clk;

    // Make sure of the order Simulator is dealing with reset signal
    initial begin
        #1;
        syst_rst = 1;

        #100 syst_rst <= 0;
       // #100000 $finish();
    end

   ////////////////////////////////////////////////////////////////////////
   //
   // mor1kx monitor
   //
   ////////////////////////////////////////////////////////////////////////
   mor1kx_monitor #(.LOG_DIR(".")) i_monitor();

   ////////////////////////////////////////////////////////////////////////
   //
   // CAN Controller
   //
   ////////////////////////////////////////////////////////////////////////
    wire can_loopback_tx;
    wire can_loopback_rx;
    wire can_loopback_bus_off_on;


   ////////////////////////////////////////////////////////////////////////
   //
   // DUT
   //
   ////////////////////////////////////////////////////////////////////////
    autosoc_top
    #(
        .MEM_SIZE           (MEM_SIZE),
        .OPTION_CPU         (`CPU_CONFIG),
        .OPTION_PARITY      (`PARITY_CONFIG),
        .OPTION_CHECKPOINT  (`CHECKPOINT_CONFIG),
        .OPTION_MEMECC      (`MEMECC_CONFIG)
    )
    dut
    (
        .wb_clk_i       (syst_clk),
        .wb_rst_i       (syst_rst),
        .tms_pad_i      (tms),
        .tck_pad_i      (tck),
        .tdi_pad_i      (tdi),
        .tdo_pad_o      (tdo),
        .uart_stx       (),
        .uart_srx       (),
        //.can_rx_i       (can_loopback_rx),
        .can_rx_i       (1'b1),
        .can_tx_o       (can_loopback_tx),
        .can_bus_off_on (can_loopback_bus_off_on) 
    );

initial begin
      $fsdbDumpfile("test.fsdb");
      $fsdbDumpvars(0,autosoc_tb);
end


endmodule
