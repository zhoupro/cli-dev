#!/bin/bash
function host_post(){ 
    echo ""
}

function host_pre(){
    echo ""
}

function host_vimrc(){
    # plugins
    sed -i  "/VundleVim\\/Vundle/aPlugin 'iamcco/markdown-preview.vim'" ~/.vimrc
    sed -i  "/VundleVim\\/Vundle/aPlugin 'rizzatti/dash.vim'" ~/.vimrc
    sed -i  "/VundleVim\\/Vundle/aPlugin 'KabbAmine/zeavim.vim'" ~/.vimrc

   cat >>  ~/.vimrc <<END
nnoremap  <leader>q  :Dash<CR>
END
}
