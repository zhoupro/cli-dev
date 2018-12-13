#!/bin/bash
[ ! -d ~/.oh-my-zsh ] && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

#auto suggest
! (grep -F 'zsh-autosuggestions' ~/.zshrc &>/dev/null )  && \
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-aut
osuggestions" && \
    sed -in '/^plugins=/a zsh-autosuggestions' ~/.zshrc
