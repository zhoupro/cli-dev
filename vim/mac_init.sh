#!/bin/bash
which brew
if [ $? -gt 0 ];then
    /usr/bin/ruby -e \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew cask list | grep iterm
if [ $? -gt 0 ];then
    brew cask install iterm2
fi

# install pre app
pre_app=(
python3
wget 
cmake
automake
cscope
)
for i in ${pre_app[@]}
do
    which $i
    if [ $? -gt 0 ];then
        brew install $i
    fi
done

vim --version | grep -e "+python"
if [ $? -gt 0 ];then
    brew install vim --with-cscope --with-lua -with-python3 --override-system-vim
fi
#-------------------------------------------------------------------------------
# install Vundle
#-------------------------------------------------------------------------------
if  [ ! -d ~/.vim/bundle/Vundle.vim ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

#读取参数
#-------------------------------------------------------------------------------
# copy vimrc to home dir, and install from command line
#-------------------------------------------------------------------------------
rm -f ~/.vimrc
#common config
cp ./vimrc ~/.vimrc
export shell=/bin/bash

source language/host_mac.sh
host_pre
host_vimrc
vim   +PluginInstall +qall
host_post


grep "colorschem" ~/.vimrc
if (($? > 0 ))
then
    sed -i ""  '/set background=dark/a\
        colorscheme solarized'  ~/.vimrc
fi                               
                                     
