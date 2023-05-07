#!/bin/bash

[ $# -ne 1 ] && echo "Invalid input" && exit 1

for (( i = 0; i != $1; ++i ));
do
    ./memory.bash numbersDir/numbers$i &
done

while true
do
    flag=$( top -b -n 1 | grep memory.bash | wc -l )
    if [ $flag -eq 0 ]
    then
        break
    fi
    sleep 0.1
done