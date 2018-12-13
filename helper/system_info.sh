#!/bin/bash
if [ "$(uname)" == "Darwin" ]; then
    sys_os="mac"
    sys_version=$(sw_vers | grep ProductVersion | awk  '{print $2}')
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sys_os=$(cat /etc/os-release | grep ^ID= | awk -F '=' '{print $2}' |sed -e 's/"//g')
    sys_version=$(cat /etc/os-release | grep ^VERSION_ID= | awk -F '=' '{print $2}' |sed -e 's/"//g')
fi
