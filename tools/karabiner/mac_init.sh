#!/bin/bash
if [ ! -d /Applications/Karabiner-Elements.app ];then
    wget "https://pqrs.org/osx/karabiner/files/Karabiner-Elements-12.1.0.dmg"
    sudo hdiutil attach -quiet "Karabiner-Elements-12.1.0.dmg"
    sudo installer -pkg "/Volumes/Karabiner-Elements-12.1.0/Karabiner-Elements.sparkle_guided.pkg"  -target "/Volumes/Macintosh HD"
    sudo hdiutil detach "/Volumes/Karabiner-Elements-12.1.0"
    wget  -P  ~/.config/karabiner/assets/complex_modifications/  https://raw.githubusercontent.com/zhoupro/cap_esc_exchange_terminal/master/cap_esc_exchage_terminal.json
    rm -rf "Karabiner-Elements-12.1.0.dmg"
fi
