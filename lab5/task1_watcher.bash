#!/bin/bash

> details1.tmp.log

start=$(date +%s)
while true; do
    mem_process=$(top -b -n 1 | grep mem.bash)
    if [[ -z "mem_process" || $(echo $mem_process | awk '{print $8}') != "R" ]];
    then 
        exit
    else
        end=$(date +%s)
        elapsed=$(($end - $start))
        echo "Elapsed $elapsed seconds" >> details1.tmp.log
        top -b -n 1 | head -12 | tail -9 >> details1.tmp.log
    fi
sleep 1s
done