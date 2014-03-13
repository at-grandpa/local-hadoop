#!/bin/bash

TIME_A=`date +%s`

date=`date`

echo "Start Date : ${date}"
echo "---------------------------------"
echo "vagrant provision ..."
vagrant provision

TIME_B=`date +%s`

PT=`expr ${TIME_B} - ${TIME_A}`
H=`expr ${PT} / 3600`
PT=`expr ${PT} % 3600`
M=`expr ${PT} / 60`
S=`expr ${PT} % 60`

echo "Elapsed Time : ${H} h ${M} m ${S} s"

