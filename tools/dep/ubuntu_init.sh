#!/bin/bash

apt-get install -y gawk curl  zsh language-pack-zh-hans language-pack-zh-hans-base \
    git unzip wget curl python-dev cscope  cmake gdb lsof \
    python3-pip python-pip shellcheck libtool-bin gettext sudo \
    automake m4 autoconf libtool build-essential cmake pkg-config lua5.2 wamerican \
    autojump  nmap iproute2 net-tools sshfs

apt-get remove -y neovim exuberant-ctags

if [ "Y$OPT_MAN" == "Yyes" ];then
    [ -f  /etc/dpkg/dpkg.cfg.d/excludes ] && rm -rf /etc/dpkg/dpkg.cfg.d/excludes
    apt-get install -y \
    cppman man manpages manpages-dev manpages-posix manpages-posix-dev
fi
if [ "Y$OPT_DICT" == "Yyes" ];then
    apt-get install -y sdcv
    mkdir -p /usr/share/stardict/dic/ && \
    wget http://download.huzheng.org/zh_CN/stardict-langdao-ec-gb-2.4.2.tar.bz2 && \
    wget http://download.huzheng.org/zh_CN/stardict-langdao-ce-gb-2.4.2.tar.bz2 &&  \
    tar -xjvf stardict-langdao-ce-gb-2.4.2.tar.bz2 -C /usr/share/stardict/dic && \
    tar -xjvf stardict-langdao-ec-gb-2.4.2.tar.bz2 -C /usr/share/stardict/dic && \
    rm -rf stardict-langdao*
fi

if [ "Y$OPT_VIM_C" == "Yyes" ];then
    apt-get install -y \
    valgrind clang-format
fi

# install ripgrep
! which rg && \
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb && \
    sudo dpkg -i ripgrep_0.10.0_amd64.deb && rm -rf ripgrep_0.10.0_amd64.deb
