#!/bin/bash -
#===============================================================================
#         USAGE: ./init.sh
#
#        AUTHOR: Pro Zhou (), zhoushengzheng@gmail.com
#  ORGANIZATION: 
#       CREATED: 2017年12月04日 14时55分53秒
#      REVISION:  1.0.0
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

apt-get install -y --no-install-recommends git unzip wget curl 
#读取参数
# shellcheck disable=SC1091
source lib/readinput.sh
apt-get install -y  autoconf automake
if ((IFC == 1)) ;then
    # shellcheck disable=SC1091
    source vim_build.sh
else
    apt-get install -y --no-install-recommends vim
fi 

#-------------------------------------------------------------------------------
# install ctag for tagbar and phpcompelete
#-------------------------------------------------------------------------------
if ! command -v  ctags ;then
    wget https://github.com/b4n/ctags/archive/better-php-parser.zip
    unzip better-php-parser.zip
    cd ctags-better-php-parser || exit
    autoreconf -fi
    ./configure
    make
    make install
    cd ..
    rm -rf better-php-parser*
fi
#-------------------------------------------------------------------------------
# install Vundle
#-------------------------------------------------------------------------------
if  [ ! -d ~/.vim/bundle/Vundle.vim ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

#-------------------------------------------------------------------------------
# copy vimrc to home dir, and install from command line
#-------------------------------------------------------------------------------
rm -f ~/.vimrc
#common config
cp ./vimrc ~/.vimrc
export shell=/bin/bash

# pre and make vimrc
if ((IFC == 1)) ;then
    # shellcheck disable=SC1091
    source language/c.sh
    c_pre
    c_vimrc
fi 
if ((IFPHP == 1)) ;then
    # shellcheck disable=SC1091
    source language/php.sh
    php_pre
    php_vimrc
fi 
if ((IFGOLANG == 1)) ;then
    # shellcheck disable=SC1091
    source language/go.sh
    go_pre
    go_vimrc
fi 


vim   +PluginInstall +qall

# post
if ((IFC == 1)) ;then
    c_post
fi 
if ((IFPHP == 1)) ;then
    php_post
fi 
if ((IFGOLANG == 1)) ;then
    go_post
fi 


# common post
if ! grep "colorschem" ~/.vimrc
then
    sed -i "/set background=dark/a\
        colorscheme solarized"  ~/.vimrc
fi

