call plug#begin('~/.local/share/nvim/plugged')
    Plug 'w0rp/ale'
    "complete
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    "outline
    Plug 'majutsushi/tagbar'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " explore
    if has('nvim')
      Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
    else
      Plug 'Shougo/defx.nvim'
      Plug 'roxma/nvim-yarp'
      Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug 'kristijanhusak/defx-icons'
    Plug 'kristijanhusak/defx-git'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'vim-scripts/ctags.vim'
    Plug 'tpope/vim-commentary'
    "git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'gregsexton/gitv'
    " transform
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    " snips
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    " themes
    Plug 'joshdick/onedark.vim'
    " 语言语法高亮
    Plug 'sheerun/vim-polyglot'
    " num rep
    Plug 'glts/vim-magnum'
    Plug 'glts/vim-radical'
    " mru
    Plug 'vim-scripts/mru.vim'
    " start screen
    Plug 'mhinz/vim-startify'
    " add header
    Plug 'alpertuna/vim-header'
    " select
    Plug 'terryma/vim-expand-region'
    "nginx
    Plug 'chr4/nginx.vim'
    " icon
    Plug 'ryanoasis/vim-devicons'
    " tmux
    Plug 'christoomey/vim-tmux-navigator'
    " emmet
    Plug 'mattn/emmet-vim'
    "indent
    Plug 'Yggdroot/indentLine'
    "undo
    Plug 'mbbill/undotree'
    Plug 'wellle/targets.vim'
    Plug 'forevernull/vim-json-format'
    Plug 'paroxayte/vwm.vim'
    Plug 'jiangmiao/auto-pairs'
call plug#end()

" our <leader> will be the space key
let mapleader=","
set noswapfile
map <leader>js :call json_format#parse("l")<cr>
let g:deoplete#enable_at_startup = 1
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']
"lua
let g:lua_check_syntax = 0
let g:lua_complete_omni = 1
let g:lua_complete_dynamic = 0
let g:lua_define_completion_mappings = 0

autocmd FileType lua call deoplete#custom#var('omni', 'functions', {
\ 'lua': 'xolox#lua#omnifunc',
\ })

"words
"call deoplete#custom#source('ultisnips', 'rank', 1000)
"set dictionary=/usr/share/dict/words
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" clear highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)
"""""""""""""""""""""""""""""""""""""
" Mappings configurationn
"""""""""""""""""""""""""""""""""""""
map <leader>n :Defx -toggle<CR>
map <leader>m :TagbarOpenAutoClose<CR>

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
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'sh'
        exec "!bash %"
    elseif &filetype == 'go'
        exec "!go run %"
    elseif &filetype == 'python'
        exec "!python %"
    elseif &filetype == 'php'
        exec "!php %"
    elseif &filetype == 'lua'
        exec "!lua %"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java -cp %:p:h %:t:r"
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
        exec "!(cat cscope.files |  ctags -f tags --languages=php --php-kinds=ctif  --fields=+aimS -L -)"
    elseif &filetype == 'c' || &filetype == 'cpp' || &filetype == 'h' || &filetype  == 'cc' || &filetype == 'c++'
        exec '!find . -name "*.c" -o -name "*.h" -o -name "*.cpp" -o -name "*.cc" -o -name "*.c++" > cscope.files'
        exec "!cscope -bkq -i cscope.files"
        exec "!(cat cscope.files | ctags -f tags --c++-kinds=+p --fields=+iaS --extras=+q -L -)"
    endif
endfunc

