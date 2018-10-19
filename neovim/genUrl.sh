#!/bin/bash
# check file
[ ! -f "$1" ] &&
    exit 0
git_path="~/.local/share/nvim/plugged/images"
github_prefix="https://raw.githubusercontent.com/zhoupro/images/master"
old_path=$(pwd)
cur_date=$(date +"%Y%m%d")
file_name=$(basename "$1")
cd "$git_path" && \
ls   | grep -v $cur_date | xargs rm -rf &&\
cd "$old_path"

if [ -f "$git_path/$cur_date/$file_name" ]
then 
    echo "$github_prefix/$cur_date/$file_name"
    exit 0
fi
mkdir -p $git_path/$cur_date
cp $1 $git_path/$cur_date
cd $git_path && \
git add "$cur_date" &&\
git commit -m "$cur_date file" &&\
git push origin master &&\
cd $old_path
