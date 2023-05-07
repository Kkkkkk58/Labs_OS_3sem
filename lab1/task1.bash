#!/bin/bash

if [[ $# -ne 3 ]]
then 
    echo "Argument number must be exactly 3"
    exit 255
fi

if [[ $1 -gt $2 ]] && [[ $1 -gt $3 ]]
then 
    echo "$1"
elif [[ $2 -gt $3 ]] && [[ $2 -gt $1 ]]
then 
    echo "$2"
else 
    echo "$3"
fi
