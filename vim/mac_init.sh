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

#-------------------------------------------------------------------------------
# install ctag for tagbar and phpcompelete
#-------------------------------------------------------------------------------
which ctags

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
#-------------------------------------------------------------------------------
# install Vundle
#-------------------------------------------------------------------------------
if  [ ! -d ~/.vim/bundle/Vundle.vim ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi



#-------------------------------------------------------------------------------
# copy vimrc to home dir, and install from command line
#-------------------------------------------------------------------------------
rm -f ~/.vimrc
cp ./vimrc ~/.vimrc
set shell=/bin/bash
vim   +PluginInstall +qall


#-------------------------------------------------------------------------------
# compile ycm_core
#-------------------------------------------------------------------------------

if [ ! -f ~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ] ; then
    cd ~
    mkdir ycm_build
    cd ycm_build
    wget http://releases.llvm.org/5.0.0/clang+llvm-5.0.0-x86_64-apple-darwin.tar.xz
    tar xJvf clang+llvm-5.0.0-x86_64-apple-darwin.tar.xz
    cmake -G "Unix Makefiles"  -DPATH_TO_LLVM_ROOT=./clang+llvm-5.0.0-x86_64-apple-darwin    . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
    cmake --build . --target ycm_core --config Release
    cd ..
    rm -rf ycm_build
fi

#-------------------------------------------------------------------------------
# get the ycm conf
#-------------------------------------------------------------------------------


if [ ! -f ~/.vim/ycmconf/ycm.c.py ] ; then

    wget https://raw.githubusercontent.com/zhouzheng12/newycm_extra_conf.py/master/ycm.c.py
    mkdir -p ~/.vim/ycmconf
    cp ycm.c.py ~/.vim/ycmconf/ycm.c.py
fi



## shell comment change

grep FILE $HOME/.vim/bundle/bash-support/bash-support/templates/comments.templates
if [ $? -eq 0 ]
then
    sed -i '' '20,30d' "$HOME/.vim/bundle/bash-support/bash-support/templates/comments.templates"
fi

