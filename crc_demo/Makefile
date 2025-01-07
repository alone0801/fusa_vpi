export fusa_lib=~/fusa_vpi/vpi_lib
run:
	iverilog -f rtl.f -g2005-sv -D COUNT_MEM1
	vvp -n a.out
	gtkwave wave.vcd
var:
	verilator --sc foo.v --exe adder_tb.cpp 
clean:
	rm -rf csrc simv  simv.daidir fi_wrapper.v ucli.key result.xml *.vcd *.log *.out *.o *.dsn *.trn
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
	vcs -full64 +vpi +define+BYTE_COUNT_MEM1 -P $(fusa_lib)/pli.tab   \
	-load $(fusa_lib)/libvpiDebug.so  -f demo_rtl.cf fi_wrapper.sv -debug_all -sverilog \
	+define+FAULT_LOCATION=u_tb.dut_inst.mem1_i.mem_data_in[0] \
	+define+FAULT_VALUE=0 \
	+define+FAULT_TIME=80 -lxml2 \
	+lint=TFIPC-L -notice -debug_access+all  -full64  -kdb -lca
	./simv -l fault_sim.log
#-ucli -i ../vpi_lib/ucli.tcl
good_sim:
	python ../vpi_lib/wrapper_gen.py 
	rm -rf csrc simv  simv.daidir
	vcs +vpi +define+BYTE_COUNT_MEM1 -P $(fusa_lib)/pli.tab -full64 \
	-load $(fusa_lib)/libvpiDebug.so   -f demo_rtl.cf +define+good_sim -sverilog fi_wrapper.sv -lxml2 \
	+lint=TFIPC-L -notice -debug_access+all  -full64  -kdb -lca
	./simv -l good_sim.log 
test: 
	rm -rf csrc simv  simv.daidir
	vcs  +vpi +define+BYTE_COUNT_MEM1 -P ../vpi_lib/pli.tab -full64\
	-load ../vpi_lib/libvpiDebug.so -f demo_rtl.f fi_wrapper.v -debug_all -sverilog \
	+define+FAULT_LOCATION=u_tb.dut_inst.mem1_i.mem_data_in[0] \
	+define+FAULT_VALUE=0 \
	+define+FAULT_TIME=80 -lxml2 
	./simv -l fault_sim.log
VPI_FILES = $(fusa_lib)/vcdCompare.vpi
iverilog_good_sim:
	python ../vpi_lib/wrapper_gen.py 
	rm -rf csrc simv simv.vvp simv.daidir
	LD_PRELOAD=$(fusa_lib)/libvpiDebug.so
	iverilog -v -g2012 -DFULL64 -o simv.vvp -c demo_rtl.cf fi_wrapper.sv  \
	-Dgood_sim -DBYTE_COUNT_MEM1  \  	
	vvp -M. $(addprefix -m ,$(VPI_FILES))   ./simv.vvp
epicsim_good_sim:
	python ../vpi_lib/wrapper_gen.py 
	rm -rf csrc simv epicsim-run simv.daidir
	LD_PRELOAD=$(fusa_lib)/libvpiDebug.so
	LD_PRELOAD=/lib64/libxml2.so.2
	epicsim -v -g2012  -c demo_rtl.cf fi_wrapper.sv -m ../vpi_lib/libvpiDebug.so \
	-Dgood_sim -DBYTE_COUNT_MEM1  	
	epicsim-vvp epicsim-run 
fault_test:
	cd fault_sim_0;pwd;../simv -l fault_sim.log -ucli -i ../../vpi_lib/ucli.tcl
merge:
#python3 ../vpi_lib/result_merge.py
	rm -rf summary.xml
	sh report.sh ./fault_dir
irun:
	-loadvpi /usr/local/lib64/python3.6/site-packages/cocotb/libs/libcocotbvpi_ius.so:vlog_startup_routines_bootstrap +access+rwc
verdi:
	verdi -ssf test.fsdb  &
#-sswr ./signal.rc 
