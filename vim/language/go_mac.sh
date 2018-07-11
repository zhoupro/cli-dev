#!/bin/bash
function go_post(){ 
    echo ""
}

function go_pre(){
    echo ""
}

function go_vimrc(){
    # plugins
    sed -i ""  "/VundleVim\\/Vundle/a\\
Plugin 'sebdah/vim-delve'
" ~/.vimrc
    sed -i ""  "/VundleVim\\/Vundle/a\\
Plugin 'Shougo/vimshell.vim'
" ~/.vimrc
    sed -i ""  "/VundleVim\\/Vundle/a\\
Plugin 'Shougo/vimproc.vim'
" ~/.vimrc
    sed -i ""  "/VundleVim\\/Vundle/a\\
Plugin 'fatih/vim-go'
" ~/.vimrc
}
