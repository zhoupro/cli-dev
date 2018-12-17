#!/bin/bash

! which tmux &&\
   apt-get install tmux -y
rm -f ~/.tmux.conf ~/.tmux.conf.local
cp tools/tmux/tmux.conf  ~/.tmux.conf
cp tools/tmux/tmux.conf.local  ~/.tmux.conf.local
echo 'alias tmux="tmux -2"' >> "$HOME/.env"
echo 'export TERM=xterm-256color' >> "$HOME/.env"
