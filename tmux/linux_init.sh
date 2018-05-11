#!/bin/bash
which tmux
if [ $? -gt 0 ];then
   apt install tmux -y 
fi

rm -f ~/.tmux.conf
cp ./tmux.conf  ~/.tmux.conf
