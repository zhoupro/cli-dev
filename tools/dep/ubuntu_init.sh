#!/bin/bash

apt-get install -y gawk curl  zsh \
    git unzip wget    python3-pip  lsof sudo \
    autojump  nmap iproute2 net-tools  axel netcat ripgrep

    #clibtool-bin gettext make automake m4 autoconf libtool build-essential  pkg-config  wamerican \


apt-get remove -y neovim exuberant-ctags



if [ "Y$OPT_MAN" == "Yyes" ];then
    [ -f  /etc/dpkg/dpkg.cfg.d/excludes ] && rm -rf /etc/dpkg/dpkg.cfg.d/excludes
    apt-get install -y \
    cppman man manpages manpages-dev manpages-posix manpages-posix-dev
fi

if [ "Y$OPT_CPP" == "Yyes" ];then
    apt-get install -y \
    valgrind clangd cscope gdb
fi


if [ "Y$OPT_BASH" == "Yyes" ];then
    apt-get install -y \
    shellcheck
    if ! which bash-language-server > /dev/null; then
       npm i -g bash-language-server --unsafe-perm
    fi
fi

if [ "Y$OPT_PHP" == "Yyes" ];then
    apt install php -y
    npm i -g intelephense
fi

if [ "Y$OPT_PYTHON" == "Yyes" ];then
    pip3 install jedi
fi

if [ "Y$OPT_VIM" == "Yyes" ];then

    apt install -y npm
    npm install -g yarn
    yarn global add vim-language-server
fi

if [ "Y$OPT_GO" == "Yyes" ];then

    if [ ! -f /usr/local/bin/gopkgs  ];then
	wget https://github.com/haya14busa/gopkgs/releases/download/v1.0.0/gopkgs_linux_amd64 && mv gopkgs_linux_amd64 /usr/local/bin/gopkgs && chmod u+x /usr/local/bin/gopkgs
    fi

fi

if [ "Y$OPT_LUA" == "Yyes" ];then
    apt install -y lua5.3-dev luarocks lua5.3
    luarocks install --server=http://luarocks.org/dev lua-lsp
fi

if [ "Y$OPT_FE" == "Yyes" ];then
    sudo npm install -g typescript typescript-language-server
    sudo npm install -g vscode-css-languageserver-bin
fi

