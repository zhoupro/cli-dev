#!/bin/bash
function c_ins(){
    ! (grep -F 'nvim-gdb' ~/.config/nvim/init.vim &>/dev/null ) && \
    sed -i "/plug#begin/aPlug 'vim-scripts/a.vim'" ~/.config/nvim/init.vim && \
    sed -i "/plug#begin/aPlug 'gauteh/vim-cppman'" ~/.config/nvim/init.vim && \
    sed -i "/plug#begin/aPlug 'rhysd/vim-clang-format'" ~/.config/nvim/init.vim && \
    sed -i "/plug#begin/aPlug 'sakhnik/nvim-gdb' , { 'branch': 'legacy' }" ~/.config/nvim/init.vim
    ! ( grep -F "languageserver" ~/.config/nvim/coc-settings.json ) && \
        sed -i '/suggest.timeout/i  "languageserver": { \n "clangd": { \n "command": "clangd",\n"filetypes": ["c", "cpp", "objc", "objcpp"],\n"args": ["-background-index"]\n }\n },' ~/.config/nvim/coc-settings.json

  ! ( grep -F "leetcode_solution_filetype" ~/.config/nvim/init.vim ) && \
    cat >> ~/.config/nvim/init.vim <<END
        let g:leetcode_solution_filetype='cpp'
END

}

function leetcode_ins(){
    ! (grep -F 'ianding1/leetcode' ~/.config/nvim/init.vim &>/dev/null ) && \
    pip3 install requests beautifulsoup4 && \
    sed -i "/plug#begin/aPlug 'ianding1/leetcode.vim'" ~/.config/nvim/init.vim

    ! ( grep -F "LeetCodeList" ~/.config/nvim/init.vim ) && \
cat >> ~/.config/nvim/init.vim <<END
    nnoremap <leader>ll :LeetCodeList<cr>
    nnoremap <leader>lt :LeetCodeTest<cr>
    nnoremap <leader>ls :LeetCodeSubmit<cr>
    nnoremap <leader>li :LeetCodeSignIn<cr>
END
}

function python_ins(){
    ! ( grep -F "python.linting.enabled" ~/.config/nvim/coc-settings.json ) && \
        sed -i '/suggest.timeout/i  "python.linting.enabled": false,' ~/.config/nvim/coc-settings.json
}

function java_ins(){
    ! ( grep -F "leetcode_solution_filetype" ~/.config/nvim/init.vim ) && \
cat >> ~/.config/nvim/init.vim <<END
    let g:leetcode_solution_filetype='java'
END
}

function lua_ins(){
    ! ( grep -F "languageserver" ~/.config/nvim/coc-settings.json ) && \
        sed -i '/suggest.timeout/i  "languageserver": {\n"lua": {\n"command": "lua-lsp",\n"filetypes": ["lua"]\n}\n },' ~/.config/nvim/coc-settings.json
}

function bash_ins(){
    ! ( grep -F "languageserver" ~/.config/nvim/coc-settings.json ) && \
        sed -i '/suggest.timeout/i  "languageserver": {\n"bash": {\n"command": "bash-language-server",\n"args": ["start"],\n"filetypes": ["sh"],"ignoredRootPaths": ["~"]\n}\n},' ~/.config/nvim/coc-settings.json
}

function fe_ins(){
    echo "fe"
}

function go_ins(){
    ! (grep -F 'sebdah/vim-delve' ~/.config/nvim/init.vim &>/dev/null ) && \
    sed -i "/plug#begin/aPlug 'sebdah/vim-delve'" ~/.config/nvim/init.vim
    sed -i "/plug#begin/aPlug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }" ~/.config/nvim/init.vim

    ! ( grep -F "languageserver" ~/.config/nvim/coc-settings.json ) && \
        sed -i '/suggest.timeout/i  "languageserver": {\n"golang": {\n"command": "gopls",\n"filetypes": ["go"]\n}\n},' ~/.config/nvim/coc-settings.json
    ! ( grep -F "leetcode_solution_filetype" ~/.config/nvim/init.vim ) && \
    cat >> ~/.config/nvim/init.vim <<END
    let g:leetcode_solution_filetype='golang'
END

}

function php_ins(){
    ! (grep -F 'vim-php-cs-fixer' ~/.config/nvim/init.vim &>/dev/null ) && \
    sed -i "/plug#begin/aPlug 'stephpy/vim-php-cs-fixer'" ~/.config/nvim/init.vim && \
    sed -i "/plug#begin/aPlug 'vim-vdebug/vdebug'" ~/.config/nvim/init.vim
    cat > /usr/local/bin/phpxd <<END
    #!/bin/zsh
    export XDEBUG_CONFIG="idekey=xdebug remote_host=localhost"
    php "\$@"
END
    chmod u+x  /usr/local/bin/phpxd

    ! ( grep -F "languageserver" ~/.config/nvim/coc-settings.json ) && \
        sed -i '/suggest.timeout/i  "languageserver": { \n"intelephense": {\n"command": "intelephense",\n"args": ["--stdio"],\n"filetypes": ["php"],\n"initializationOptions": {\n"storagePath": "/tmp/intelephense"\n }\n }\n},' ~/.config/nvim/coc-settings.json
}


