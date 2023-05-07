#!/bin/bash

trash_dir="$HOME/.trash"

change_filename_if_needed() {
    cur_name="$2"
    while true;
    do
        if [ ! -f "$1/$cur_name" ];
        then
            break
        else 
            read -r -p "File with provided name already exists in given directory. Enter the new name for the file: " input
            cur_name=$input
        fi
    done
}

recover_file() {
    full_name=$(echo "$1" | awk -F':' '{print $1}')
    trash_number=$(echo "$1" | awk -F':' '{print $2}')

    if [ ! -f "$trash_dir/$trash_number" ];
    then
        echo "Hard link doesn't exist anymore"
        exit 3
    fi

    dirname=$(dirname "$full_name")
    file_name=$(basename "$full_name")
    
    if [ ! -d "$dirname" ];
    then 
        echo "Directory was already deleted. File will be saved to home directory"
        (( dirname = "$HOME" ))
    fi

    ln "$trash_dir/$trash_number" "$dirname/$file_name" || {
        change_filename_if_needed "$dirname" "$file_name"
        file_name="$cur_name"
        ln "$trash_dir/$trash_number" "$dirname/$file_name"
    }

    rm "$trash_dir/$trash_number" 
}

if [ $# -ne 1 ];
then 
    echo "Invalid argument number"
    exit 1
fi

exec 3< <(grep "$1" "$HOME/.trash.log")

while read -r -u 3 line
do
    file_name=$(echo "$line" | awk -F':' '{print $1}')
    read -r -p "Do you want to recover file $file_name? Y/N " input
    if [[ "${input,,}" = "y" ]];
    then
        recover_file "$line"
        break
    fi
done