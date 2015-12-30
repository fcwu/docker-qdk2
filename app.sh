#!/bin/bash

set -e

if [ x"${timezone}" != "x" ]; then
    sudo sh -c "echo ${timezone} > /etc/timezone"
    sudo dpkg-reconfigure -f noninteractive tzdata
fi
echo $*
if [ "$#" -ge 1 ]; then
    p=$1
    shift 
    exec $p "$@"
fi
exec bash "$@"
