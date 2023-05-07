#!/bin/bash

filename="$(basename "$0")"

for file in "$PWD"/*
do
    if [[ $file == *.bash && $file != "$PWD/$filename" ]]
    then 
        echo "Running script: $file"
        /bin/bash "$file"
    fi
done