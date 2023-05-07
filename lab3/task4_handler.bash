#!/bin/bash

if [ $# -ne 1 ];
then echo "Handler: pname not provided"
    exit 1
fi
pids=($(top -o TIME+ -n 1 -b -p "$(pgrep -d',' -f "$1")" | sed 1,7d | awk '{print $1}'))

./task4_resources.bash "${pids[0]}" &

kill "${pids[2]}"