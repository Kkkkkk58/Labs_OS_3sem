#!/bin/bash

(crontab -l ; echo "5 * * * 6 /bin/bash task1.bash") | crontab -