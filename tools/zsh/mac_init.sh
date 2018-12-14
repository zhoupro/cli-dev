#!/bin/bash
[ ! -d ~/.oh-my-zsh ] && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo $PATH | awk -F ':' '{print $NF}'|grep -q '/usr/local/bin'; [ $? -ne 0 ] && export PATH=$PATH:/usr/local/bin && \
	echo 'export PATH=$PATH:/usr/local/bin' >> ~/.zshrc
#auto suggest
! (grep -F 'zsh-autosuggestions' ~/.zshrc &>/dev/null )  && \
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" && \
sed -in '/^plugins=/a zsh-autosuggestions' ~/.zshrc
