#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error
apt-get install -y --no-install-recommends git unzip wget curl python-dev cscope ctags
#读取参数
# shellcheck disable=SC1091
apt install neovim python3-pip
pip3 install neovim --upgrade

#-------------------------------------------------------------------------------
# install vim-plug 
#-------------------------------------------------------------------------------
if  [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ] ; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#-------------------------------------------------------------------------------
# copy init.vim to home dir, and install from command line
#-------------------------------------------------------------------------------
if [ ! -f ~/.vim/c_cnt.sh ] ; then
	cp ./c_cnt.sh  ~/.config/nvim/c_cnt.sh
	cp ./add_swap.sh  ~/.config/nvim/add_swap.sh
	cp ./del_swap.sh  ~/.config/nvim/del_swap.sh
fi
if [ ! -f ~/.config/nvim/ycm.c.py ] ; then
    wget https://raw.githubusercontent.com/zhouzheng12/newycm_extra_conf.py/master/ycm.c.py
    mkdir -p ~/.config/nvim
    cp ycm.c.py ~/.config/nvim/ycm.c.py
    rm -f ycm.c.py
fi
rm -f ~/.config/nvim/init.vim
#common config
mkdir -p ~/.config/nvim
cp ./init.vim ~/.config/nvim/init.vim
export shell=/bin/bash
nvim +'PlugInstall --sync' +qall
bash ~/.config/nvim/add_swap.sh
python2  ~/.local/share/nvim/plugged/YouCompleteMe/install.py --clang-completer
bash ~/.config/nvim/del_swap.sh
