#!/bin/bash

man bash | grep -E -o "[[:alpha:]]{4,}" | sort | uniq -c -i | sort -n -r -k 1 | head -n 3 | awk '{print $2}'