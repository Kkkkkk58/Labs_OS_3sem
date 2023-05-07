#!/bin/bash

arr=()
size=0
while true;
do
    arr+=(1 2 3 4 5 6 7 8 9 10)
    (( size += 10 ))
    if [[ $size -ge $1 ]];
    then break
    fi
done

echo "Successful"