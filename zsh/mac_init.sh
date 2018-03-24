#!/bin/bash -
#===============================================================================
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2018/03/24 18时08分31秒
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
[ ! -f "Solarized Dark.itermcolors" ] && wget "https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/Solarized%20Dark.itermcolors"


if [ ! -f ~/.dir_colors ];then
    brew install xz coreutils
    gdircolors --print-database > ~/.dir_colors
    cat  ./bash_profile >> ~/.bash_profile
fi

[ ! -d ~/.oh-my-zsh ] && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
