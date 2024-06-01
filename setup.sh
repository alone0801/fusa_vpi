export fusa_lib=${PWD}/vpi_lib
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${fusa_lib}/
export SW_dir=/home/ICer/fusa_vpi/autosoc-development/Software
#alias fusa_merge="rm -rf summary.xml ;python3 $fusa_lib/result_merge.py"
alias fusa_merge="rm -rf summary.xml ;sh $fusa_lib/report.sh"
alias rd_sim="$fusa_lib/fault.csh"

