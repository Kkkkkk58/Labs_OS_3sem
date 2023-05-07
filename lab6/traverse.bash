#!/bin/bash

for (( i = 1; i != 21; ++i ))
do
    echo $i
    grep real report8_$i.log | awk '{print $2}' | sed 's/s//g' | sed 's/m/  /g' | awk ' { print $1 * 60 + $2 }' | sed 's/\./,/g'
done