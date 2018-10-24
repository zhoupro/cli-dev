#!/bin/bash
which tmux
if [ $? -gt 0 ];then
   apt-get install tmux -y 
fi

rm -f ~/.tmux.conf ~/.tmux.conf.local
cp ./tmux.conf  ~/.tmux.conf
cp ./tmux.conf.local  ~/.tmux.conf.local
echo 'alias tmux="tmux -2"' >> "$HOME/.env"
echo 'export TERM=xterm-256color' >> "$HOME/.env"
