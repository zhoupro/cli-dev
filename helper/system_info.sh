#!/bin/bash -
#===============================================================================
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018/03/11 17时48分12秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

if [ "$(uname)" == "Darwin" ]; then
    sys_os="mac"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    sys_os="linux"
fi
