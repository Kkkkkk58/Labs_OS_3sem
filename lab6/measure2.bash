#!/bin/bash

for (( j = 1; j != 21; ++j ))
do
    echo "Running $j"
    for (( i = 0; i != 10; ++i ));
    do
        ( time ./launcher2.bash $j )
    done
done