#!/bin/bash
if [ "$(uname)" == "Darwin" ];then
    nc -c localhost 8377
else
    if netcat -z localhost 8377 2>/dev/null;then
        nc -q 1 localhost 8377
    elif netcat -z host.docker.internal 8377 2>/dev/null;then
        nc -q 1 host.docker.internal 8377
    else
        echo "no yy server"
    fi
fi
