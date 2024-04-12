
//__CDS_SVN_TAG__
// $URL: file:///projects/cdnsfs/svn_repo/ifss_vmgr_flow_proj/trunk/demo/SRC/TB/test.sv $ $Id: test.sv 667 2016-11-15 17:44:59Z ferlini $
// ------------------------------------------------------------------------------
// Copyright (c) 2018 by Cadence Design Systems, All Rights Reserved.
//
// This software is provided as is without warranty of any kind.	The entire risk
// as to the results and performance of this software is assumed by the user.
//
// Cadence Design Systems disclaims all warranties, either express or implied,
// including but not limited, the implied warranties of merchantability, fitness
// for a particular purpose, title and no infringement, with respect to this
// software.
//
// No technical support is guaranteed for this code. If you have any suggestion
// or improvement feel free to contact your Cadence representative.
// ------------------------------------------------------------------------------
//__CDS_SVN_TAG__

module test;

	// system signals
	reg         clk;
	reg         rst_n;

	// MEM1
	reg          mem1_wr;
	reg   [31:0] mem1_data_in;
	wire   [31:0] mem1_data_out;
	wire          mem1_err_detected;
	wire          mem1_err_corrected;

	// MEM2
	reg         mem2_wr;
	reg   [7:0] mem2_data_in;
	wire   [7:0] mem2_data_out;
	wire         mem2_err_detected;
	wire         mem2_err_corrected;

	// TB
	reg   [7:0] cnt;
	reg   	    sync;
	int 		nr_cycles;
	int 		run_cycles;

	// TB - FILE
	integer 	 fh, r;
    reg [25*8:0] TESTNAME;
    reg [25*8:0] test_name;
	reg [25*8:0] test_kind;
	reg [25*8:0] test_date;

	localparam ACTIVITY = 0;  // 9 = 10% activity  (generate random number 0-9, activity is when nr%ACTIVITY == 0

	//----------------------------------------------------------------------
	// Read TB File (e.g., memory file)
	//----------------------------------------------------------------------
	initial begin
		
		//$value$plusargs("TESSRC/TB/test.svTNAME=%s", TESTNAME);