#读取参数
# install neovim
if [ ! -f /usr/local/bin/vim ];then
    if [ ! -f nvim.appimage ];then
        wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    fi
    sudo chmod u+x nvim.appimage && sudo ./nvim.appimage --appimage-extract
    mkdir -p ~/opt/soft
    sudo mv squashfs-root ~/opt/soft/nvim
    rm -f /usr/local/bin/vim
    sudo ln -s  ~/opt/soft/nvim/squashfs-root/usr/bin/nvim /usr/local/bin/vim
    rm -f /usr/local/bin/nvim
    sudo ln -s  ~/opt/soft/nvim/squashfs-root/usr/bin/nvim /usr/local/bin/nvim
    rm -rf nvim.appimage
fi
pip3 install neovim --upgrade
pip2 install neovim --upgrade

#-------------------------------------------------------------------------------
# install vim-plug
#-------------------------------------------------------------------------------
if  [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ] ; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#-------------------------------------------------------------------------------
# copy init.vim to home dir, and install from command line
#-------------------------------------------------------------------------------
if [ ! -f ~/.vim/c_cnt.sh ] ; then
    mkdir -p  ~/.config/nvim
    cp tools/neovim/c_cnt.sh  ~/.config/nvim/c_cnt.sh
    cp tools/neovim/add_swap.sh  ~/.config/nvim/add_swap.sh
    cp tools/neovim/del_swap.sh  ~/.config/nvim/del_swap.sh
fi
rm -f ~/.config/nvim/init.vim
#common config
mkdir -p ~/.config/nvim
cp tools/neovim/init.vim ~/.config/nvim/init.vim
cp tools/neovim/coc-settings.json ~/.config/nvim/coc-settings.json
# copy
if nmap localhost -p 8377 | grep open 2>/dev/null;then
    sed -in 's#NCHOST#localhost#g' ~/.config/nvim/init.vim
else
    sed -in 's#NCHOST#host.docker.internal#g' ~/.config/nvim/init.vim
fi

if [ "$sys_os" == "ubuntu" ];then
    sed -in 's#NCCOMMAND#nc -q 1#g'  ~/.config/nvim/init.vim
else
    sed -in 's#NCCOMMAND#nc -c#g' ~/.config/nvim/init.vim
fi

#language

if [ "Y$OPT_GO" == "Yyes" ];then
    go_ins
fi

if [ "Y$OPT_PHP" == "Yyes" ];then
    php_ins
fi

if [ "Y$OPT_CPP" == "Yyes" ];then
    c_ins
fi

if [ "Y$OPT_LUA" == "Yyes" ];then
    lua_ins
fi

if [ "Y$OPT_JAVA" == "Yyes" ];then
    java_ins
fi
if [ "Y$OPT_PYTHON" == "Yyes" ];then
    python_ins
fi
if [ "Y$OPT_LEETCODE" == "Yyes" ];then
    leetcode_ins
fi
if [ "Y$OPT_FE" == "Yyes" ];then
    fe_ins
fi
if [ "Y$OPT_BASH" == "Yyes" ];then
    bash_ins
fi

#language end

export shell=/bin/bash
nvim +'PlugInstall --sync' +qall

#language server install
nvim "+CocInstall -sync coc-snippets" +qall

if [ "Y$OPT_FE" == "Yyes" ];then
    nvim "+CocInstall -sync coc-html coc-css coc-tsserver coc-emmet" +qall
fi

if [ "Y$OPT_JAVA" == "Yyes" ];then
    nvim "+CocInstall -sync coc-java" +qall
fi

if [ "Y$OPT_PYTHON" == "Yyes" ];then
    nvim "+CocInstall -sync coc-python" +qall
fi

if [ "Y$OPT_VIM" == "Yyes" ];then
    nvim "+CocInstall -sync coc-vimlsp" +qall
fi

! which ctags >/dev/null && \
    git clone https://github.com/universal-ctags/ctags.git &&\
    cd ctags && ./autogen.sh && ./configure && make && make install &&\
    cd .. && rm -rf ctags

! ( grep -F "highlight Normal ctermbg=None" ~/.config/nvim/init.vim ) && \
    echo "highlight Normal ctermbg=None" >> ~/.config/nvim/init.vim

! ( grep -F "cus_ini_vim" ~/.config/nvim/init.vim ) && \
    cat tools/neovim/cfg.ini >> ~/.config/nvim/init.vim
! ( grep -F "cus_ini_env" ~/.env ) && \
    cat tools/neovim/env.ini >> ~/.env
[ ! -f /usr/local/bin/genUrl ] &&\
    cp tools/neovim/genUrl.sh /usr/local/bin/genUrl && chmod u+x /usr/local/bin/genUrl
[ ! -d /usr/local/vimsplain ] &&\
    git clone https://github.com/pafcu/vimsplain.git  /usr/local/vimsplain
rm -rf  ~/.gdbinit  && cp tools/neovim/gdbinit ~/.gdbinit


