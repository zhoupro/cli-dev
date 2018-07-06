#!/bin/bash
function php_post(){ 
    echo ""
}

function php_pre(){
    echo ""
}

function php_vimrc(){
    # plugins
    sed -i  "/VundleVim\\/Vundle/aPlugin 'joonty/vdebug'" ~/.vimrc
    sed -i  "/VundleVim\\/Vundle/aPlugin 'shawncplus/phpcomplete.vim'" ~/.vimrc

   cat >>  ~/.vimrc <<END
let g:phpcomplete_enhance_jump_to_definition = 1
let g:phpcomplete_mappings = {
   \\ 'jump_to_def': '<C-]>',
   \\ 'jump_to_def_split': '<C-W><C-]>',
   \\ 'jump_to_def_vsplit': '<C-W><C-\\>',
   \\}

let g:vdebug_options= {
    \\    "port" : 9000,
    \\    "server" : '0.0.0.0',
    \\    "timeout" : 100,
    \\    "on_close" : 'detach',
    \\    "break_on_open" : 1,
    \\    "ide_key" : 'xdebug',
    \\    "path_maps" : {},
    \\    "debug_window_level" : 0,
    \\    "debug_file_level" : 0,
    \\    "debug_file" : "",
    \\    "watch_window_style" : 'expanded',
    \\    "marker_default" : '⬦',
    \\    "marker_closed_tree" : '▸',
    \\    "marker_open_tree" : '▾'
    \\}

END
}
