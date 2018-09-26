#!/bin/bash -
#===============================================================================
#        AUTHOR:  prozhou 
#       CREATED: 2018/03/24 18时08分31秒
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
apt-get install zsh language-pack-zh-hans language-pack-zh-hans-base -y
sudo usermod -s /bin/zsh root
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
echo 'export LC_ALL=zh_CN.UTF-8' >> ~/.env
echo 'export LANG=zh_CN.UTF-8' >> ~/.env
echo "export PATH=\$PATH:$HOME/.composer/vendor/bin" > $HOME/.env
echo 'if [ -f ~/.env ];then; source ~/.env;fi' >> ~/.zshrc

