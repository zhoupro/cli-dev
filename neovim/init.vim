call plug#begin('~/.local/share/nvim/plugged')
    "for php 
    " Include Phpactor
    Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
    " Require ncm2 and this plugin
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'phpactor/ncm2-phpactor'
    Plug 'arnaud-lb/vim-php-namespace'
    Plug 'stephpy/vim-php-cs-fixer'
    Plug 'w0rp/ale'
    "outline
    Plug 'majutsushi/tagbar'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " explore 
    Plug 'scrooloose/nerdtree'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'vim-scripts/mru.vim'
    Plug 'mileszs/ack.vim'
    Plug 'vim-scripts/ctags.vim'
    Plug 'tpope/vim-commentary'
    "git 
    Plug 'tpope/vim-fugitive'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'mhinz/vim-signify'
    " go
    Plug 'fatih/vim-go'
    Plug 'ncm2/ncm2-go'
    " debug 
    Plug 'sakhnik/nvim-gdb'
    Plug 'vim-vdebug/vdebug'
    Plug 'sebdah/vim-delve'
    " c
    Plug 'vim-scripts/a.vim'
    " c 语言语法高亮
    Plug 'justinmk/vim-syntax-extra'
    Plug 'Valloric/YouCompleteMe'
    " fold
    Plug 'pseewald/vim-anyfold'
    " transform
    Plug 'tpope/vim-abolish'
    " snips
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    " themes
    Plug 'joshdick/onedark.vim'
call plug#end()

" our <leader> will be the space key
let mapleader=","

" search
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" clear highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>


" tab 替换为4个空格
set tabstop=4
set shiftwidth=4
set expandtab
"""""""""""""""""""""""""""""""""""""
" Mappings configurationn
"""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
map <C-m> :TagbarToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" vim-php-namespace
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

" ale-setting {{{
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"打开文件时不进行检查
let g:ale_lint_on_enter = 0
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
let g:ale_linters = {
\   'php': ['phpcs','phpmd'],
\   'sh': ['shellcheck'],
\}
let g:ale_php_phpcs_standard = 'psr2'
" }}}

 " ack
 " Ack -> Ag
 if executable('ag')
   let g:ackprg = 'ag --vimgrep'
 endif

 autocmd FileType php nnoremap <c-]> :call phpactor#GotoDefinition()<CR>


"----------------------------------------------
" Language: Golang
"----------------------------------------------
" Run goimports when running gofmt
let g:go_fmt_command = "goimports"
let g:go_version_warning = 0


let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1


func! RunProgram()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "! ./%<"
    elseif &filetype == 'sh'
        exec "!bash %"
    elseif &filetype == 'go'
        exec "!go run %"
    elseif &filetype == 'python'
        exec "!python %"
    elseif &filetype == 'php'
        exec "!php %"
    endif
endfunc
autocmd VimEnter * noremap  <leader>t  :call RunProgram()<CR>

" ctags
set tags=tags;  " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。

nmap <silent> ]s  :call GenCscope() <CR>
func! GenCscope()
    exec "w"
    if &filetype == 'php'
        exec '!find . -name "*.php"  > cscope.files'
        exec "!cscope -bkq -i cscope.files"
        exec "!ctags -R --languages=php --php-kinds=ctif  --fields=+aimS ."
    elseif &filetype == 'c'
        exec '!find . -name "*.c" -o -name "*.h" > cscope.files'
        exec "!cscope -bkq -i cscope.files"
        exec "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
endfunc

if has("cscope")
    set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
    " check cscope for definition of a symbol before checking ctags:
    " set to 1 if you want the reverse search order.
     set csto=1

     " add any cscope database in current directory
     if filereadable("cscope.out")
         slient cs add cscope.out
     " else add the database pointed to by environment variable
     elseif $CSCOPE_DB !=""
         slient cs add $CSCOPE_DB
     endif

     " show msg when any other cscope db added
     set cscopeverbose

     nmap [s :cs find s <C-R>=expand("<cword>")<CR><CR>
     nmap [g :cs find g <C-R>=expand("<cword>")<CR><CR>
     nmap [c :cs find c <C-R>=expand("<cword>")<CR><CR>
     nmap [t :cs find t <C-R>=expand("<cword>")<CR><CR>
     nmap [e :cs find e <C-R>=expand("<cword>")<CR><CR>
     nmap [f :cs find f <C-R>=expand("<cfile>")<CR><CR>
     nmap [i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
     nmap [d :cs find d <C-R>=expand("<cword>")<CR><CR>
 endif

function! s:completeFileTypeOpt()
        if &filetype == 'c'
            let mock_test = 1
        else
            " ncm2
            autocmd BufEnter * call ncm2#enable_for_buffer()
            set completeopt=noinsert,menuone,noselect
        endif
endfunc
autocmd VimEnter * call s:completeFileTypeOpt()

set background=dark

let g:ycm_global_ycm_extra_conf='~/.config/nvim/ycm.c.py'
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_key_invoke_completion = '<C-a>'

" fold
let anyfold_activate=1
let anyfold_fold_comments=1
set foldlevel=10
hi Folded term=NONE cterm=NONE


" for debug
set nu
set list

" exploer
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>e :MRU<CR><Paste>

" PHP debug
let g:vdebug_options= {
    \    "port" : 9010,
    \    "server" : '0.0.0.0',
    \    "timeout" : 100,
    \    "on_close" : 'detach',
    \    "break_on_open" : 1,
    \    "ide_key" : 'xdebug',
    \    "path_maps" : {},
    \    "debug_window_level" : 0,
    \    "debug_file_level" : 0,
    \    "debug_file" : "",
    \    "watch_window_style" : 'expanded',
    \    "marker_default" : '⬦',
    \    "marker_closed_tree" : '▸',
    \    "marker_open_tree" : '▾'
    \}
highlight DbgBreakptLine ctermbg=none ctermfg=none
highlight DbgBreakptSign ctermbg=none ctermfg=10
highlight DbgCurrentLine ctermbg=none ctermfg=none
highlight DbgCurrentSign ctermbg=none ctermfg=red
" Vim-php-cs-fixer
" If you use php-cs-fixer version 2.x
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
" snips
" UltiSnips 的 tab 键与 YCM 冲突，重新设定
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"
nnoremap <leader>y :call system('nc -q 1 host.docker.internal 8377', @0)<CR>
nnoremap <leader>d :call fzf#vim#tags('^' . expand('<cword>'), {'options': '--exact --select-1 --exit-0 +i'})<CR>

if has("termguicolors")
    " enable true color
    set termguicolors
else
    " color change fix in tmux
    set t_Co=256
endif
