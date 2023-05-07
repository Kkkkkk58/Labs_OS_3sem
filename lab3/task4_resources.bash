#!/bin/bash

if [ $# -ne 1 ];
then echo "Resources: pid not provided"
fi

get_cur_load() {
    top -n 1 -b -p "$1" | sed 1,7d | awk '{print $9}'
}

cur_nice=$(top -n 1 -b -p "$1" | sed 1,7d | awk '{print $4}')

do_renice() {
    while true;
    do
        cur_load_percents="$(get_cur_load "$1")"
        if (( $(echo "$cur_load_percents > 10" | bc -l) ));
        then
            (( ++cur_nice ))
            renice -n "$cur_nice" -p "$1"
        else
            break
        fi        
    done
}

while true;
    do
    cur_load_percents="$(get_cur_load "$1")"
    if (( $(echo "$cur_load_percents > 10" | bc -l) ));
    then
        do_renice "$1"
    fi
    sleep 1s
done