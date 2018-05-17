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
source vim_build.sh
apt-get install -y --no-install-recommends autoconf automake wget curl cmake

#-------------------------------------------------------------------------------
# install ctag for tagbar and phpcompelete
#-------------------------------------------------------------------------------
which ctags
if (( $? > 0 )) ;then
    wget https://github.com/b4n/ctags/archive/better-php-parser.zip
    unzip better-php-parser.zip
    cd ctags-better-php-parser
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
cp ./vimrc ~/.vimrc
set shell=/bin/bash
/usr/local/bin/vim   +PluginInstall +qall
grep "colorschem" ~/.vimrc
if (($? > 0 ))
then
    echo "colorscheme solarized" >> ~/.vimrc
fi

if [ ! -d ~/.vim/bundle/YouCompleteMe ] ; then
    echo "You should do :PluginInstall first"
    exit 1;
fi


#-------------------------------------------------------------------------------
# compile ycm_core
#-------------------------------------------------------------------------------
#系统名称
com_codename=$(cat /etc/lsb-release 2>/dev/null|awk -F "=" ' $1 == "DISTRIB_ID" {print $2}'|tr '[A-Z]' '[a-z]')

if [ ! -f ~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ] ; then
    mkdir ycm_build
    cd ycm_build

    if [ "$com_codename"x = "deepin"x ] ; then
        wget http://releases.llvm.org/5.0.0/clang+llvm-5.0.0-x86_64-linux-gnu-debian8.tar.xz
        tar xJvf clang+llvm-5.0.0-x86_64-linux-gnu-debian8.tar.xz
        cmake -G "Unix Makefiles"  -DPATH_TO_LLVM_ROOT=./clang+llvm-5.0.0-x86_64-linux-gnu-debian8    . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
    elif [ "$com_codename"x = "ubuntu"x ] ; then
        wget http://releases.llvm.org/5.0.0/clang+llvm-5.0.0-linux-x86_64-ubuntu16.04.tar.xz
        tar xJvf clang+llvm-5.0.0-linux-x86_64-ubuntu16.04.tar.xz
        cmake -G "Unix Makefiles"  -DPATH_TO_LLVM_ROOT=./clang+llvm-5.0.0-linux-x86_64-ubuntu16.04    . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
    fi

    cmake --build . --target ycm_core --config Release
    cd ..
    rm -rf ycm_build
fi

#-------------------------------------------------------------------------------
# get the ycm conf
#-------------------------------------------------------------------------------


if [ ! -f ~/.vim/ycmconf/ycm.c.py ] ; then

    wget https://raw.githubusercontent.com/zhouzheng12/newycm_extra_conf.py/master/ycm.c.py 
    mkdir -p ~/.vim/ycmconf
    cp ycm.c.py ~/.vim/ycmconf/ycm.c.py
    rm -f ycm.c.py
fi
