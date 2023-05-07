#!/bin/bash

[ $# -ne 1 ] && echo "Invalid input" && exit 1

for (( i = 0; i != $1; ++i ));
do
    (( a = -1000 + $i )) 
    (( b = $a + 2000 ))
    ./algorithm.exe $a $b 0.000001 > /dev/null &
done

while true
do
    flag=$( top -b -n 1 | grep algorithm.exe | wc -l )
    if [ $flag -eq 0 ]
    then
        break
    fi
    sleep 0.1
done