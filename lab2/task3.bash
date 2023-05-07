#!/bin/bash

ps -Ao pid=,start_time= --sort=start_time | tail -1