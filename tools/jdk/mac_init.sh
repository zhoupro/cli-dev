#!/usr/bin/env bash
#http://www.linuxidc.com/Linux/2016-06/132678.htm

function downloadjdk(){
	 wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  http://download.oracle.com/otn-pub/java/jdk/11.0.2+9/f51449fcd52f4d52b93a989c5c56ed3c/jdk-11.0.2_osx-x64_bin.dmg 
}


function jdk(){
   if [ ! -f jdk-11.0.2_osx-x64_bin.dmg ];then
       downloadjdk
   fi
   sudo hdiutil attach -quiet jdk-11.0.2_osx-x64_bin.dmg
   sudo installer -pkg /Volumes/JDK\ 11.0.2/JDK\ 11.0.2.pkg  -target "/"
   sudo hdiutil detach  "/Volumes/JDK 11.0.2"

}
if [ ! -d /Library/Java/JavaVirtualMachines/jdk-11.0.2.jdk ];then
    jdk
fi
