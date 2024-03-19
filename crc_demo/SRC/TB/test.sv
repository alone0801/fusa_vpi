
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
`timescale 1ns/1ns
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
		TESTNAME = "RANDOM";
		// $value$plusargs("TESTNAME=%s", TESTNAME);

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
			mem1_data_in <= {$urandom(), $urandom(), $urandom(), $urandom()};

			forever begin
				// at next clock cycle
				@(negedge clk);

				mem1_wr      <= 1'b1;
				mem1_data_in <= mem1_data_in + 1;
			end
		end

		else if (TESTNAME == "BYTE_COUNT_MEM1") begin
			$display("-I- Start MEM1 byte count up : %0t", $time);
			mem1_data_in <= {$urandom(), $urandom(), $urandom(), $urandom()};

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
			mem2_data_in <= {$urandom(), $urandom()};

			forever begin
				// at next clock cycle
				@(negedge clk);

				mem2_wr      <= 1'b1;
				mem2_data_in <= mem2_data_in + 1;
			end
		end

		else if (TESTNAME == "BYTE_COUNT_MEM2") begin
			$display("-I- Start MEM2 byte count up : %0t", $time);
			mem2_data_in <= {$urandom(), $urandom()};

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

initial begin
	$dumpfile("wave.vcd");  			// 指定VCD波形文件的名字为wave.vcd，仿真信息将记录到此文件，wave.vcd文件将存储在当前目录下
	//$dumpfile("./simulation/wave.vcd");  	// wave.vcd文件将存储在当前目录下的simulation文件夹下
	$dumpvars(0, test );  				// 指定层次数为0，则tb模块及其下面各层次的所有信号将被记录，我们需要所有信号都被记录
						// 一定要设置一个仿真停止时间
end
/*
initial begin
	#100 $port_info(test.dut_inst);
    // #200 $FI(u_foo.d0.d_i);
    #200;
    // #10 $show_all_signals(test.dut_inst);
end
*/
  initial begin
  `ifdef good_sim
  $dumpfile("golden.vcd");
  $dumpvars(0);
  `else
   $vcdCompare("golden.vcd");
    $dumpfile("fault.vcd");
    $dumpvars(0);
  `endif
  end

endmodule // test

interface intf;

   reg mem1_err_detected_dly;

endinterface 
