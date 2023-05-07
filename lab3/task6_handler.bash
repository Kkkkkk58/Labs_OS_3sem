#!/bin/bash

echo $$ > .pid
a=1
mode='+'
usr1() 
{
    mode='+'
}
usr2() 
{
    mode='*'
}
sigterm() 
{
    echo "Stopped..."
    exit
}

trap 'usr1' USR1
trap 'usr2' USR2
trap 'sigterm' SIGTERM

while true;
do 
    case $mode in
        +) (( a += 2 )) ;;
        \*) (( a *= 2 )) ;;
    esac
    echo $a
    sleep 1
done
