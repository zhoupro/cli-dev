#!/bin/bash
which brew
if [ $? -gt 0 ];then
    /usr/bin/ruby -e \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
which tmux
if [ $? -gt 0 ];then
    brew install tmux
fi

rm -f ~/.tmux.conf
cp ./tmux.conf  ~/.tmux.conf
