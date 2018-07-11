#!/bin/bash
which brew
if [ $? -gt 0 ];then
    /usr/bin/ruby -e \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew cask list | grep iterm
if [ $? -gt 0 ];then
    brew cask install iterm2
fi

# install pre app
pre_app=(
python3
wget 
cmake
automake
cscope
)
for i in ${pre_app[@]}
do
    which $i
    if [ $? -gt 0 ];then
        brew install $i
    fi
done

vim --version | grep -e "+python"
if [ $? -gt 0 ];then
	git clone https://github.com/vim/vim.git
	cd vim
	sudo	make clean
	sudo git clean -fdx

	./configure \
		--prefix=/usr/local/ \
		--with-features=huge \
		--enable-multibyte \
		--enable-cscope=yes \
		--enable-perlinterp=yes \
		--enable-rubyinterp=yes \
		--with-ruby-command=/usr/bin/ruby \
		--enable-luainterp=yes \
		--enable-pythoninterp=yes \
		--enable-python3interp=yes \
		--enable-tclinterp=yes \
		--enable-xim \
		--enable-fontset \
		--with-x \
		--with-compiledby=$USER

	make && sudo make install
	cd ..
fi
function ini_ctags(){
    #-------------------------------------------------------------------------------
    # install ctag for tagbar and phpcompelete
    #-------------------------------------------------------------------------------
	[ -f /usr/local/bin/ctags ]
	if (( $? > 0 )) ;then
		wget https://github.com/b4n/ctags/archive/better-php-parser.zip
		unzip better-php-parser.zip
		cd ctags-better-php-parser
		autoreconf -fi
		./configure
		make
		sudo make install
		cd ..
	fi
}
#-------------------------------------------------------------------------------
# install Vundle
#-------------------------------------------------------------------------------
if  [ ! -d ~/.vim/bundle/Vundle.vim ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

#读取参数
# shellcheck disable=SC1091
source lib/readinput.sh

#-------------------------------------------------------------------------------
# copy vimrc to home dir, and install from command line
#-------------------------------------------------------------------------------
rm -f ~/.vimrc
#common config
cp ./vimrc ~/.vimrc
export shell=/bin/bash

# pre and make vimrc
if ((IFC == 1)) ;then
    ini_ctags
    # shellcheck disable=SC1091
    source language/c_mac.sh
    c_pre
    c_vimrc
fi
if ((IFPHP == 1)) ;then
    ini_ctags
    # shellcheck disable=SC1091
    source language/php_mac.sh
    php_pre
    php_vimrc
fi

if ((IFGOLANG == 1)) ;then
    # shellcheck disable=SC1091
    source language/go_mac.sh
    go_pre
    go_vimrc
fi
if ((IFHOST == 1)) ;then
    # shellcheck disable=SC1091
    source language/host_mac.sh
    host_pre
    host_vimrc
fi


vim   +PluginInstall +qall

# post
if ((IFC == 1)) ;then
    c_post
fi
if ((IFPHP == 1)) ;then
    php_post
fi
if ((IFGOLANG == 1)) ;then
    go_post
fi
if ((IFHOST == 1)) ;then
    host_post
fi


grep "colorschem" ~/.vimrc
if (($? > 0 ))
then
    sed -i ""  '/set background=dark/a\
        colorscheme solarized'  ~/.vimrc
fi                               
                                     
