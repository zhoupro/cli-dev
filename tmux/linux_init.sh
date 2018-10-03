#!/bin/bash
which tmux
if [ $? -gt 0 ];then
   apt install tmux -y 
fi

rm -f ~/.tmux.conf
cp ./tmux.conf  ~/.tmux.conf
echo 'alias tmux="tmux -2"' >> "$HOME/.env"
echo 'export TERM=xterm-256color' >> "$HOME/.env"
