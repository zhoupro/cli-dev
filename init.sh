#!/bin/bash -
# File              : init.sh
# Author            : prozhou <zhoushengzheng@gmail.com>
# Date              : 27.11.2018
# Last Modified Date: 27.11.2018
# Last Modified By  : prozhou <zhoushengzheng@gmail.com>

source "./helper/system_info.sh"
source "./helper/installer.sh"
ins dep
ins zsh
ins hyper
ins neovim
ins tmux
ins jdk
ins karabiner
ins ssh
ins clipper
exit

if [ $sys_os != "mac" ]; then
    apt-get install -y netcat iproute2
    #install proxy tool
    if   netcat -z `/sbin/ip route|awk '/default/ { print $3 }'` 8085 && [ ! -f /usr/local/bin/pxy ] ;then
        cp ./helper/pxy.sh /usr/local/bin/pxy && chmod u+x /usr/local/bin/pxy 
        curl http://`/sbin/ip route|awk '/default/ { print $3
    }'`:8085/module/gae_proxy/control/download_cert |sudo tee  --append /etc/ssl/certs/ca-certificates.crt
    fi
fi
# vim: set ts=4 sw=4 tw=0 et :
