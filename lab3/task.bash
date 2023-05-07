#!/bin/bash

menu="MENU:
s) show existing items
a) add cron
e) edit cron
d) delete cron
h) show menu
q) QUIT"
num_pattern="^[0-9]+$"

echo "$menu"

while true;
do
    read -r input
    case "$input" in
    s) crontab -l | awk '{print NR". "$0}' ;;
    a) 
        read -r -p "Enter cron: " user_cron
        (crontab -l ; echo "$user_cron") | crontab - && echo "Cron successfully added" ;;
    e) 
        lines=$(crontab -l | wc -l | cut -d " " -f 1)
        read -r -p "Enter line number to edit: " line_number
        if [[ (! $line_number =~ $num_pattern) || $line_number -gt $lines ]];
        then echo "Invalid line number. Try again"
        fi
        crontab -l > cron.tmp
        read -r -p "Enter new cron: " user_cron
        sed -i "${line_number}s@.*@${user_cron}@" "cron.tmp"
        crontab cron.tmp && echo "Cron successfully changed"
        rm cron.tmp
        ;;
    d)         
        lines=$(crontab -l | wc -l | cut -d " " -f 1)
        read -r -p "Enter line number to delete: " line_number
        if [[ (! $line_number =~ $num_pattern) || $line_number -gt $lines ]];
        then echo "Invalid line number. Try again"
        fi
        crontab -l > cron.tmp
        sed -i "$line_number"d "cron.tmp"
        crontab cron.tmp && echo "Cron successfully deleted"
        rm cron.tmp
        ;;
    h) echo "$menu" ;;
    q) echo "Shutting down..."; break ;;
    *) echo "Invalid option"; echo "$menu" ;;
    esac
done