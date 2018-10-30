#!/bin/bash
which tmux
if [ $? -gt 0 ];then
    brew install tmux
fi

rm -f ~/.tmux.conf ~/.tmux.conf.local
cp ./tmux.conf  ~/.tmux.conf
cp ./tmux.conf.local  ~/.tmux.conf.local
