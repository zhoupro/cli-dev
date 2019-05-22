#!/bin/bash
if [ ! -f /usr/local/bin/vim ];then
    if [ ! -f nvim-macos.tar.gz ];then
        wget https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz
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
pip3 install requests beautifulsoup4
#-------------------------------------------------------------------------------
# install vim-plug
#-------------------------------------------------------------------------------
if  [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ] ; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
rm -f ~/.config/nvim/base_init.vim
mkdir -p ~/.config/nvim
cp tools/neovim/base_init.vim ~/.config/nvim/init.vim
vim +'PlugInstall --sync' +qall
# copy
if nmap localhost -p 8377 | grep open 2>/dev/null;then
    sed -in 's#NCHOST#localhost#g' ~/.config/nvim/init.vim
else
    sed -in 's#NCHOST#host.docker.internal#g' ~/.config/nvim/init.vim
fi

if [ "$sys_os" == "ubuntu" ];then
    sed -in 's#NCCOMMAND#nc -q 1#g'  ~/.config/nvim/init.vim
else
    sed -in 's#NCCOMMAND#nc -c#g' ~/.config/nvim/init.vim
fi
