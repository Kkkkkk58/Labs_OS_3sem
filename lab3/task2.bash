#!/bin/bash

echo "./task1.bash" | at now +2 minutes

tail -n 0 -f "$HOME/report"