if has("cscope")
    set cscopetag   " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳来跳去
    " check cscope for definition of a symbol before checking ctags:
    " set to 1 if you want the reverse search order.
     set csto=1
     nmap [s :cs find s <C-R>=expand("<cword>")<CR><CR>
     nmap [g :cs find g <C-R>=expand("<cword>")<CR><CR>
     nmap [c :cs find c <C-R>=expand("<cword>")<CR><CR>
     nmap [t :cs find t <C-R>=expand("<cword>")<CR><CR>
     nmap [e :cs find e <C-R>=expand("<cword>")<CR><CR>
     nmap [f :cs find f <C-R>=expand("<cfile>")<CR><CR>
     nmap [i :cs find i <C-R>=expand("<cfile>")<CR>$<CR>
     nmap [d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
" Autoloading Cscope Database
function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  " else add the database pointed to by environment variable 
  elseif $CSCOPE_DB != "" 
    cs add $CSCOPE_DB
  endif
endfunction
au BufEnter /* call LoadCscope()

set background=dark

let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_key_invoke_completion = '<C-a>'
let g:ycm_global_ycm_extra_conf='~/.config/nvim/ycm.cpp.py'
autocmd FileType c  let g:ycm_global_ycm_extra_conf='~/.config/nvim/ycm.c.py'
autocmd FileType cpp let g:ycm_global_ycm_extra_conf='~/.config/nvim/ycm.cpp.py'

" for debug
set nu
set list

" exploer
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>e :MRU<CR>

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
nnoremap <leader>y :call system('NCCOMMAND  NCHOST 8377', @0)<CR>
nnoremap <leader>] :call fzf#vim#tags('^' . expand('<cword>'), {'options': '--exact --select-1 --exit-0 +i'})<CR>

" color change fix in tmux
set t_Co=256
"switch windows
if has('nvim')
  " Terminal mode:
  tnoremap <leader>h <c-\><c-n><c-w>h
  tnoremap <leader>j <c-\><c-n><c-w>j
  tnoremap <leader>k <c-\><c-n><c-w>k
  tnoremap <leader>l <c-\><c-n><c-w>l
  " Insert mode:
  inoremap <leader>h <Esc><c-w>h
  inoremap <leader>j <Esc><c-w>j
  inoremap <leader>k <Esc><c-w>k
  inoremap <leader>l <Esc><c-w>l
  " Visual mode:
  vnoremap <leader>h <Esc><c-w>h
  vnoremap <leader>j <Esc><c-w>j
  vnoremap <leader>k <Esc><c-w>k
  vnoremap <leader>l <Esc><c-w>l
  " Normal mode:
  nnoremap <leader>h <c-w>h
  nnoremap <leader>j <c-w>ji
  nnoremap <leader>k <c-w>k
  nnoremap <leader>l <c-w>l
endif
set scrolloff=5
let g:header_auto_add_header = 0

let g:ycm_show_diagnostics_ui = 0

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-/> :TmuxNavigatePrevious<cr>
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" backward
noremap \ ,
let g:polyglot_disabled = ['markdown']

" buf tab
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#fnametruncate = 16
let g:airline#extensions#tabline#fnamecollapse = 2
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --ignore-file ~/.fzf_ignore --no-heading --color=always '.<q-args>, 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <silent> <Leader>a :Rg <C-R><C-W><CR>
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
" tab 替换为4个空格
set tabstop=4
set shiftwidth=4
set expandtab

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
        \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
" add current file to ignore file
command Gg call system('echo '.expand("%"). '>> .git/info/exclude')
" remove current file from ignore file
command Gr call system('sed  -i "s#'.expand("%").'##g"  .git/info/exclude')

fu! s:isdir(dir) abort
    return !empty(a:dir) && (isdirectory(a:dir) ||
             \ (!empty($SYSTEMDRIVE) && isdirectory('/'.tolower($SYSTEMDRIVE[0]).a:dir)))
endfu
set foldmethod=manual

let s:bot = {
\ 'name': 'bot',
\ 'set_all': ['nonu', 'nornu'],
\ 'bot':
\ {
\ 'h_sz': 12,
\ 'init': [ 'term zsh' ]
\ }
\ }

let g:vwm#layouts = [s:bot]
"https://github.com/Shougo/deoplete.nvim/issues/440
let g:deoplete#auto_complete_delay = 150

" clang_format
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>
