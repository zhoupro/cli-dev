#!/bin/bash
! brew list | grep tmux && brew install tmux
rm -f ~/.tmux.conf ~/.tmux.conf.local
cp tools/tmux/tmux.conf  ~/.tmux.conf
cp tools/tmux/tmux.conf.local  ~/.tmux.conf.local
