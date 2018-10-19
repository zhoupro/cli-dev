#!/bin/bash
# check file
[ ! -f "$1" ] &&
    exit 0
git_path="$HOME/.local/share/nvim/plugged/"
git_repo="git@github.com:zhoupro/images.git"
repo_name="images"
github_prefix="https://raw.githubusercontent.com/zhoupro/images/master"
old_path=$(pwd)
cur_date=$(date +"%Y%m%d")
file_name=$(basename "$1")

if [  ! -d "$git_path/$repo_name/.git" ]
then
    cd $git_path  
    git clone --quiet $git_repo  
    cd $old_path
fi
cd "$git_path/$repo_name" && \
ls   | grep -v $cur_date | xargs rm -rf &&\
cd "$old_path"

if [ -f "$git_path/$repo_name/$cur_date/$file_name" ]
then 
    echo "$github_prefix/$cur_date/$file_name"
    exit 0
fi
mkdir -p $git_path/$repo_name/$cur_date
cp $1 $git_path/$repo_name/$cur_date
cd $git_path/$repo_name && \
git add  "$cur_date" > /dev/null  &&\
git commit  -m "$cur_date $file_name" >/dev/null  &&\
git push --quiet origin master  &&\
cd $old_path
echo "$github_prefix/$cur_date/$file_name"
