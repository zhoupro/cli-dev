#!/bin/bash -
#===============================================================================
#
#          FILE: init.sh
#
#         USAGE: ./init.sh
#
#   DESCRIPTION: After using Vbundle :PluginInstall, install some plugins and make configure.
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Pro Zhou (), zhoushengzheng@gmail.com
#  ORGANIZATION: 
#       CREATED: 2017年12月04日 14时55分53秒
#      REVISION:  1.0.0
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

#-------------------------------------------------------------------------------
# install ctag for tagbar
#-------------------------------------------------------------------------------
sudo apt-get install exuberant-ctags

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
vim   +PluginInstall +qall


if [ ! -d ~/.vim/bundle/YouCompleteMe ] ; then
    echo "You should do :PluginInstall first"
    exit 1;
fi


#-------------------------------------------------------------------------------
# compile ycm_core
#-------------------------------------------------------------------------------

if [ ! -f ~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ] ; then
    cd ~
    mkdir ycm_build
    cd ycm_build
    wget http://releases.llvm.org/5.0.0/clang+llvm-5.0.0-x86_64-linux-gnu-debian8.tar.xz
    tar xJvf clang+llvm-5.0.0-x86_64-linux-gnu-debian8.tar.xz
    cmake -G "Unix Makefiles"  -DPATH_TO_LLVM_ROOT=./clang+llvm-5.0.0-x86_64-linux-gnu-debian8    . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
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
fi

