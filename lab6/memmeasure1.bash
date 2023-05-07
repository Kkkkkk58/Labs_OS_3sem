#!/bin/bash

for (( j = 1; j != 21; ++j ))
do
    for (( i = 0; i != 10; ++i ));
    do
        for (( k = 0; k != j; ++k ))
        do
            cp numbersDir/numbers numbersDir/numbers$k
        done

        ( time ./memlauncher1.bash $j ) >> report6_$j.log 2>&1
    done
done