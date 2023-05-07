#!/bin/bash

file=$1

if ! [ -e "$file" ]
then
    echo "$0: $file does not exist" >&2
    exit 1                 
fi

size=$( wc -l $file | awk '{print $1}' )

i=0
while [ $i -lt $size ] && read -r line;
do
    number=$(echo "$line" | tr -dc '0-9')
    (( res = $number * 2 ))
    echo "$res" >> "$file"
    (( ++i ))
done < "$file"