#!/bin/bash
[ ! -d ~/.oh-my-zsh ] && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

echo $PATH | awk -F ':' '{print $NF}'|grep -q '/usr/local/bin'; [ $? -ne 0 ] && export PATH=$PATH:/usr/local/bin && \
	echo 'export PATH=$PATH:/usr/local/bin' >> ~/.zshrc
#auto suggest
! (grep -F 'zsh-autosuggestions' ~/.zshrc &>/dev/null )  && \
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" && \
sed -E -i "s/plugins=\((.*)\)/plugins=\(\1 zsh-autosuggestions\)/g" ~/.zshrc
echo 'no'

[ ! -d "$HOME/.zplug" ] && curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

! (grep -F 'zsh-syntax-highlighting' ~/.cus_zshrc &>/dev/null )  && \
cat >> ~/.cus_zshrc <<END
export ZPLUG_HOME=~/.zplug
source \$ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
source \$HOME/.zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
END

# language
!  (grep -F 'LANGUAGE' ~/.zshrc &>/dev/null )  && \
sed -i '1iexport LANGUAGE=en_US.UTF-8' ~/.zshrc &&\
sed -i '1iexport LC_ALL=en_US.UTF-8' ~/.zshrc &&\
sed -i '1iexport LANG=en_US.UTF-8' ~/.zshrc &&\
sed -i '1iexport LC_TYPE=en_US.UTF-8' ~/.zshrc
#zsh plugin
! (grep -F '.cus_zshrc' ~/.zshrc &>/dev/null )  && \
    echo 'if [ -f ~/.cus_zshrc ];then; source ~/.cus_zshrc;fi' >> ~/.zshrc && \
    echo 'zplug install' >> ~/.zshrc
!  (grep -F 'bracketed-paste-magic' ~/.zshrc &>/dev/null )  && \
cat >> ~/.zshrc <<END
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=\${\${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need \`.url-quote-magic\`?
}

pastefinish() {
  zle -N self-insert \$OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
END

#themes
! (grep -F 'avit' ~/.zshrc &>/dev/null )  && \
    sed -i 's#ZSH_THEME="robbyrussell"#ZSH_THEME="avit"#g' ~/.zshrc

! (grep -F 'history-incremental-search-backward' ~/.cus_zshrc &>/dev/null )  && \
cat >> ~/.cus_zshrc <<END

bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{\$fg_bold[yellow]%} [% NORMAL]%  %{\$reset_color%}"
    RPS1="\${\${KEYMAP/vicmd/\$VIM_PROMPT}/(main|viins)/} \$EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
END
# avit theme show ip address
! (grep -F 'ifconfig' ~/.oh-my-zsh/themes/avit.zsh-theme &>/dev/null )  && \
sed -i '/if.*n.*me.*then/i  ip=`ifconfig | grep "inet " | grep -v 127.0.0.1 | awk "{print $2}"`' ~/.oh-my-zsh/themes/avit.zsh-theme && \
sed -i '/if.*n.*me.*then/i me="%n@$ip"' ~/.oh-my-zsh/themes/avit.zsh-theme
