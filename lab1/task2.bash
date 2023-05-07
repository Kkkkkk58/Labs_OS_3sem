#!/bin/bash

str_result=""

read -r input
while [[ $input != "q" ]]
do
    str_result="$str_result$input"
    read -r input
done

echo "$str_result"