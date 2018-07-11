#!/bin/bash
function host_post(){ 
    echo ""
}

function host_pre(){
    echo ""
}

function host_vimrc(){
    # plugins
    sed -i ""  "/VundleVim\\/Vundle/a\\
Plugin 'iamcco/markdown-preview.vim'
" ~/.vimrc
    sed -i ""  "/VundleVim\\/Vundle/a\\
Plugin 'rizzatti/dash.vim'
" ~/.vimrc
   cat >>  ~/.vimrc <<END
nnoremap  <leader>q  :Dash<CR>
END
}
