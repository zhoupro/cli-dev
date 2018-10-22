#!/bin/bash -
set -o nounset                                  # Treat unset variables as an error
#读取参数
# install neovim
! which nvim >/dev/null &&\
    if [ ! -f v0.3.1.tar.gz ];then
        wget https://github.com/neovim/neovim/archive/v0.3.1.tar.gz
        tar xzvf v0.3.1.tar.gz && cd neovim-0.3.1 
        pxy make CMAKE_BUILD_TYPE=Release && make install 
        cd .. && rm -rf neovim-0.3.1  v0.3.1.tar.gz
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
if [ ! -f ~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/ycm_core.so ] ; then
    bash ~/.config/nvim/add_swap.sh
    python2  ~/.local/share/nvim/plugged/YouCompleteMe/install.py --clang-completer
    bash ~/.config/nvim/del_swap.sh
    rm -rf  ~/.local/share/nvim/plugged/YouCompleteMe/third_party/ycmd/clang_archives
    rm -rf  ~/.local/share/nvim/plugged/YouCompleteMe/.git
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
fi

pxy go get -u github.com/labstack/echo/...
! ( grep -F "color onedark" ~/.config/nvim/init.vim ) && \
    echo "color onedark" >> ~/.config/nvim/init.vim && \
    echo "highlight Normal ctermbg=None" >> ~/.config/nvim/init.vim

! ( grep -F "cus_ini_vim" ~/.config/nvim/init.vim ) && \
    cat ./cfg.ini >> ~/.config/nvim/init.vim
! ( grep -F "cus_ini_env" ~/.env ) && \
    cat ./env.ini >> ~/.env
[ ! -f /usr/local/bin/genUrl ] &&\
    cp ./genUrl.sh /usr/local/bin/genUrl && chmod u+x /usr/local/bin/genUrl
rm -rf  ~/.gdbinit  && cp ./gdbinit ~/.gdbinit
