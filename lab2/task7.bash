#!/bin/bash

start=$(date +%s)
for partial_table in $(ps -Ao pid=,command= | awk '{for (i=1; i<NF; i++) printf $i ":"; print $NF}')
do
    pid=$(echo "$partial_table" | awk -F':' '{print $1}')
    cmd=$(echo "$partial_table" | awk -F':' '{for (i=2; i<NF; i++) printf $i " "; print $NF}')

    read_bytes=$(grep -Es 'rchar' /proc/"$pid"/io | awk '{print $2}')
    if [ -n "$read_bytes" ];
    then
        echo "$pid:$read_bytes:$cmd"
    fi
done > task7.tmp
echo "Sleeping..."
end=$(date +%s)
sleep $(( 60 - (end - start) ))

while read -r str;
do
    pid=$(echo "$str" | awk -F':' '{print $1}')
    cmd=$(echo "$str" | awk -F':' '{for (i=3; i<NF-1; i++) printf $i " "; print $NF}')
    initial_bytes=$(echo "$str" | awk -F':' '{print $2}')
    read_bytes=$(grep -Es 'rchar' /proc/"$pid"/io | awk '{print $2}')
    (( total_bytes = read_bytes - initial_bytes ))
    echo "$pid: $initial_bytes - $read_bytes" >> pohui.tmp
    echo "$pid:$cmd:$total_bytes"
done < task7.tmp | sort -n -t ':' -k3 | tail -n 3