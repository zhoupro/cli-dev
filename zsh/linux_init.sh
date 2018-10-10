#!/bin/bash -
#===============================================================================
#        AUTHOR:  prozhou 
#       CREATED: 2018/03/24 18时08分31秒
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
apt-get install gawk curl  zsh language-pack-zh-hans language-pack-zh-hans-base -y
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

[ ! -d $HOME/.zplug ] && curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
sudo usermod -s /bin/zsh root

! (grep -F 'LC_ALL' ~/.env >/dev/null )  && \
echo 'export LC_ALL=zh_CN.UTF-8' >> "$HOME/.env" && \
echo 'export LANG=zh_CN.UTF-8' >> "$HOME/.env" && \
echo "export PATH=\$PATH:$HOME/.composer/vendor/bin" >> "$HOME/.env"

#env
! (grep -F '.env' ~/.zshrc >/dev/null )  && \
    echo 'if [ -f ~/.env ];then; source ~/.env;fi' >> ~/.zshrc

! (grep -F 'zsh-syntax-highlighting' ~/.cus_zshrc >/dev/null )  && \
cat >> ~/.cus_zshrc <<END
export ZPLUG_HOME=~/.zplug
source \$ZPLUG_HOME/init.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
source /root/.zplug/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
END

#zsh plugin
! (grep -F '.cus_zshrc' ~/.zshrc >/dev/null )  && \
    echo 'if [ -f ~/.cus_zshrc ];then; source ~/.cus_zshrc;fi' >> ~/.zshrc && \
    echo 'zplug install' >> ~/.zshrc

[ -f  /etc/dpkg/dpkg.cfg.d/excludes ] && rm -rf /etc/dpkg/dpkg.cfg.d/excludes
apt-get install -y man manpages manpages-dev manpages-posix manpages-posix-dev 
! (grep -F 'LESS_TERMCAP_mb' ~/.env >/dev/null )  && \
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

! (grep -F 'robbyrussell' ~/.zshrc >/dev/null )  && \
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" && \
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" &&\
    sed -i 's#ZSH_THEME="robbyrussell"#ZSH_THEME="spaceship"#g' ~/.zshrc
