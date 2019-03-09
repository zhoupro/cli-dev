if [  -f ~/.phoenix.js ];then
    rm ~/.phoenix.js
fi

if [ ! -d ~/.config ];then
    mkdir -p ~/.config
fi
if [ ! -d ~/.config/phoenix ];then
    git clone https://github.com/zhoupro/phoenix.git ~/.config/phoenix
fi
! brew cask list | grep phoenix && brew cask install phoenix
