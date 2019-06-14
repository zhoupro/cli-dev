#!/bin/bash

apt-get install -y gawk curl  zsh language-pack-zh-hans language-pack-zh-hans-base \
    git unzip wget  python-dev  python3-pip python-pip lsof \
    libtool-bin gettext sudo \
    cmake automake m4 autoconf libtool build-essential  pkg-config  wamerican \
    autojump  nmap iproute2 net-tools sshfs

apt-get remove -y neovim exuberant-ctags

if [ "Y$OPT_MAN" == "Yyes" ];then
    [ -f  /etc/dpkg/dpkg.cfg.d/excludes ] && rm -rf /etc/dpkg/dpkg.cfg.d/excludes
    apt-get install -y \
    cppman man manpages manpages-dev manpages-posix manpages-posix-dev
fi
if [ "Y$OPT_DICT" == "Yyes" ];then
    apt-get install -y sdcv
    if [ ! -d /usr/share/stardict/dict/stardict-oxford-gb-2.4.2 ];then
        mkdir -p /usr/share/stardict/dic/ && \
        wget http://download.huzheng.org/zh_CN/stardict-oxford-gb-2.4.2.tar.bz2 && \
        wget http://download.huzheng.org/zh_CN/stardict-wubi86-2.4.2.tar.bz2 && \
        tar -xjvf stardict-wubi86-2.4.2.tar.bz2  -C /usr/share/stardict/dic && \
        tar -xjvf stardict-oxford-gb-2.4.2.tar.bz2 -C /usr/share/stardict/dic && \
        rm -rf stardict-*
    fi
fi

if [ "Y$OPT_VIM_C" == "Yyes" ];then
    apt-get install -y \
    valgrind clang-format cscope gdb
fi

if [ "Y$OPT_BASH" == "Yyes" ];then
    apt-get install -y \
    npm shellcheck
    if ! which bash-language-server > /dev/null; then
        npm i -g bash-language-server
    fi
fi
if [ "Y$OPT_PHP" == "Yyes" ];then
    apt-get install -y npm
    npm i -g intelephense
fi

pip install python-language-server

if [ "Y$OPT_LUA" == "Yyes" ];then
    apt install  lua5.3-dev luarocks lua5.3
    luarocks install --server=http://luarocks.org/dev lua-lsp
fi
if [ "Y$OPT_FE" == "Yyes" ];then
    apt-get install -y npm
    npm install -g typescript typescript-language-server
    npm install -g vscode-css-languageserver-bin
fi
if [ "Y$OPT_JAVA" == "Yyes" ];then
    if [ ! -d ~/lsp/eclipse.jdt.ls ];then
        mkdir -p ~/lsp/eclipse.jdt.ls && \
        cd ~/lsp/eclipse.jdt.ls && \
        curl -L https://download.eclipse.org/jdtls/milestones/0.35.0/jdt-language-server-0.35.0-201903142358.tar.gz -O && \
        tar xf jdt-language-server-0.35.0-201903142358.tar.gz && rm jdt-language-server*.tar.gz
    fi
    rm -rf /usr/local/bin/jdtls
    cp tools/dep/jdtls /usr/local/bin && chmod u+x /usr/local/bin/jdtls
fi

# install ripgrep
! which rg && \
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb && \
    sudo dpkg -i ripgrep_0.10.0_amd64.deb && rm -rf ripgrep_0.10.0_amd64.deb
