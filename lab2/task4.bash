#!/bin/bash

for pid in $(ps -Ao pid=)
do 
    path="/proc/""$pid"
    ppid=$(grep -Es 'PPid' "$path"/status | awk '{print $2}')
    sum_exec_runtime=$(grep -Es 'sum_exec_runtime' "$path"/sched | awk '{print $3}')
    nr_switches=$(grep -Es 'nr_switches' "$path"/sched | awk '{print $3}')

    if [ -z "$sum_exec_runtime" ] || [ -z "$nr_switches" ];
    then art=0;
    else art=$(echo "scale=5; $sum_exec_runtime/$nr_switches" | bc | awk '{printf "%.5f", $0}')
    fi

    echo "$pid $ppid $art"
done | sort -n -k2 | awk '{print "Process ID="$1" : Parent_ProcessID="$2" : Average_Running_Time="$3""}' > task4.out