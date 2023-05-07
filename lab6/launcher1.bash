#!/bin/bash

[ $# -ne 1 ] && echo "Invalid input" && exit 1

for (( i = 0; i != $1; ++i ));
do
    (( a = -1000 + $i )) 
    (( b = $a + 2000 ))
    result=$( ./algorithm.exe $a $b 0.000001 )
done