`ifdef RANDOM
        TESTNAME ="RANDOM";
`endif
`ifdef COUNT_MEM1
        TESTNAME = "COUNT_MEM1";
`endif
`ifdef COUNT_MEM2
        TESTNAME = "COUNT_MEM2";
`endif
`ifdef BYTE_COUNT_MEM1
        TESTNAME = "BYTE_COUNT_MEM1";
`endif
`ifdef BYTE_COUNT_MEM2
        TESTNAME = "BYTE_COUNT_MEM2";
`endif

		wait(rst_n === 1'b1);
		@(negedge clk);

		fh = 0;
		if (TESTNAME == "COUNT_MEM1")
			fh = $fopen("test_mem.data", "r");
		else if (TESTNAME == "BYTE_COUNT_MEM1")
			fh = $fopen("test_mem.data", "r");
		else if (TESTNAME == "COUNT_MEM2")
			fh = $fopen("test_mem.data", "r");
		else if (TESTNAME == "BYTE_COUNT_MEM2")
			fh = $fopen("test_mem.data", "r");
		else if (TESTNAME == "RANDOM")
			fh = $fopen("test_mem.data", "r");
		
		if (!fh) begin
			$display("-E- Could not open the test_*.data file");
		end
		else begin
			r = $fscanf(fh, "%s %s %s", test_name, test_kind, test_date);
			$display("-TB- (TEST NAME) = %s", test_name);
			$display("-TB- (TEST_TYPE) = %s", test_kind);
			$display("-TB- (TEST_DATE) = %s", test_date);
		end
		$fclose(fh);
	end

	//----------------------------------------------------------------------
	// DUT
	//----------------------------------------------------------------------
	dut dut_inst(
		.clk                (clk),
		.rst_n              (rst_n),
		.mem1_wr            (mem1_wr),
		.mem1_data_in       (mem1_data_in),
		.mem1_data_out      (mem1_data_out),
		.mem1_err_detected  (mem1_err_detected),
		.mem1_err_corrected (mem1_err_corrected),
		.mem2_wr            (mem2_wr),
		.mem2_data_in       (mem2_data_in),
		.mem2_data_out      (mem2_data_out),
		.mem2_err_detected  (mem2_err_detected),
		.mem2_err_corrected (mem2_err_corrected)
	);

	//----------------------------------------------------------------------
	// Clock
	//----------------------------------------------------------------------
	initial begin
		clk <= 0;
		forever #5 clk <= ~clk;
	end

	//----------------------------------------------------------------------
	// Reset
	//----------------------------------------------------------------------
	initial begin
		rst_n <= 0;
		repeat(5) @(posedge clk);
		rst_n <= 1;
		$display("-I- %0t: Reset is done.", $time);
	end

	//----------------------------------------------------------------------
	// Stop Simulation by Time Out - Cycle Based
	//----------------------------------------------------------------------
	initial begin

		// Wait until rst is done
		wait(rst_n === 1'b1);

		run_cycles = $urandom_range(100, 100);
		$display("-I- Run Cycles : %d", run_cycles);

		repeat(run_cycles) @(posedge clk);

		$display("-I- Cycle based timeout occurred : %0t", $time);
		$display("-I- Simulation successfully completed!");
		$finish;
	end

	// count cycles and generate sync signal
	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			nr_cycles <= 0;
			sync      <= 1'b0;
		end
		else begin
			nr_cycles <= nr_cycles + 1;
			if (nr_cycles * 1.1 > run_cycles) sync <= 1'b1;
		end
	end

	//----------------------------------------------------------------------
	// Report detected errors
	//----------------------------------------------------------------------
	// Error detected at MEM1
	always @(posedge mem1_err_detected) begin
           $display("-E- [MEM1] CRC error detected : %0t", $time);
        end

	// Error detected at MEM2
	always@(posedge mem2_err_detected) $display("-E- [MEM2] CRC error detected : %0t", $time);

// Interface Instantiation to let fault pass through unsupported construct
        intf intf_inst();

        always @ ( posedge clk ) begin
            intf_inst.mem1_err_detected_dly <=  mem1_err_detected;
        end

	//----------------------------------------------------------------------
	// Stimulus
	//----------------------------------------------------------------------
	initial begin
		// default values
		mem1_wr            <= 0;
		mem1_data_in       <= 0;

		mem2_wr            <= 0;
		mem2_data_in       <= 0;

		cnt                <= 0;

		// Wait until rst is done
		wait(rst_n === 1'b1);

		if (TESTNAME == "COUNT_MEM1") begin
			$display("-I- Start MEM1 count up : %0t", $time);
			mem1_data_in <= {4'b0,4'b0,4'b0,4'b0};

			forever begin
				// at next clock cycle
				@(negedge clk);

				mem1_wr      <= 1'b1;
				mem1_data_in <= mem1_data_in + 1;
			end
		end

		else if (TESTNAME == "BYTE_COUNT_MEM1") begin
			$display("-I- Start MEM1 byte count up : %0t", $time);
			mem1_data_in <= {4'b0,4'b0,4'b0, 4'b0};

			forever begin
				// at next clock cycle
				@(negedge clk);

				mem1_wr      <= 1'b1;
				mem1_data_in <= {cnt, cnt, cnt, cnt};
				cnt          <= cnt + 1;
			end
		end

		else if (TESTNAME == "COUNT_MEM2") begin
			$display("-I- Start MEM2 count up : %0t", $time);
			mem2_data_in <= {4'b0, 4'b0};

			forever begin
				// at next clock cycle
				@(negedge clk);

				mem2_wr      <= 1'b1;
				mem2_data_in <= mem2_data_in + 1;
			end
		end

		else if (TESTNAME == "BYTE_COUNT_MEM2") begin
			$display("-I- Start MEM2 byte count up : %0t", $time);
			mem2_data_in <= {4'b0, 4'b0};

			forever begin
				// at next clock cycle
				@(negedge clk);

				mem2_wr      <= 1'b1;
				mem2_data_in <= cnt;
				cnt          <= cnt + 1;
			end
		end

		else if (TESTNAME == "RANDOM") begin
			// Sequential values
			$display("-I- Start MEM1, MEM2 random : %0t", $time);

			forever begin
				// at next clock cycle
				@(negedge clk);

				// calculate random data
				if ($urandom_range(ACTIVITY) == 0) begin
					mem1_wr      <= $urandom();
					mem1_data_in <= {$urandom(), $urandom(), $urandom(), $urandom()};
				end

				if ($urandom_range(ACTIVITY) == 0) begin
					mem2_wr      <= $urandom();
					mem2_data_in <= {$urandom(), $urandom()};
				end
			end
		end

   end
    reg[7:0] a,b,c,d;
    reg[4:0] te_var;
    wire result,result1,result2;
    assign result = ((a+b)<(c*d))?0:1;
    assign result2 = te_var>4'd8;
    assign result1 = 4'd8+4'd8>4'd8;
    initial begin
       #20;
        a=12;
        te_var=5'b10000;
        b=13;
        c=5;
        d=7;
        end
endmodule // test

interface intf;

   reg mem1_err_detected_dly;

endinterface 
