#!/usr/bin/env bash
# check root
if [ $UID -ne 0 ]; then
    echo "Superuser privileges are required to run this script."
    echo "e.g. \"sudo $0\""
    exit 1
fi
#参数说明函数
function helper(){
    echo "-h: help info";
    echo "-p: enable proxy";
    echo "-b: enable docker build"

}
IFPHP=0
IFC=0


while getopts "hpc" OPT;
do
     case $OPT in
         h) helper;exit 1;;
         p)  export IFPHP=1;;
         c)  export IFC=1;;
         *) ;;
     esac
done
