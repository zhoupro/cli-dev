#!/bin/bash

[ -f  /etc/dpkg/dpkg.cfg.d/excludes ] && rm -rf /etc/dpkg/dpkg.cfg.d/excludes

apt-get install -y gawk curl  zsh language-pack-zh-hans language-pack-zh-hans-base \
    man manpages manpages-dev manpages-posix manpages-posix-dev \
    git unzip wget curl python-dev cscope  cmake gdb lsof \
    python3-pip python-pip shellcheck libtool-bin gettext silversearcher-ag sudo \
    automake m4 autoconf libtool build-essential cmake pkg-config lua5.2 wamerican \
    autojump
    

apt-get remove -y neovim exuberant-ctags
