#!/bin/bash

log_begin="\[[ 0-9.]+\]"

grep -E "${log_begin} \(WW\)" /var/log/anaconda/X.log | sed "s/(WW)/Warning:/" > full.log
grep -E "${log_begin} \(II\)" /var/log/anaconda/X.log | sed "s/(II)/Information:/" >> full.log