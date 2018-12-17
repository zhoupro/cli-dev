#!/bin/bash -

export http_proxy=http://`/sbin/ip route|awk '/default/ { print $3 }'`:8087
export https_proxy=http://`/sbin/ip route|awk '/default/ { print $3 }'`:8087


starttime=`date +%s`
#执行程序
$*

endtime=`date +%s`
echo "use time： "$((starttime-endtime))"s"
unset http_proxy
unset https_proxy
