#!/bin/bash
rm ~/.hyper.js
cp tools/hyper/hyper.js ~/.hyper.js
if [ -d "/Applications/Hyper.app" ];then
    return
fi
wget "https://github.com/zeit/hyper/releases/download/2.1.0-canary.4/Hyper-2.1.0-canary.4.dmg"
sudo hdiutil attach -quiet "Hyper-2.1.0-canary.4.dmg"
sudo cp -r "/Volumes/Hyper 2.1.0-canary.4/Hyper.app" /Applications
sudo hdiutil detach  "/Volumes/Hyper 2.1.0-canary.4"
rm -rf "Hyper-2.1.0-canary.4.dmg"
