#!/bin/bash

user_name=$(whoami)
processes=$(ps -U "$user_name" -o pid=,command= | awk '{print $1":"$2}')
echo "$processes" | wc -l > task1.out
echo "$processes" >> task1.out