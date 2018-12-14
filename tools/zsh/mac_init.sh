#!/bin/bash
[ ! -d ~/.oh-my-zsh ] && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo $PATH | awk -F ':' '{print $NF}'|grep -q '/usr/local/bin'; [ $? -ne 0 ] && export PATH=$PATH:/usr/local/bin && \
	echo 'export PATH=$PATH:/usr/local/bin' >> ~/.zshrc
#auto suggest
! (grep -F 'zsh-autosuggestions' ~/.zshrc &>/dev/null )  && \
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" && \
sed -in '/^plugins=/a zsh-autosuggestions' ~/.zshrc

[ ! -d "$HOME/.zplug" ] && curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

! (grep -F 'zsh-syntax-highlighting' ~/.cus_zshrc &>/dev/null )  && \
cat >> ~/.cus_zshrc <<END
export ZPLUG_HOME=~/.zplug
source \$ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
source \$HOME/.zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
END

#zsh plugin
! (grep -F '.cus_zshrc' ~/.zshrc &>/dev/null )  && \
    echo 'if [ -f ~/.cus_zshrc ];then; source ~/.cus_zshrc;fi' >> ~/.zshrc && \
    echo 'zplug install' >> ~/.zshrc
