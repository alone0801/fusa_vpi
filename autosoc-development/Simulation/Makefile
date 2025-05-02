#LD_LIBRARY_PATH := $(LD_LIBRARY_PATH):~/fusa_vpi/vpi_lib/
#export LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):~/fusa_vpi/vpi_lib/

#ex_test:
#	echo $(LD_LIBRARY_PATH)
#########################
# Makefile Configuration
#########################

## Read Global Variables
# Location of project Folders
SIMDIR:= $(SIM_DIR)

# Location of Simulation Files
FILESDIR:= $(FILES_DIR)

# Simulation Command
#SIM:= xrun
SIM:= irun -64bit

# Simulation Arguments
PLUSARGS:= $(PLUS_ARGS)

## Build Directory
BUILDDIR:= builddir
#BUILDDIR:= debugTest

#########################
# Makefile Targets
#########################
default:
	@echo "For more info: make help"

help: 
	@echo "------------------------------------------------------------------------------"
	@echo "Pre Requisites:"
	@echo "		1- Check if libelf is installed:"
	@echo "			#> whereis libelf"
	@echo ""
	@echo "		2- Check if the path to libelf is setup in the environment LD_LIBRARY_PATH: "
	@echo '			#> echo $$LD_LIBRARY_PATH'
	@echo ""
	@echo "		3- Set the simulation configuration environment variables"
	@echo "			#> source tools/set_env_variables.csh (or tools/set_env_variables.sh)"
	@echo "------------------------------------------------------------------------------"
	@echo ""
	@echo "------------------------------------------------------------------------------"
	@echo "Targets:"
	@echo "		- clean:	- rm -rf builddir"
	@echo "		- elab:		- Elaboration of Design based on xrunElab.f file list. "
	@echo "		        	  Project build files will be located on builddir. "
	@echo "		- sim: 		- Simulation of buildir folder. (Without Fault Injection)"
	@echo "		- debug: 	- Open the Xcelium GUI on the builddir folder"
	@echo "		- good_sim: 	- Good Simulation of buildir folder based on strobe.list file"
	@echo "		- fault_sim: 	- Execution of Fault Injection Simulation script."
	@echo "		- all: 		- clean + elab + good_sim + fault_sim"
	@echo "------------------------------------------------------------------------------"

all: clean elab good_sim fault_sim

$(BUILDDIR):
	@mkdir -p $@

#########################
# Elaboration of Design
elab: $(BUILDDIR) 
	@cd $<; $(SIM) -f $(FILESDIR)/xrunElab.f -l xrun_elab.log -f $(FILESDIR)/xrunPlusArgs.f

#########################
# Regular simulation
sim: $(BUILDDIR) elab
	@cd $<; $(SIM) -R -run -exit -licq -append_log -l logs/xrun_sim_run.log -f $(FILESDIR)/xrunPlusArgs.f

#########################
# Regular simulation
debug: $(BUILDDIR) elab
	@cd $<; $(SIM) -R -gui -licq -f $(FILESDIR)/xrunPlusArgs.f

#########################
# Good Simulation including Strobes configuration - Required for Fault Injection
good_sim: $(BUILDDIR) elab
	@cd $<; $(SIMDIR)/tools/create_strobe_conf.csh $(FILESDIR)/strobes.list
	@cd $<; $(SIM) -R -fault_good_run -input fault_db/good_run.tcl -run -exit -licq -append_log -l logs/xrun_good_run.log -f $(FILESDIR)/xrunPlusArgs.f

#########################
# Fault Injection Campaign. Fault Injection controled by script
fault_sim: $(BUILDDIR)
	@cd $<; $(FILESDIR)/$(FAULT_SCRIPT)

#########################
# Delete the Build Directory
clean:
	rm -rf $(BUILDDIR)
	cd  ${fault_dir}/ && \
	rm -rf csrc simv ucli.key mor1kx-general.log mor1kx-trace.log compile.log  simv.daidir verdiLog *.vcd *.log

#/home/ICer/fusa_vpi/autosoc-development/Hardware/TB/jtag_vpi_0-r2/jtag_vpi.so
vcs_good:
	source tools/set_env_variables.sh && \
	cd ${fault_dir}/ && \
	python $(fusa_lib)/wrapper_gen.py && \
	rm -rf csrc simv  simv.daidir	&& \
	vcs +vpi +define+BYTE_COUNT_MEM1 -P $(fusa_lib)/pli.tab \
	-load  \
	$(HW_dir)/TB/elf-loader_1.0.2/elf-loader.so \
	-f rtl.f fi_wrapper.sv +define+good_sim   -lxml2 -lelf -sverilog \
	+define+LOCKSTEP \
	-l compile.log +lint=TFIPC-L -notice -debug_access+all  -full64  -kdb -lca &&\
	./simv -l good_sim.log \
	+elf_load=$(SW_dir)/Baremetal/sample_apps/$(MACRO) +clear_ram \
