run:
	iverilog -f rtl.f -g2005-sv -D COUNT_MEM1
	vvp -n a.out
	gtkwave wave.vcd
var:
	verilator --sc foo.v --exe adder_tb.cpp 
clean:
	rm -rf csrc simv  simv.daidir fi_wrapper.v ucli.key result.xml *.vcd *.log *.out *.o
vpi:
#编译vpi对应的c函数,生成hello.o，hello.vpi
	iverilog-vpi vpi.c
#编译tb与dut
	iverilog -f rtl.f -g2005-sv -D COUNT_MEM1 -o crc_mem.vvp
#-M.指定搜索路径 hello指定对应C的编译结果
	vvp -M. -m vpi crc_mem.vvp
	gtkwave wave.vcd
list:
	find SRC/ -name "*.sv" -or -name "*.v" >rtl.f
vsim:
	gcc -c -g -m64 -Wall -ansi -pedantic -I. -I /home/mentor/questasim/include/ vpi_vsim.c -fPIC -o vpi.o
	ld -G -o vpi.sl vpi.o 
	vlib work
	vlog -f rtl.f 
	vsim -c -pli vpi.sl test_new -do "run -all;exit" +TESTNAME=COUNT_MEM1
vcs:
	vcs -f rtl.f -P vpi.tab +vpi -sverilog vpi.c -debug_access
	./simv
#good_sim:
#	rm -rf csrc simv  simv.daidir
#	vcs +vpi +define+TESTNAME=COUNT_MEM1 -P ../vpi_lib/vcdCompare.tab \
#	../vpi_lib/*.c  -f demo_rtl.f +define+good_sim -sverilog
#	simv -l good_sim.log
fault_sim:
	rm -rf csrc simv  simv.daidir
	vcs  +vpi +define+TESTNAME=COUNT_MEM1 -P ../vpi_lib/vpiDebug.tab \
	../vpi_lib/*.c  -f demo_rtl.f fi_wrapper.v -debug_all -sverilog \
	+define+FAULT_LOCATION=u_tb.dut_inst.mem1_i.mem_data_in[0] \
	+define+FAULT_VALUE=0 \
	+define+FAULT_TIME=80 -lxml2 
	simv -l fault_sim.log -ucli -i ../vpi_lib/ucli.tcl
good_sim:
	python ../vpi_lib/wrapper_gen.py 
	rm -rf csrc simv  simv.daidir
	vcs +vpi +define+TESTNAME=COUNT_MEM1 -P ../vpi_lib/vcdCompare.tab \
	../vpi_lib/*.c  -f demo_rtl.f +define+good_sim -sverilog fi_wrapper.v -lxml2
	simv -l good_sim.log 
test: 
	vcs +vpi +define+TESTNAME=COUNT_MEM1 -P ../vpi_lib/pli.tab \
      ../vpi_lib/*.c  -f demo_rtl.f +define+good_sim -sverilog fi_wrapper.v \
	  -load  ../vpi_lib/libvpiDebug.a

