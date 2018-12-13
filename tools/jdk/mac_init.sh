#!/usr/bin/env bash
#http://www.linuxidc.com/Linux/2016-06/132678.htm

function downloadjdk(){
	 wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_osx-x64_bin.dmg 
}


function jdk(){
   if [ ! -f jdk-11.0.1_osx-x64_bin.dmg ];then
       downloadjdk
   fi
   sudo hdiutil attach -quiet jdk-11.0.1_osx-x64_bin.dmg
   sudo installer -pkg /Volumes/JDK\ 11.0.1/JDK\ 11.0.1.pkg  -target "/Volumes/Macintosh HD"
   sudo hdiutil detach  "/Volumes/JDK 11.0.1"

}
if [ ! -d /Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk ];then
    jdk
fi
