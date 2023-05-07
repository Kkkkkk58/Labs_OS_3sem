#!/bin/bash
> report2.log

arr=()
size=0
while true;
do
    arr+=(1 2 3 4 5 6 7 8 9 10)
    (( size += 10 ))
    if [[ $(( $size % 100000 )) = 0 ]];
    then echo "$size" >> report2.log
    fi
done