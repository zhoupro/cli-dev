call plug#begin('~/.local/share/nvim/plugged')
    "outline
    Plug 'majutsushi/tagbar'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " explore
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'vim-scripts/ctags.vim'
    Plug 'tpope/vim-commentary'
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
    "git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'gregsexton/gitv'
    " c
    Plug 'vim-scripts/a.vim'
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
    Plug 'terryma/vim-multiple-cursors'
    "nginx
    Plug 'chr4/nginx.vim'
    " icon
    Plug 'ryanoasis/vim-devicons'
    " tmux
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'junegunn/goyo.vim'
    "indent
    Plug 'Yggdroot/indentLine'
    "undo
    Plug 'mbbill/undotree'
    "markdown
    " have nodejs and yarn
    Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
    Plug 'wellle/targets.vim'
    Plug 'forevernull/vim-json-format'
    Plug 'paroxayte/vwm.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'iandingx/leetcode.vim'

call plug#end()

" our <leader> will be the space key
let mapleader=","
set noswapfile
map <leader>js :call json_format#parse("l")<cr>
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
map <leader>n :Defx -resume<CR>
map <leader>m :TagbarOpenAutoClose<CR>

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
    elseif &filetype == 'c'
        exec '!find . -name "*.c" -o -name "*.h" > cscope.files'
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


" for debug
set nu
set list

" exploer
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>e :MRU<CR>

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

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-/> :TmuxNavigatePrevious<cr>

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
"defx config
call defx#custom#column('size','')
call defx#custom#column('filename', {
    \ 'directory_icon': '▸',
    \ 'opened_icon': '▾',
    \ 'root_icon': ' ',
    \ 'min_width': 30,
    \ 'max_width': 30,
    \ })
call defx#custom#column('mark', {
    \ 'readonly_icon': '',
    \ 'selected_icon': '',
    \ })
call defx#custom#option('_',{
    \ 'columns'   : 'git:mark:filename:icons',
    \ 'show_ignored_files': 0,
    \ 'buffer_name': '',
    \ 'toggle': 1,
    \ 'resume': 1,
    \ })
"defx-git config
let g:defx_git#indicators = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?',
  \ }

let g:defx_git#column_length = 1
let g:defx_git#raw_mode = 1
" defx-icons config
let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 2
let g:defx_icons_directory_icon = ''
let g:defx_icons_mark_icon = '*'
let g:defx_icons_parent_icon = ''
let g:defx_icons_default_icon = ''
let g:defx_icons_directory_symlink_icon = ''
" Options below are applicable only when using "tree" feature
let g:defx_icons_root_opened_tree_icon = ''
let g:defx_icons_nested_opened_tree_icon = ''
let g:defx_icons_nested_closed_tree_icon = ''


autocmd FileType defx call s:defx_my_settings()
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
augroup defx
    au!
    au VimEnter * sil! au! FileExplorer *
    au BufEnter * if s:isdir(expand('%')) | bd | exe 'Defx' | endif
augroup END

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
