#!/bin/bash
FAULT_DIR=$1
python3  $fusa_lib/result_merge.py $1 result.xml
echo "UU: $(grep -c "UU" result.xml) ">> summary.xml
echo "UD: $(grep -c "UD" result.xml) ">> summary.xml
echo "DU: $(grep -c "DU" result.xml) ">> summary.xml
echo "DD: $(grep -c "DD" result.xml) ">> summary.xml
echo "verbose classification generate in result.xml"
echo "summary classification generate in summary.xml"

