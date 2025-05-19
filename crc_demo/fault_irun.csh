#!/bin/bash

# 删除旧的 fault_dir 目录
rm -rf fault_dir

# 获取当前路径
EXE_PATH=$(pwd)

# 替换wire为scalared wire
make restore
make replace
# 计算 fault.set 文件的行数（减去标题行）
num_faults=$(cat fault.set | wc -l)
num_faults=$(($num_faults-1))
echo "The number of lines in fault.set is: $num_faults"

# 创建 fault_dir 目录
mkdir fault_dir
cd fault_dir || exit

# 设置 i 的增量（通过命令行参数传递）
step=${1:-1}  # 如果没有传递参数，默认 step 为 1
echo "Step value: $step"

# 记录脚本开始时间
start_time=$(date +%s)

# 循环创建目录并运行仿真
for ((i = 0; i < num_faults; i=i+step)); do
    dir_name="fault_sim_$((i+1))"
    mkdir "$dir_name"
    cd "$dir_name" || exit

    # 创建并写入 XML 文件
    echo '<?xml version="1.0" encoding="utf-8" ?>' > fault.xml
    echo '<INJECT>' >> fault.xml
    echo "    <ID>$((i+1))</ID>" >> fault.xml
    echo '</INJECT>' >> fault.xml

    # 运行仿真
    #$EXE_PATH/simv -l fault_sim.log -ucli -i $EXE_PATH/../vpi_lib/ucli.tcl
    irun -R -64bit -access +rwc -messages -l fault_sim_irun.log -input $fusa_lib/ucli.tcl -nclibdirname $EXE_PATH/INCA_libs -snapshot my_snapshot
    # 返回上一级目录
    cd .. || exit
done
cd .. || exit
# 记录脚本结束时间
end_time=$(date +%s)

# 计算并输出执行时间
execution_time=$((end_time - start_time))
logfile_name="$step.log"
# touch "$logfile_name"
make restore
echo "Total execution time: $execution_time seconds"
