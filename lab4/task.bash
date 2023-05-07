#!/bin/bash

num_pattern="^[0-9]+$"

restore_from_backup() {
    # $1 = backup
    # $2 = file
    relative_filename=${2//"$HOME/source/"/}
    if [ -f "$1/$relative_filename" ];
    then
        dir="$(dirname "$relative_filename")"
        [ -d "$HOME/restore/$dir" ] || mkdir -p "$HOME/restore/$dir"
        cp "$2" "$HOME/restore/$dir"
    fi
}

restore_files() {
    backup_dirs=$(ls -dt "$HOME"/* | grep -E "$HOME/Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | sort -n -r)
    echo "$backup_dirs" > backuplist.tmp
    awk '{print NR". "$0}' < backuplist.tmp
    lines=$(wc -l < backuplist.tmp | cut -d " " -f 1)
    read -r -p "Enter backup number to restore: " line_number
    if [[ (! $line_number =~ $num_pattern) || $line_number -gt $lines ]];
    then echo "Invalid backup number. Try again"
    fi

    backup_dir=$(tail -n+"$line_number" backuplist.tmp | head -n 1)

    for file in $(find "$HOME/source" -type f)
    do
        restore_from_backup "$backup_dir" "$file"
    done

    IFS=$'\n' read -d '' -r -a backups < backuplist.tmp
    for i in $(seq "$line_number" "$lines");
    do
        for file in $(find "$HOME/source" -type f)
        do
            relative_filename=${file//"$HOME/source/"/}
            [ ! -f "$HOME/restore/$relative_filename" ] && restore_from_backup "${backups[i - 1]}" "$file"
        done
    done

    rm backuplist.tmp
}

menu="MENU
r) restore files
h) show menu
q) quit"

echo "$menu"

while true;
do
    read -r input
    case $input in
    r) restore_files ;;
    h) echo "$menu" ;;
    q) echo "Shutting down..."; break ;;
    *) echo "Invalid option" ;;
    esac
done