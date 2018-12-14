#!/bin/bash
if [ ! -f /usr/local/bin/vim ];then
	if [ ! -f nvim-macos.tar.gz ];then
	    wget https://github.com/neovim/neovim/releases/download/v0.3.1/nvim-macos.tar.gz
	fi
	rm -rf ~/opt/soft/nvim-osx64
	tar xzvf nvim-macos.tar.gz
	rm -rf nvim-macos.tar.gz
	mkdir -p ~/opt/soft
	mv nvim-osx64 ~/opt/soft
	ln -s  ~/opt/soft/nvim-osx64/bin/nvim /usr/local/bin/vim
fi
pip3 install neovim --upgrade
pip2 install neovim --upgrade

#-------------------------------------------------------------------------------
# install vim-plug
#-------------------------------------------------------------------------------
if  [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ] ; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
rm -f ~/.config/nvim/mac_init.vim
mkdir -p ~/.config/nvim
cp tools/neovim/mac_init.vim ~/.config/nvim/init.vim
vim +'PlugInstall --sync' +qall
