#!/bin/bash

menu="Available options:
1) Launch Nano
2) Launch Vi
3) Run Links
4) Exit menu

Type -h to call this menu again
"

echo "$menu"

while read -r choice
do
    case $choice in
        1) nano ;;
        2) vi ;;
        3) links ;;
        4) exit 0 ;;
        -h) echo "$menu" ;;
        *) echo "Invalid option"
           exit 255 ;;
    esac
done
