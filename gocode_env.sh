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
    fi
else
    echo "have install gocode"
fi
