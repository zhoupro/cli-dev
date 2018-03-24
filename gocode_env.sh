#!/bin/bash -
#install go
source ./helper/system_info.sh
which go
if [ $? -eq 0 ];
then
    #not install gocode
    which gocode
    if [ $?  -gt 0 ];
    then
        echo "begin install gocode"
        go get github.com/nsf/gocode
        OLD_PWD=$(pwd)
        cd $HOME/go/src/github.com/nsf/gocode
        go build
        go install
        cd $OLD_PWD
        echo $OLD_PWD
        #docker xxnet
        docker ps | grep xxnet
        if [ $? -eq 0 ]
        then
            
           if [ $sys_os = "linux" ] ;then
               echo 'export PATH=$PATH:$HOME/go/bin' | sudo tee --append   /etc/profile
               wget http://localhost:28085/module/gae_proxy/control/download_cert -O CA.crt 
               cat CA.crt| sudo tee  --append /etc/ssl/certs/ca-certificates.crt
           fi
            bash ./helper/pxy.sh vim   +GoInstallBinaries +qall
        fi
    fi
else
    echo "Please install go first"
fi
