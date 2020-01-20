#!/bin/bash

apt-get install -y gawk curl  zsh language-pack-zh-hans language-pack-zh-hans-base \
    git unzip wget  python-dev  python3-pip python-pip lsof \
    libtool-bin gettext sudo \
    cmake automake m4 autoconf libtool build-essential  pkg-config  wamerican \
    autojump  nmap iproute2 net-tools sshfs axel netcat
apt-get remove -y neovim exuberant-ctags
npm install -g yarn
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

#install clangd8 url:https://apt.llvm.org/
if [ "Y$OPT_CPP" == "Yyes" ];then
    ! ( grep -F "llvm-toolchain-" /etc/apt/sources.list ) && \
    cat >> /etc/apt/sources.list <<END
    # clangd
    # i386 not available
    deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
    deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main
    # 7
    deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main
    deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-7 main
    # 8
    deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main
    deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main
END
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - &&\
    apt update && apt install -y clang-tools-8 &&\
    sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100
fi

if [ "Y$OPT_CPP" == "Yyes" ];then
    apt-get install -y \
    valgrind clang-format cscope gdb
fi

if [ "Y$OPT_BASH" == "Yyes" ];then
    apt-get install -y \
    shellcheck
    if ! which bash-language-server > /dev/null; then
       sudo npm i -g bash-language-server --unsafe-perm
    fi
fi
if [ "Y$OPT_PHP" == "Yyes" ];then
   sudo npm i -g intelephense
fi
if [ "Y$OPT_PYTHON" == "Yyes" ];then
    sudo pip3 install jedi
fi
if [ "Y$OPT_VIM" == "Yyes" ];then
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
if [ "Y$OPT_JAVA" == "Yyes" ];then
    OLD_DIR=`pwd`
    if [ ! -d ~/.config/coc/extensions/coc-java-data/server/config_linux ];then
        mkdir -p  ~/.config/coc/extensions/coc-java-data/server && \
        cd  ~/.config/coc/extensions/coc-java-data/server && \
        axel https://download.eclipse.org/jdtls/milestones/0.35.0/jdt-language-server-0.35.0-201903142358.tar.gz && \
        tar xf jdt-language-server-0.35.0-201903142358.tar.gz && rm jdt-language-server*.tar.gz
    fi
    cd $OLD_DIR
    if [ ! -d /opt/apache-maven-3.6.1 ];then
        # install maven
        cd /opt && \
        wget http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz && \
            tar xf  apache-maven-3.6.1-bin.tar.gz && \
            export PATH=/opt/apache-maven-3.6.1/bin:$PATH && \
            echo "export PATH=\"/opt/apache-maven-3.6.1:$PATH\"" >>  "$HOME/.cus_zshrc"
        cd $OLD_DIR
    fi
fi

# install ripgrep
! which rg && \
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb && \
    sudo dpkg -i ripgrep_0.10.0_amd64.deb && rm -rf ripgrep_0.10.0_amd64.deb
