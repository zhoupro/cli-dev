#!/bin/bash
if [ ! -f /usr/local/bin/pxy ];then
    cp tools/pxy/pxy.sh /usr/local/bin/pxy
    sudo chmod 777 /usr/local/bin/pxy
fi


