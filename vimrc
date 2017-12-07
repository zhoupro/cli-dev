set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" YCM 主要是用于c语言 
Plugin 'Valloric/YouCompleteMe'

" c 语言语法高亮
Plugin 'justinmk/vim-syntax-extra'

" shell漂亮的配色方案
Plugin 'tomasr/molokai'

" 用于写shell脚本
Plugin 'WolfgangMehner/bash-support'

" ctrlp
Plugin 'ctrlpvim/ctrlp.vim'

"代码生成器
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

"outline
"
Plugin 'majutsushi/tagbar'
"底部状态提示
Plugin 'vim-airline/vim-airline'
"change somethings
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-abolish'
"filebrowser
Plugin 'tpope/vim-vinegar'

call vundle#end()            " required
filetype plugin indent on    " required
" 上面为Vundle管理内容
" 指定python处理器，要不然会使用python3,会报错
let g:ycm_server_python_interpreter = '/usr/bin/python'
"YCM的c语言配置
let g:ycm_global_ycm_extra_conf='~/.vim/ycmconf/ycm.c.py'
"全局函数手动触发自动补全
let g:ycm_key_invoke_completion = '<C-a>'
" 语法高亮，配色方案为molokai
syntax on 
colorscheme molokai

" tab 替换为4个空格
set tabstop=4
set shiftwidth=4
set expandtab

let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"outline
"
nmap <F8> :TagbarToggle<CR>
let g:airline#extensions#tabline#enabled = 1

"netrw 配置
let g:netrw_banner = 0
let g:netrw_liststyle = 3
