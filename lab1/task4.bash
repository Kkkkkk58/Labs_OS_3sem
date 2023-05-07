#!/bin/bash

if [[ $PWD = "$HOME" ]]
then 
    echo "$HOME"
    exit 0
else 
    echo "Script is not running from home directory"
    exit 1
fi