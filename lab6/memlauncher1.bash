#!/bin/bash

[ $# -ne 1 ] && echo "Invalid input" && exit 1

for (( i = 0; i != $1; ++i ));
do
    ./memory.bash numbersDir/numbers$i
done