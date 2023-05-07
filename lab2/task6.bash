#!/bin/bash

max_memory=0;
max_pid=0;
for pid in $(ps -Ao pid=)
do 
    size=$(grep -Es 'VmSize' /proc/"$pid"/status | awk '{print $2}')

    if [ -n "$size" ] && [ "$size" -gt $max_memory ];
    then 
        (( max_memory = size ));
        (( max_pid = pid ));
    fi
done

from_top_pid=$(top -o VIRT -n 1 -b | sed 1,7d | head -1 | awk '{print $1}')

if [[ $max_pid -eq $from_top_pid ]]
then printf "Processes are equal: %i \nThe process takes %i kb\n" "$max_pid" "$max_memory"
else echo "Cringe"
fi 