#!/bin/bash
which vim && return
if [ ! -f nvim-macos.tar.gz ];then
    wget https://github.com/neovim/neovim/releases/download/v0.3.1/nvim-macos.tar.gz
fi
rm -rf ~/opt/soft/nvim-osx64
tar xzvf nvim-macos.tar.gz
rm -rf nvim-macos.tar.gz
mkdir -p ~/opt/soft
mv nvim-osx64 ~/opt/soft
ln -s  ~/opt/soft/nvim-osx64/bin/nvim /usr/local/bin/vim

