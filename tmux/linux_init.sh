#!/bin/bash
which tmux
if [ $? -gt 0 ];then
   sudo apt install tmux -y 
fi

rm -f ~/.tmux.conf
cp ./tmux.conf  ~/.tmux.conf
