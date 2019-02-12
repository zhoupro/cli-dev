#!/bin/bash

! which rg && \
sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo && \
sudo yum install -y  ripgrep

! which fzf && \
wget https://github.com/junegunn/fzf-bin/releases/download/0.17.5/fzf-0.17.5-linux_amd64.tgz &&
tar xzvf fzf-0.17.5-linux_amd64.tgz && sudo mv fzf "/usr/local/bin" && rm fzf-*.tgz

sudo yum install -y python34-pip
sudo yum install -y python2-pip zsh


! which netcat && \
wget http://sourceforge.net/projects/netcat/files/netcat/0.7.1/netcat-0.7.1.tar.gz && \
tar xzvf netcat-0.7.1.tar.gz && \
cd netcat-0.7.1 && \
./configure && make && make install && \
cd ..
