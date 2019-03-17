which brew
if ! which brew;then
    /usr/bin/ruby -e \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

apps="wget fzf ripgrep autojump netcat iproute2mac clipper nmap"
for app in $apps
do
    ! brew list | grep $app && brew install $app
done

! brew list | grep python && brew install python3
! brew list | grep python@2 && brew install python2
! brew list | grep node && brew install node
! brew list | grep yarn && brew install yarn
! ls /Library/Fonts | grep Fura &&
wget https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/FiraCode/Retina/complete/Fura%20Code%20Retina%20Nerd%20Font%20Complete%20Mono.ttf && \
mv Fura*Mono.ttf /Library/Fonts
! brew list | grep gnu-sed  && brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep
