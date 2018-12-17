#!/bin/bash
if [ ! -f /usr/local/bin/vim ];then
	if [ ! -f nvim.appimage ];then
	    wget https://github.com/neovim/neovim/releases/download/v0.3.1/nvim.appimage
	fi
        sudo chmod u+x nvim.appimage && sudo ./nvim.appimage --appimage-extract
	mkdir -p ~/opt/soft
        sudo mv squashfs-root ~/opt/soft/nvim
	sudo ln -s  ~/opt/soft/nvim/usr/bin/nvim /usr/local/bin/vim
	rm -rf nvim.appimage
fi
sudo pip3 install neovim --upgrade
sudo pip2 install neovim --upgrade
#-------------------------------------------------------------------------------
# install vim-plug
#-------------------------------------------------------------------------------
if  [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ] ; then
    sudo curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
sudo rm -f ~/.config/nvim/base_init.vim
sudo mkdir -p ~/.config/nvim
sudo cp tools/neovim/base_init.vim ~/.config/nvim/init.vim
vim +'PlugInstall --sync' +qall
