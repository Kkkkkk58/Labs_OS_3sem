#!/bin/bash

curr_ppid=0
curr_sum=0
curr_n=0
curr_line_index=0
file="$(cat task4.out)"
sed_pattern='s/^.*=//'

while read -r line;
do
    ppid=$(echo "$line" | awk -F':' '{print $2}' | sed "$sed_pattern")
    art=$(echo "$line" | awk -F':' '{print $3}' | sed "$sed_pattern")
    
    if [[ $ppid -eq $curr_ppid ]];
    then 
        if [ -n "$art" ]
        then curr_sum=$(echo "scale=5; $curr_sum+$art" | bc)
        fi
        (( ++curr_n ))
    else 
        mean_value=$(echo "scale=5; $curr_sum/$curr_n" | bc | awk '{printf "%.5f", $0}')
        insertion="$(printf "Average_Running_Children_of_ParentID=%s is %s\n" "$curr_ppid" "$mean_value")"
        sed -i "$curr_line_index a $insertion" task4.out
        (( ++curr_line_index ))
        (( curr_n = 1 ))
        curr_sum=$(echo "scale=5; $art" | bc)
        (( curr_ppid = ppid ))
    fi
    (( ++curr_line_index ))
done <<< "$file";
