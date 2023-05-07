#!/bin/bash

backup_dir=$(ls -dt "$HOME"/* | grep -E "$HOME/Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | sort -n | tail -n 1)
if [ -z "$backup_dir" ];
then 
    echo "Previous backup not found"
    exit 1
fi

if [ ! -d "$HOME/restore" ];
then mkdir "$HOME/restore"
fi

for file in $(find "$backup_dir" -type f | grep -Ev '\.[0-9]{4}-[0-9]{2}-[0-9]{2}');
do
    relative_filename=${file//$backup_dir/}
    dir="$(dirname "$relative_filename")"
    [ -d "$HOME/restore/$dir" ] || mkdir -p "$HOME/restore/$dir"
    cp "$file" "$HOME/restore/$dir"
done