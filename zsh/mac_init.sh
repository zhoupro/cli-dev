#!/bin/bash
which brew
if [ $? -gt 0 ];then
    /usr/bin/ruby -e \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew cask list | grep hyper 
if [ $? -gt 0 ];then
    brew cask install hyper
fi
cp ./hyper.js ~/.hyper.js
[ ! -d ~/.oh-my-zsh ] && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

