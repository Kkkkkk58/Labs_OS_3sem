#!/bin/bash

a=1
mode="+"
(tail -f pipe2) |
while true;
do 
    read -r line
    case "$line" in
    +) mode="+" ;;
    \*) mode="*" ;;
    [0-9]*)
        if [[ $mode = "+" ]]
        then (( a += line ))
        else (( a *= line ))
        fi
        echo "$a";;
    QUIT) echo "Handler: Shutting down";
        exit ;;
    *) echo "Handler: Unknown operation";
        exit 1 ;;
    esac

done