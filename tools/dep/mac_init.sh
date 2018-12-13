which brew
if ! which brew;then
    /usr/bin/ruby -e \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

apps="wget fzf ripgrep autojump"
for app in $apps
do
    ! brew list | grep $app && brew install $app
done
