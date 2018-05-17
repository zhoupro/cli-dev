#!/bin/bash
which vim
vim_exist=$?
vim --version | grep -e "python3"
vim_python=$?

if [ x"$vim_exist" == "x1" ]  || [ x"$vim_python" == "x1" ] ;then
	 apt remove -y vim vim-runtime gvim vim-tiny vim-common vim-gui-common vim-nox*
	 apt-get install -y --no-install-recommends build-essential libncurses5-dev git gdb
	 apt-get install -y --no-install-recommends \
	    python3-dev  python-dev 
     rm -rf /var/lib/apt/lists/*

	git clone https://github.com/vim/vim.git
	cd vim
   	make clean
    git clean -fdx
	./configure \
	    --prefix=/usr/local/ \
	    --with-features=huge \
	    --enable-multibyte \
	    --enable-cscope=yes \
	    --enable-python3interp=yes \
	    --enable-fontset \
	    --with-x \
    	make &&  make install
    	cd ..
        rm -rf vim
fi
