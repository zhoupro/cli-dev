#!/bin/bash -
#===============================================================================
#        AUTHOR:  prozhou 
#       CREATED: 2018/03/24 18时08分31秒
#===============================================================================

if [ -d ~/.oh-my-zsh ];then
    return
fi


sh -c "$(pxy curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

if [ ! -d "$HOME/.zplug" ];then
    pxy git clone https://github.com/zplug/zplug.git ~/.zplug
    sudo usermod -s /bin/zsh root
fi

! (grep -F 'zsh-autosuggestions' ~/.zshrc &>/dev/null )  && \
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" && \
sed -E -i "s/plugins=\((.*)\)/plugins=\(\1 zsh-autosuggestions\)/g" ~/.zshrc



! (grep -F 'zsh-syntax-highlighting' ~/.cus_zshrc &>/dev/null )  && \
cat >> ~/.cus_zshrc <<END
export ZPLUG_HOME=~/.zplug
source \$ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
source /root/.zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
END

#zsh plugin
! (grep -F '.cus_zshrc' ~/.zshrc &>/dev/null )  && \
    echo 'if [ -f ~/.cus_zshrc ];then; source ~/.cus_zshrc;fi' >> ~/.zshrc && \
    echo 'if [ -f ~/.env ];then; source ~/.env;fi' >> ~/.zshrc && \
    echo 'zplug install' >> ~/.zshrc


#man highlight
! (grep -F 'LESS_TERMCAP_mb' ~/.env &>/dev/null )  && \
cat >> ~/.env <<END
man() {
   env \\
     LESS_TERMCAP_mb=\$(printf "\\e[1;31m") \\
     LESS_TERMCAP_md=\$(printf "\\e[1;31m") \\
     LESS_TERMCAP_me=\$(printf "\\e[0m") \\
     LESS_TERMCAP_se=\$(printf "\\e[0m") \\
     LESS_TERMCAP_so=\$(printf "\\e[1;44;33m") \\
     LESS_TERMCAP_ue=\$(printf "\\e[0m") \\
     LESS_TERMCAP_us=\$(printf "\\e[1;32m") \\
          man "\$@"
}
END


#zsh pure
if [ ! -d "$HOME/.zsh/pure" ];then
    pxy git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

! (grep -F 'pure' ~/.zshrc &>/dev/null )  && \
cat >> ~/.zshrc <<END
fpath+=\$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
END
