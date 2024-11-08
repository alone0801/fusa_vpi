#!/bin/bash 

# 编译步骤
# pbs_sim FM_TEST hello.elf
#make vcs_good MACRO=$2
#make vcs_fault MACRO=$2

start_time=$(date +%s)
# 初始化变量
cd autoSOC_fusa
fault_dir=$1
rm -rf "$fault_dir"
EXE_PATH=$(pwd)
num_faults=$(($(cat fault.set | wc -l) - 1))
echo "The number of faults in batch inject compaign: $num_faults"
mkdir "$fault_dir"
cd "$fault_dir"

# 设置最大并行任务数限制
MAX_CONCURRENT_JOBS=20
PBS_SCRIPT="fault_inject.pbs"

# 创建PBS脚本模板
cat <<EOF > $PBS_SCRIPT
#!/bin/bash
#PBS -N fault_inject
#PBS -l nodes=1:ppn=1
#PBS -l walltime=01:00:00
#PBS -j oe
#PBS -o /dev/null
#PBS -e /dev/null

# 切换到工作目录
cd \$PBS_O_WORKDIR

# 设置EXE_PATH
EXE_PATH=$EXE_PATH

# 创建目录和fault.xml
dir_name="fault_sim_\$FOO"
mkdir "\$dir_name"
cd "\$dir_name" || exit

# 生成 XML 文件
echo '<?xml version="1.0" encoding="utf-8" ?>' > fault.xml
echo '<INJECT>' >> fault.xml
echo "    <ID>\$FOO</ID>" >> fault.xml
echo '</INJECT>' >> fault.xml

# 运行模拟
\$EXE_PATH/simv -l fault_sim.log +elf_load=\$SW_dir/Baremetal/sample_apps/hello.elf +clear_ram
EOF

# 提交PBS任务，并控制并发数量
for ((i = 1; i <= num_faults; i++)); do
    echo "FUSA_VPI::fault inject compaign num_$i submit"
    # 检查当前运行中的任务数，保持在 MAX_CONCURRENT_JOBS 以内
    while (( $(qstat  | grep -c "fault_inject") >= MAX_CONCURRENT_JOBS )); do
        sleep 10  # 等待10秒再检查一次
    done

    # 提交任务
    qsub -v FOO=$i $PBS_SCRIPT
done
end_time=$(date +%s)
echo "PBS Batch simulation time: $(($end_time - $start_time)) seconds"
