export fusa_vpi = ${PWD}/../vpi_lib
clean:
	rm -rf csrc simv  simv.daidir fi_wrapper.v ucli.key result.xml *.vcd *.log *.out *.o *.dsn *.trn *.history
	rm -rf fault_pruning_dir
	mkdir fault_pruning_dir
list:
	find SRC/ -name "*.sv" -or -name "*.v" >rtl.f
#good_sim:
#	rm -rf csrc simv  simv.daidir
#	vcs +vpi +define+TESTNAME=COUNT_MEM1 -P ../vpi_lib/vcdCompare.tab \
#	../vpi_lib/*.c  -f demo_rtl.f +define+good_sim -sverilog
#	simv -l good_sim.log
fault_sim_vcs: restore
	rm -rf csrc simv  simv.daidir
	vcs +vpi +define+COUNT_MEM1 -P $(fusa_lib)/pli.tab   \
	-load $(fusa_lib)/libvpiDebug.so\
	-f rtl.f fi_wrapper.sv +define+fault_sim -lxml2 -sverilog \
	+lint=TFIPC-L -notice -debug_access+all  -full64  -kdb -lca
	./simv -l fault_sim.log -kdb -lca\
	-ucli -i ../vpi_lib/ucli.tcl
good_sim_vcs: restore
	python ../vpi_lib/wrapper_gen.py 
	rm -rf csrc simv  simv.daidir
	vcs +vpi +define+COUNT_MEM1 -P $(fusa_lib)/pli.tab \
	-load $(fusa_lib)/libvpiDebug.so \
	-f rtl.f fi_wrapper.sv +define+good_sim -lxml2 -sverilog \
	+lint=TFIPC-L -notice -debug_access+all  -full64  -kdb -lca
	./simv -l good_sim.log \
	-ucli -i $(fusa_lib)/ucli.tcl

fault_pruning_vcs: restore
	rm -rf csrc simv simv.daidair fault_pruning.log fault_pruning_dir
	python $(fusa_lib)/wrapper_gen.py
	vcs -full64 +vpi +define+fault_pruning -P $(fusa_lib)/VRM_vpi.tab   \
	$(fusa_lib)/VRM_vpi.c  -f rtl.f fi_wrapper.sv -debug_all -sverilog \
	-lxml2 \
	+lint=TFIPC-L -notice -debug_access+all  -full64  -kdb -lca
	./simv -l fault_pruning.log
	mkdir fault_pruning_dir

fault_gene:
	python $(fusa_lib)/vpi_process.py

good_sim_irun: restore
	python ../vpi_lib/wrapper_gen.py 
	irun -clean -sv -f rtl.f fi_wrapper.sv +define+good_sim +define+COUNT_MEM1 \
	-lxml2 -64bit \
	-afile $(fusa_lib)/vcdCompare.tab \
	-loadvpi $(fusa_lib)/libvpiDebug_irun.so:vpit_RegisterTfs -access +rwc -messages -l good_sim.log

fault_sim_irun: restore replace
	irun -clean -sv -f rtl.f fi_wrapper.sv +define+COUNT_MEM1 \
	-lxml2 -64bit \
	-afile $(fusa_lib)/vcdCompare.tab \
	-loadvpi $(fusa_lib)/libvpiDebug_irun.so:vpit_RegisterTfs -access +rwc -messages -l fault_sim.log -input $(fusa_lib)/ucli.tcl -snapshot my_snapshot
	make restore

fault_classification:
	python $(fusa_lib)/fault_classification.py

FILE_LIST = rtl.f
FILES = $(shell grep -v '^[[:space:]]*//' $(FILE_LIST))
replace: backup replace_wire

replace_wire:
	@for file in $(FILES); do \
		echo "Replacing in $$file..."; \
		sed -i '/wire[[:space:]]*\[[^]]\+\]/s/\<wire\>/wire scalared/g' $$file; \
		sed -i '/output[[:space:]]*\[[^]]\+\]/s/\<output\>/output wire scalared/g' $$file;\
		sed -i '/input[[:space:]]*\[[^]]\+\]/s/\<input\>/input wire scalared/g' $$file;\
	done

backup:
	@for file in $(FILES); do \
		if [ -f $$file.back ]; then \
			echo "$$file.back is exist"; \
		else \
			cp $$file $$file.back; \
		fi \
	done

restore:
	@for file in $(FILES); do \
		if [ -f $$file.back ]; then \
			echo "Restoring $$file..."; \
			mv $$file.back $$file; \
		else \
			echo "No backup for $$file"; \
		fi \
	done

merge:
	rm -rf summary.xml
	sh report.sh ./fault_dir ./good_sim.log ./FI.xml ./fault_dir/time.log