! ( grep -F "defx_my_settings" ~/.config/nvim/init.vim ) && \
cat >> ~/.config/nvim/init.vim <<END
"defx
augroup vimrc_defx
  autocmd!
  autocmd FileType defx call s:defx_my_settings()    "Defx_mappings
augroup END

function! s:defx_my_settings() abort
     " Define mappings
     nnoremap <silent><buffer><expr> <CR>
     \ defx#do_action('open')
     nnoremap <silent><buffer><expr> c
     \ defx#do_action('copy')
     nnoremap <silent><buffer><expr> m
     \ defx#do_action('move')
     nnoremap <silent><buffer><expr> p
     \ defx#do_action('paste')
     nnoremap <silent><buffer><expr> l
     \ defx#do_action('open')
     nnoremap <silent><buffer><expr> E
     \ defx#do_action('open', 'vsplit')
     nnoremap <silent><buffer><expr> P
     \ defx#do_action('open', 'pedit')
     nnoremap <silent><buffer><expr> o
     \ defx#do_action('open_or_close_tree')
     nnoremap <silent><buffer><expr> K
     \ defx#do_action('new_directory')
     nnoremap <silent><buffer><expr> N
     \ defx#do_action('new_file')
     nnoremap <silent><buffer><expr> M
     \ defx#do_action('new_multiple_files')
     nnoremap <silent><buffer><expr> C
     \ defx#do_action('toggle_columns',
     \                'mark:filename:type:size:time')
     nnoremap <silent><buffer><expr> S
     \ defx#do_action('toggle_sort', 'time')
     nnoremap <silent><buffer><expr> d
     \ defx#do_action('remove')
     nnoremap <silent><buffer><expr> r
     \ defx#do_action('rename')
     nnoremap <silent><buffer><expr> !
     \ defx#do_action('execute_command')
     nnoremap <silent><buffer><expr> x
     \ defx#do_action('execute_system')
     nnoremap <silent><buffer><expr> yy
     \ defx#do_action('yank_path')
     nnoremap <silent><buffer><expr> .
     \ defx#do_action('toggle_ignored_files')
     nnoremap <silent><buffer><expr> ;
     \ defx#do_action('repeat')
     nnoremap <silent><buffer><expr> h
     \ defx#do_action('cd', ['..'])
     nnoremap <silent><buffer><expr> ~
     \ defx#do_action('cd')
     nnoremap <silent><buffer><expr> q
     \ defx#do_action('quit')
     nnoremap <silent><buffer><expr> <Space>
     \ defx#do_action('toggle_select') . 'j'
     nnoremap <silent><buffer><expr> *
     \ defx#do_action('toggle_select_all')
     nnoremap <silent><buffer><expr> j
     \ line('.') == line('$') ? 'gg' : 'j'
     nnoremap <silent><buffer><expr> k
     \ line('.') == 1 ? 'G' : 'k'
     nnoremap <silent><buffer><expr> <C-l>
     \ defx#do_action('redraw')
     nnoremap <silent><buffer><expr> <C-g>
     \ defx#do_action('print')
     nnoremap <silent><buffer><expr> cd
     \ defx#do_action('change_vim_cwd')
endfunction
END

if [ "Y$OPT_DICT" == "Yyes" ];then
    ! ( grep -F "QuerySel" ~/.config/nvim/init.vim ) && \
    cat >> ~/.config/nvim/init.vim <<END
    function! QuerySel()
       execute "!sdcv  " . @0
    endfunctio
    nmap  <leader>w :call QuerySel() <CR>
END
fi

#coc setting
! ( grep -F "show_documentation" ~/.config/nvim/init.vim ) && \
cat >> ~/.config/nvim/init.vim <<END
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]

let g:go_def_mapping_enabled = 0

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nmap <leader>rn <Plug>(coc-rename)
END

! (grep -F 'kristijanhusak/defx-icons' ~/.config/nvim/init.vim &>/dev/null ) && \
    sed -i "/plug#begin/aPlug 'kristijanhusak/defx-icons'" ~/.config/nvim/init.vim && \
    sed -i "/plug#begin/aPlug 'kristijanhusak/defx-git'" ~/.config/nvim/init.vim

! (grep -F 'call s:setup_defx' ~/.config/nvim/init.vim &>/dev/null ) && \
    sed -i "/Defx_mappings/a autocmd VimEnter * call s:setup_defx()" ~/.config/nvim/init.vim



! ( grep -F "indent:git:icons:filename" ~/.config/nvim/init.vim ) && \
cat >> ~/.config/nvim/init.vim <<END
    function! s:setup_defx() abort
      call defx#custom#option('_', {
            \ 'columns': s:default_columns,
            \ 'show_ignored_files': 0,
            \ 'buffer_name': '',
            \ 'toggle': 1,
            \ 'resume': 1,
            \ })

      call defx#custom#column('filename', {
            \ 'min_width': 80,
            \ 'max_width': 80,
            \ })
      call s:defx_open()
    endfunction

    function! s:defx_open(...) abort
        sil! au! FileExplorer *
        if s:isdir(expand('%')) | bd | exe 'Defx' | endif
    endfunction

    let s:default_columns = 'indent:git:icons:filename'
END

