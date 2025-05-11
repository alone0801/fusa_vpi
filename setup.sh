#set env_var for this platform
export fusa_lib=${PWD}/vpi_lib
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${fusa_lib}/
#set env_var for autoSoC
export SW_dir=${PWD}/autosoc-development/Software
export SIM_dir=${PWD}/autosoc-development/Simulation
export HW_dir=${PWD}/autosoc-development/Hardware
export fault_dir=autoSOC_fusa
export MACRO=hello.elf
#alias fusa_merge="rm -rf summary.xml ;python3 $fusa_lib/result_merge.py"
alias fusa_merge="rm -rf summary.xml ;sh $fusa_lib/report.sh"
alias rd_sim="$fusa_lib/fault.csh"
alias pbs_sim="$fusa_lib/fault_pbs.csh"

