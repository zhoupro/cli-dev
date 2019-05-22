#!/bin/bash
if [ ! -f /usr/local/bin/vim ];then
    if [ ! -f nvim.appimage ];then
        wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    fi
        sudo chmod u+x nvim.appimage && sudo ./nvim.appimage --appimage-extract
    mkdir -p ~/opt/soft
        sudo mv squashfs-root ~/opt/soft/nvim
    sudo ln -s  ~/opt/soft/nvim/usr/bin/nvim /usr/local/bin/vim
    rm -rf nvim.appimage
fi
sudo pip3 install neovim --upgrade
sudo pip2 install neovim --upgrade
pip3 install requests beautifulsoup4
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

