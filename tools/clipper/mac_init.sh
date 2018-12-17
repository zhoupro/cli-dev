#!/bin/bash
if [ ! -f ~/Library/LaunchAgents/com.wincent.clipper.plist ];then
    cp tools/clipper/com.wincent.clipper.plist ~/Library/LaunchAgents/
    launchctl load -w -S Aqua ~/Library/LaunchAgents/com.wincent.clipper.plist
fi

