#!/usr/bin/env bash
#
#安装软件总控制器,调用分控制器
#
# $1  package name

function ins(){
     install_fun=$1
     shift
     install_args=$@
     exact_file="tools/$install_fun/${sys_os}_init.sh"
     common_file="tools/$install_fun/init.sh"
     if [ -f $exact_file ];then
         source_file=$exact_file
     elif [ -f $common_file ];then
         source_file=$common_file
     else
         echo "no file"
         return
     fi
     source $source_file $install_args
}
