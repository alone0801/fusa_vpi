#!/bin/bash
FAULT_DIR=$1
good_sim_log=$2
FI_file=$3
time_file=$4
python3 ../vpi_lib/result_merge.py $1 result.xml summary.xml $2 $3 $4
echo "verbose classification generate in result.xml"
echo "summary classification generate in summary.xml"

