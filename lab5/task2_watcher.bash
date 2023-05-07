#!/bin/bash

> details2.log

start=$(date +%s)
while true; do
    mem_process=$(top -b -n 1 | grep mem[2]*.bash)
    if [[ -z "mem_process" ]];
    then 
        exit
    else
        end=$(date +%s)
        elapsed=$(($end - $start))
        echo "Elapsed $elapsed seconds" >> details2.log
        top -b -n 1 | head -12 | tail -9 >> details2.log
    fi
sleep 1s
done