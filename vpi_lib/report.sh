#!/bin/bash
FAULT_DIR=$1
rm -rf result_$1.xml
rm -rf summary_$1.xml
python3  $fusa_lib/result_merge.py $1 result_$1.xml
echo "UU: $(grep -c "UU" result_$1.xml) ">> summary_$1.xml
echo "UD: $(grep -c "UD" result_$1.xml) ">> summary_$1.xml
echo "DU: $(grep -c "DU" result_$1.xml) ">> summary_$1.xml
echo "DD: $(grep -c "DD" result_$1.xml) ">> summary_$1.xml
echo "verbose classification generate in result_$1.xml"
echo "summary classification generate in summary_$1.xml"

