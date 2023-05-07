#!/bin/bash

trash_dir="$HOME/.trash"

get_last_trash_number() {
    find "$trash_dir" -maxdepth 1 -type f -printf "%f" | sort -n -r | head -n1
}

if [ $# -ne 1 ];
then 
    echo "Invalid argument number"
    exit 1
fi

if [ ! -f "$1" ];
then 
    echo "File was not found"
    exit 2
fi

cur_name=1
if [ -d "$trash_dir" ];
then 
    (( cur_name = $(get_last_trash_number) + 1 ))
else
    mkdir "$trash_dir"
fi

ln "$1" "$trash_dir/$cur_name"
rm "$1"

echo "$PWD/$1:$cur_name" >> "$HOME/.trash.log"
