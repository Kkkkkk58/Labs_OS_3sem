#!/bin/bash

grep -I -E -o -r -s -h -w "[a-zA-Z0-9_.-]+@[a-zA-Z0-9_-]+\.[a-zA-Z]+" /etc/* | tr '\n' ', ' > emails.lst