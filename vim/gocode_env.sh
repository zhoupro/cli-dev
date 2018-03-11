#!/bin/bash -
#install go
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
        echo 'export PATH=$PATH:$HOME/go/bin' | sudo tee --append   /etc/profile
        cd $OLD_PWD
        echo $OLD_PWD
        # local xxnet
        ps -ef | grep -v grep | grep xx.net
        if [ $? -eq 0 ]
        then
            cat /opt/soft/xx-net/data/gae_proxy/CA.crt| sudo tee  --append /etc/ssl/certs/ca-certificates.crt
            bash pxy.sh vim   +GoInstallBinaries +qall
        fi
        #docker xxnet
        docker ps | grep xxnet
        if [ $? -eq 0 ]
        then
            wget http://localhost:28085/module/gae_proxy/control/download_cert -O CA.crt
            cat CA.crt| sudo tee  --append /etc/ssl/certs/ca-certificates.crt
            bash pxy.sh vim   +GoInstallBinaries +qall
        fi
    fi
else
    echo "Please install go first"
fi
