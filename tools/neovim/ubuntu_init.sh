#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error
#读取参数
# install neovim
if [ ! -f /usr/local/bin/vim ];then
	if [ ! -f nvim.appimage ];then
	    wget https://github.com/neovim/neovim/releases/download/v0.3.1/nvim.appimage
	fi
        sudo chmod u+x nvim.appimage && sudo ./nvim.appimage --appimage-extract
	mkdir -p ~/opt/soft
        sudo mv squashfs-root ~/opt/soft/nvim
	sudo ln -s  ~/opt/soft/nvim/usr/bin/nvim /usr/local/bin/vim
	sudo ln -s  ~/opt/soft/nvim/usr/bin/nvim /usr/local/bin/nvim
	rm -rf nvim.appimage
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

#-------------------------------------------------------------------------------
# copy init.vim to home dir, and install from command line
#-------------------------------------------------------------------------------
if [ ! -f ~/.vim/c_cnt.sh ] ; then
    mkdir -p  ~/.config/nvim
	cp tools/neovim/c_cnt.sh  ~/.config/nvim/c_cnt.sh
	cp tools/neovim/add_swap.sh  ~/.config/nvim/add_swap.sh
	cp tools/neovim/del_swap.sh  ~/.config/nvim/del_swap.sh
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
cp tools/neovim/init.vim ~/.config/nvim/init.vim
export shell=/bin/bash
nvim +'PlugInstall --sync' +qall
if [ ! -f ~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/ycm_core.so ] ; then
    bash ~/.config/nvim/add_swap.sh
    pxy python2  ~/.local/share/nvim/plugged/YouCompleteMe/install.py --clang-completer
    bash ~/.config/nvim/del_swap.sh
    rm -rf  ~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/clang_archives
fi

cat > /usr/local/bin/phpxd <<END
#!/bin/zsh
export XDEBUG_CONFIG="idekey=xdebug remote_host=localhost"
php "\$@"
END
chmod u+x  /usr/local/bin/phpxd

! which ctags >/dev/null && \
    git clone https://github.com/universal-ctags/ctags.git &&\
    cd ctags && ./autogen.sh && ./configure && make && make install &&\
    cd .. && rm -rf ctags

    

if which go;then
    pxy nvim +'GoInstallBinaries' +qall
    pxy go get -u github.com/derekparker/delve/cmd/dlv
    pxy go get -u github.com/mdempsky/gocode
    pxy go get -u github.com/labstack/echo/...
fi

! ( grep -F "color onedark" ~/.config/nvim/init.vim ) && \
    echo "color onedark" >> ~/.config/nvim/init.vim && \
    echo "highlight Normal ctermbg=None" >> ~/.config/nvim/init.vim

! ( grep -F "cus_ini_vim" ~/.config/nvim/init.vim ) && \
    cat tools/neovim/cfg.ini >> ~/.config/nvim/init.vim
! ( grep -F "cus_ini_env" ~/.env ) && \
    cat tools/neovim/env.ini >> ~/.env
[ ! -f /usr/local/bin/genUrl ] &&\
    cp tools/neovim/genUrl.sh /usr/local/bin/genUrl && chmod u+x /usr/local/bin/genUrl
[ ! -d /usr/local/vimsplain ] &&\
    git clone https://github.com/pafcu/vimsplain.git  /usr/local/vimsplain
rm -rf  ~/.gdbinit  && cp tools/neovim/gdbinit ~/.gdbinit
