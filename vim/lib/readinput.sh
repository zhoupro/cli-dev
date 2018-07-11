#!/usr/bin/env bash
#参数说明函数
function helper(){
    echo "-h: help info"
    echo "-p: enable php"
    echo "-c: enable c"
    echo "-g: enable go"
    echo "-l: for local host"

}
IFPHP=0
IFC=0
IFGOLANG=0
IFHOST=0


while getopts "hpcgl" OPT;
do
     case $OPT in
         h) helper;exit 1;;
         p)  export IFPHP=1;;
         c)  export IFC=1;;
         g)  export IFGOLANG=1;;
         l)  export IFHOST=1;;
         *) ;;
     esac
done
