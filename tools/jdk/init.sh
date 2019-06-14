#!/usr/bin/env bash

function jdk(){
    JDK_VERSION=11
    DOWN_URL="https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz"
    sudo mkdir -p /usr/lib/jvm && sudo chmod 777   /usr/lib/jvm
    if [ ! -d /usr/lib/jvm/jdk${JDK_VERSION} ]; then
        if [ ! -f openjdk*.tar.gz ];
            then
            echo "downloading jdk ${JDK_VERSION}"
            wget $DOWN_URL
        fi
        rm -rf /usr/lib/jvm/*
        tar xzvf openjdk*.tar.gz && mv jdk-11 jdk${JDK_VERSION} && mv jdk${JDK_VERSION} /usr/lib/jvm/
        echo "export JAVA_HOME=/usr/lib/jvm/jdk${JDK_VERSION}" >> "$HOME/.cus_zshrc" 
        echo "export CLASSPATH=\".:/usr/lib/jvm/jdk${JDK_VERSION}/lib:/usr/lib/jvm/jdk${JDK_VERSION}\""  >> "$HOME/.cus_zshrc"
        echo "export PATH=\"/usr/lib/jvm/jdk${JDK_VERSION}/bin:$PATH\"" >>  "$HOME/.cus_zshrc" 
        export JAVA_HOME="/usr/lib/jdk${JDK_VERSION}"
        export CLASSPATH=".:/usr/lib/jvm/jdk${JDK_VERSION}/lib:/usr/lib/jvm/jdk${JDK_VERSION}" 
        export PATH="/usr/lib/jvm/jdk${JDK_VERSION}/bin:$PATH"
    fi
}
if [ ! -f /usr/lib/jvm/jdk${JDK_VERSION}/bin/java ];then
    jdk
fi
