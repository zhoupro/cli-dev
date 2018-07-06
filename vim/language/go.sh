#!/bin/bash
function go_post(){ 
    echo ""
}

function go_pre(){
    echo ""
}

function go_vimrc(){
    # plugins
    sed -i  "/VundleVim\\/Vundle/aPlugin 'Shougo/vimshell.vim'" ~/.vimrc
    sed -i  "/VundleVim\\/Vundle/aPlugin 'Shougo/vimproc.vim'" ~/.vimrc
    sed -i  "/VundleVim\\/Vundle/aPlugin 'sebdah/vim-delve'" ~/.vimrc
    sed -i  "/VundleVim\\/Vundle/aPlugin 'fatih/vim-go'" ~/.vimrc
}
