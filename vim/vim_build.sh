#!/bin/bash
which vim
vim_exist=$?
vim --version | grep -e "python3"
vim_python=$?

if [ x"$vim_exist" == "x1" ]  || [ x"$vim_python" == "x1" ] ;then
	 apt remove -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox*
	 apt-get install -y build-essential libncurses5-dev git
	 apt-get install -y \
	    python-dev \
	    python3-dev \
	    ruby-dev \
	    liblua5.2-dev \
	    libperl-dev \
	    libtcl8.6 \
	    libgnomeui-dev \
	    libx11-dev \
	    libxt-dev \
	    libxpm-dev

	git clone https://github.com/vim/vim.git
	cd vim
    	make clean
	 git clean -fdx

	./configure \
	    --prefix=/usr/local/ \
	    --with-features=huge \
	    --enable-multibyte \
	    --enable-cscope=yes \
	    --enable-perlinterp=yes \
	    --enable-rubyinterp=yes \
	    --with-ruby-command=/usr/bin/ruby \
	    --enable-luainterp=yes \
	    --enable-python3interp=yes \
	    --enable-tclinterp=yes \
	    --enable-xim \
	    --enable-fontset \
	    --with-x \
    	make &&  make install
    	 cd ..

fi

