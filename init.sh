#!/bin/bash -
#===============================================================================
#        AUTHOR: prozhou 
#       CREATED: 2018/03/11 17时45分11秒
#      REVISION:  ---
#       vim tmux zsh for mac and linux develop env
#===============================================================================

set -o nounset    
source ./helper/system_info.sh

#install tmux
cd tmux
source "./${sys_os}_init.sh"
cd ..

#install zsh
cd zsh
source "./${sys_os}_init.sh"
cd ..

#install neovim
cd neovim
source "./${sys_os}_init.sh"
cd ..
