#!/bin/bash -
#===============================================================================
#
#          FILE: pxy.sh
#
#         USAGE: ./pxy.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018年01月25日 01时44分04秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
#!/usr/bin/env bash

export http_proxy=http://localhost:8087
export https_proxy=http://localhost:8087



starttime=`date +'%Y-%m-%d %H:%M:%S'`
#执行程序
$*

endtime=`date +'%Y-%m-%d %H:%M:%S'`
start_seconds=$(date --date="$starttime" +%s);
end_seconds=$(date --date="$endtime" +%s);
echo "use time： "$((end_seconds-start_seconds))"s"
unset http_proxy
unset https_proxy

