    #!/bin/bash

    backup_dir=$(ls -dt "$HOME"/* | grep -E "$HOME/Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | sort -n | tail -n 1)
    backup_date=$(echo "$backup_dir" | grep -Eo "[0-9]{4}-[0-9]{2}-[0-9]{2}")
    cur_date=$(date '+%Y-%m-%d')
    date_diff=$(( ($(date -d "$cur_date" +%s) - $(date -d "$backup_date" +%s)) / (60*60*24) ))
    backup_report="$HOME/backup-report"
    full_date=$(date)

    if [[ -z $backup_dir || $date_diff -gt 7 ]];
    then
        backup_dir="$HOME/Backup-$cur_date"
        mkdir "$backup_dir"
        filenames=$(find "$HOME/source/" -type f -printf "%p ")

        for filename in $filenames;
        do
            relative_filename=${filename//"$HOME/source/"/}
            dir="$(dirname "$relative_filename")"
            mkdir -p "$backup_dir/$dir"
            cp "$filename" "$backup_dir/$dir"
        done
        
        echo "[$full_date] [CREATE] $backup_dir" >> "$backup_report"
        echo "$filenames" | tr ' ' '\n' >> "$backup_report" 
    else
        changed_files="CHANGED:"
        added_files="ADDED:"
        while read -r path;
        do
            filename=${path//"$HOME/source/"/}
            if [ -f "$backup_dir/$filename" ];
            then
                prev_size=$(wc -c < "$backup_dir/$filename")
                cur_size=$(wc -c < "$path")
                if [ "$prev_size" -ne "$cur_size" ];
                then 
                    new_name="$filename.$cur_date"
                    mv "$backup_dir/$filename" "$backup_dir/$new_name"
                    changed_files="$changed_files $path"
                fi
            else
                mkdir -p "$(dirname "$backup_dir/$filename")" 2>/dev/null
                added_files="$added_files $path"
            fi
            
            cp "$path" "$backup_dir/$filename"
        done < <(find "$HOME/source/" -type f)
        { 
        echo "[$full_date] [UPDATE] $backup_dir";
        echo "$added_files" | tr " " "\n";
        echo "$changed_files" | tr " " "\n";
        } >> "$backup_report"
    fi
