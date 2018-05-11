#!/bin/bash -
#===============================================================================
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018/03/24 18时08分31秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

apt-get install zsh -y
[ ! -d ~/.oh-my-zsh ] && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
