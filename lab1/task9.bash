#!/bin/bash

wc -l /var/log/*.log 2>/dev/null | awk '$2 == "total" {print $1}'