#!/bin/bash

apt-get install -y gawk curl  zsh \
    git unzip wget    python3-pip  lsof sudo \
    autojump  nmap iproute2 net-tools  axel netcat ripgrep

    #clibtool-bin gettext make automake m4 autoconf libtool build-essential  pkg-config  wamerican \


apt-get remove -y neovim exuberant-ctags



#install lazygit
#if [ ! -f /usr/local/bin/lazygit ]; then
#    wget https://github.com/jesseduffield/lazygit/releases/download/v0.13/lazygit_0.13_Linux_x86_64.tar.gz && tar xzvf lazygit_0.13_Linux_x86_64.tar.gz &&  mv lazygit /usr/local/bin/ && chmod u+x /usr/local/bin/lazygit
#fi

if [ "Y$OPT_MAN" == "Yyes" ];then
    [ -f  /etc/dpkg/dpkg.cfg.d/excludes ] && rm -rf /etc/dpkg/dpkg.cfg.d/excludes
    apt-get install -y \
    cppman man manpages manpages-dev manpages-posix manpages-posix-dev
fi

#install clangd8 url:https://apt.llvm.org/
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

