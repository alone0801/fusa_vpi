#!/bin/bash
FAULT_DIR=$1
python3 ../vpi_lib/result_merge.py $1 result.xml
UU=$(grep -c "UU" result.xml)
UD=$(grep -c "UD" result.xml)
DU=$(grep -c "DU" result.xml)
DD=$(grep -c "DD" result.xml)
FC=$(awk -v a=$UD -v b=$DU -v c=$DD 'BEGIN {
    result = (a + c) / (a + b + c) * 100;
    printf "%.2f", result
}')
echo "UU: $UU ">> summary.xml
echo "UD: $UD ">> summary.xml
echo "DU: $DU ">> summary.xml
echo "DD: $DD ">> summary.xml
echo "Fault Coverage: $FC% ">> summary.xml
echo "verbose classification generate in result.xml"
echo "summary classification generate in summary.xml"

