#!/bin/bash

for ppid in $(ps -Ao state=,ppid= | tail -n +2 | awk '$1 == "Z" {print $2}')
do
    kill "$ppid"
done