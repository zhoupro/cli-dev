#!/bin/bash
if [ "$(uname)" == "Darwin" ]; then
    sys_os="mac"
    sys_version=$(sw_vers | grep ProductVersion | awk  '{print $2}')
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sys_os=$(cat /etc/lsb-release 2>/dev/null|awk -F "=" ' $1 == "DISTRIB_ID" {print $2}'|tr '[A-Z]' '[a-z]')
    sys_version=$(cat /etc/lsb-release 2>/dev/null|awk -F "=" ' $1 == "DISTRIB_RELEASE" {print $2}')
fi
