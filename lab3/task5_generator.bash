#!/bin/bash

./task5_handler.bash &

while true;
do 
    read -r line
    echo "$line" > pipe2
    if [[ $line = "+" || $line = '*' || $line =~ [0-9]+ || $line = "QUIT" ]]
    then
        if [[ $line = "QUIT" ]]
        then exit
        fi
    else 
        echo "Generator: Invalid option"
        exit 1;
    fi
done