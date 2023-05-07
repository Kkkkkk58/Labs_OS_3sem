#!/bin/bash

report_path="$HOME/report"
test_directory="$HOME/test"
mkdir "$test_directory" && 
{
    echo "catalog test was created successfully" >> "$report_path" 
    touch "$test_directory/$(date +%F_%T)"
}

website="www.net_nikogo.ru"
ping "$website" ||
    echo "$(date +\[%F_%T\]) Page $website is unavailable at the moment" >> "$report_path"