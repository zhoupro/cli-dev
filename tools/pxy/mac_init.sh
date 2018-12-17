#!/bin/bash
if [ ! -f /usr/local/bin/pxy.sh ];then
    cp tools/pxy/pxy.sh /usr/local/bin/pxy.sh
    sudo chmod 777 /usr/local/bin/pxy.sh
fi


