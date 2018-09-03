call plug#begin('~/.local/share/nvim/plugged')
    "for php 
    " Include Phpactor
    Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
    " Require ncm2 and this plugin
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'phpactor/ncm2-phpactor'
    Plug 'arnaud-lb/vim-php-namespace'
    Plug 'vim-syntastic/syntastic'
    "outline
    Plug 'majutsushi/tagbar'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " explore 
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'mileszs/ack.vim'
    Plug 'vim-scripts/ctags.vim'
    "git 
    Plug 'tpope/vim-fugitive'
    Plug 'scrooloose/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

"""""""""""""""""""""""""""""""""""""
" Mappings configurationn
"""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
map <C-m> :TagbarToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


" ncm2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" vim-php-namespace
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" Syntastic configuration
 set statusline+=%#warningmsg#
 set statusline+=%{SyntasticStatuslineFlag()}
 set statusline+=%*
 let g:syntastic_check_on_open = 1
 let g:syntastic_check_on_wq = 0

 " Syntastic configuration for PHP
 let g:syntastic_php_checkers = ['php', 'phpmd', 'phpcs']
 let g:syntastic_php_phpmd_exec = 'phpmd'
 let g:syntastic_php_phpcs_exec = 'phpcs'
 let g:syntastic_php_phpcs_args = '--standard=psr2'
 let g:syntastic_php_phpmd_post_args = 'cleancode,codesize,controversial,design,unusedcode'

 " ack
 " Ack -> Ag
 if executable('ag')
   let g:ackprg = 'ag --vimgrep'
 endif

 autocmd FileType php nnoremap <c-]> :call phpactor#GotoDefinition()<CR>

 " ctrlp
let g:ctrlp_regexp=1
let g:ctrlp_cmd='CtrlP :pwd'
