#!/bin/bash

! which tmux &&\
   apt-get install tmux -y

[ -f ~/.tmux.conf ] || pxy git clone https://github.com/gpakosz/.tmux.git ~/.tmux && \
ln -s -f ~/.tmux/.tmux.conf ~/.tmux.conf && \
cp ~/.tmux/.tmux.conf.local ~/.tmux.conf.local
