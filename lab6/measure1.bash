#!/bin/bash

for (( j = 1; j != 21; ++j ))
do
    for (( i = 0; i != 10; ++i ));
    do
        ( time ./launcher1.bash $j ) >> report5_$j.log 2>&1
    done
done