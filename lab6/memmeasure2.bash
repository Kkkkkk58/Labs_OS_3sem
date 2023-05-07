#!/bin/bash

for (( j = 20; j != 21; ++j ))
do
    echo "Running $j"
    for (( i = 0; i != 10; ++i ));
    do
        for (( k = 0; k != j; ++k ))
        do
            cp numbersDir/numbers numbersDir/numbers$k
        done
        
        ( time ./memlauncher2.bash $j )
    done
done