#-kdb -lca 
#	-ucli -i $(fusa_lib)/ucli.tcl

vcs_sim:
	source tools/set_env_variables.sh && \
	cd ${fault_dir}/ && \
	rm -rf csrc simv  simv.daidir	&& \
	vcs  +vpi +define+BYTE_COUNT_MEM1 -P $(fusa_lib)/pli.tab \
	-load  \
	$(HW_dir)/TB/elf-loader_1.0.2/elf-loader.so \
	-f rtl.f  +define+good_sim   -lxml2 -lelf -sverilog \
	+define+CHECKPOINT +define+LOCKSTEP +define+PARITY +define+MEMECC \
	-l compile.log +lint=TFIPC-L -notice -debug_access+all  -full64  -kdb -lca &&\
	./simv -l good_sim.log \
	+elf_load=$(SW_dir)/Baremetal/sample_apps/$(MACRO) +clear_ram \


#+elf_load=$(SW_dir)/Baremetal/sample_apps/can_selftest.elf +clear_ram  
#+define+CHECKPOINT +define+LOCKSTEP +define+PARITY +define+MEMECC \

vcs_fault:
	source tools/set_env_variables.sh && \
	cd ${fault_dir}/ && \
	rm -rf csrc simv  simv.daidir	&& \
	vcs +vpi  -P $(fusa_lib)/pli.tab -L$(fusa_lib) -load  \
	$(HW_dir)/TB/elf-loader_1.0.2/elf-loader.so \
	-f rtl.f fi_wrapper.sv +define+fault_sim   -lxml2 -lelf -sverilog \
	+define+LOCKSTEP \
	-l compile.log +lint=TFIPC-L -notice -debug_access+all  -full64  -kdb -lca &&\
	./simv -l fault_sim.log +elf_load=$(SW_dir)/Baremetal/sample_apps/$(MACRO) +clear_ram \
    -ldb -lca  -ucli -i $(fusa_lib)/ucli.tcl

list:
	find $(HW_dir)  -name "*.sv" -or -name "*.v" >> $(fault_dir)/rtl.f	
verdi:
	cd ${fault_dir} && \
	verdi -ssf test.fsdb  -sswr ./signal.rc 
verdi_fault:
	cd ${fault_dir} && \
	verdi -ssf fault.fsdb
verdi_good:
	cd ${fault_dir} && \
	verdi -ssf good.fsdb

good_sim_irun: restore
	source tools/set_env_variables.sh && \
	cd ${fault_dir}/ && \
	python $(fusa_lib)/wrapper_gen.py && \
	irun -clean -sv -f rtl.f fi_wrapper.sv +define+good_sim +define+LOCKSTEP +elf_load=$(SW_dir)/Baremetal/sample_apps/$(MACRO) +clear_ram -lxm2 -lelf -64bit -L$(fusa_lib) -afile $(SIM_dir)/autoSOC_fusa/autoSoC.tab  -loadvpi $(HW_dir)/TB/elf-loader_1.0.2/elf-loader_irun.so:setup_reset_callbacks,setup_endofcompile_callbacks,setup_finish_callbacks,register_check_for_command,register_send_result_to_server,vpit_RegisterTfs,setup_user_functions -access +rwc -messages -l good_sim_irun.log

fault_sim_irun: restore replace
	source tools/set_env_variables.sh && \
	cd ${fault_dir}/ && \
	irun -clean -sv -f rtl.f fi_wrapper.sv +define+LOCKSTEP +elf_load=$(SW_dir)/Baremetal/sample_apps/$(MACRO) +clear_ram -lxm2 -lelf -64bit -L$(fusa_lib) -afile $(SIM_dir)/autoSOC_fusa/autoSoC.tab -loadvpi $(HW_dir)/TB/elf-loader_1.0.2/elf-loader_irun.so:setup_reset_callbacks,setup_endofcompile_callbacks,setup_finish_callbacks,register_check_for_command,register_send_result_to_server,vpit_RegisterTfs,setup_user_functions -access +rwc -messages -l fault_sim_irun.log -input $(fusa_lib)/ucli.tcl -snapshot my_snapshot
	make restore
FILE_LIST = ${fault_dir}/rtl_t.f
FILES = $(shell cat $(FILE_LIST))
replace: backup replace_wire

replace_wire:
	@for file in $(FILES); do \
		echo "Replacing in $$file..."; \
		sed -i '/wire[[:space:]]*\[[^]]\+\]/s/\<wire\>/wire scalared/g' $$file; \
		sed -i '/output[[:space:]]*\[[^]]\+\]/s/\<output\>/output wire scalared/g' $$file; \
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
	sh ./autoSOC_fusa/report.sh ./autoSOC_fusa/fault_dir

