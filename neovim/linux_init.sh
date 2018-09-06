#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error
apt-get install -y --no-install-recommends git unzip wget curl 
#读取参数
# shellcheck disable=SC1091
source lib/readinput.sh
apt install neovim python3-pip
pip3 install neovim --upgrade

function ini_ctags(){
    #-------------------------------------------------------------------------------
    # install ctag for tagbar and phpcompelete
    #-------------------------------------------------------------------------------
    apt-get install -y gcc  autoconf automake make
    if ! command -v  ctags ;then
        wget https://github.com/b4n/ctags/archive/better-php-parser.zip
        unzip better-php-parser.zip
        cd ctags-better-php-parser || exit
        autoreconf -fi
        ./configure
        make
        make install
        cd ..
        rm -rf better-php-parser*
    fi
}
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
fi
rm -f ~/.config/nvim/init.vim
#common config
mkdir -p ~/.config/nvim
cp ./init.vim ~/.config/nvim/init.vim
export shell=/bin/bash
nvim +'PlugInstall --sync' +qall
