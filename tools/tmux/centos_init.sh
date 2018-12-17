#!/bin/bash

if ! which tmux;then
    wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
    tar xzvf libevent-2.0.21-stable.tar.gz
    cd libevent-2.0.21-stable
    ./configure && make
    sudo make install
    cd ..
    git clone  https://github.com/tmux/tmux.git tmux
    cd tmux
    sh autogen.sh
    ./configure && make
    sudo make install
    cd ..
fi

rm -f ~/.tmux.conf ~/.tmux.conf.local
cp tools/tmux/tmux.conf  ~/.tmux.conf
cp tools/tmux/tmux.conf.local  ~/.tmux.conf.local
echo 'alias tmux="tmux -2"' >> "$HOME/.bashrc"
echo 'export TERM=xterm-256color' >> "$HOME/.bashrc"
