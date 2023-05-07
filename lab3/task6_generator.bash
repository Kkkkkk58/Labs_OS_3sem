#!/bin/bash

./task6_handler.bash &

while true;
do 
    read -r line
    case "$line" in
        +) kill -USR1 "$(cat .pid)" ;;
        \*) kill -USR2 "$(cat .pid)" ;;
        *TERM*) kill -SIGTERM "$(cat .pid)"; break ;;
        *) : ;;
    esac
done