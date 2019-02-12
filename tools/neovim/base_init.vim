call plug#begin('~/.local/share/nvim/plugged')
    "outline
    Plug 'majutsushi/tagbar'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " explore
    Plug 'scrooloose/nerdtree'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'vim-scripts/ctags.vim'
    Plug 'tpope/vim-commentary'
    "git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'gregsexton/gitv'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " c
    Plug 'vim-scripts/a.vim'
    " fold
    Plug 'pseewald/vim-anyfold'
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
    Plug 'mg979/vim-visual-multi'
    "nginx
    Plug 'chr4/nginx.vim'
    " icon
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    " tmux
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'junegunn/goyo.vim'
    " auto root
    Plug 'airblade/vim-rooter'
    "indent
    Plug 'Yggdroot/indentLine'
    "undo
    Plug 'mbbill/undotree'

call plug#end()

" our <leader> will be the space key
let mapleader=","

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
map <leader>n :NERDTreeToggle<CR>
map <leader>m :TagbarOpenAutoClose<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen=1

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
    elseif &filetype == 'lua'
        exec "!lua %"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java -cp %:p:h %:t:r"
    endif
endfunc
autocmd VimEnter * noremap  <leader>t  :call RunProgram()<CR>
" ctags
set tags=.tags;  " ; 不可省略，表示若当前目录中不存在tags， 则在父目录中寻找。
nmap <silent> ]s  :call GenCscope() <CR>
func! GenCscope()
    exec "w"
    if &filetype == 'php'
        exec '!find . -name "*.php"  > cscope.files'
        exec "!cscope -bkq -i cscope.files"
        exec "!(cat cscope.files |  ctags -f .tags --languages=php --php-kinds=ctif  --fields=+aimS -L -)"
    elseif &filetype == 'c'
        exec '!find . -name "*.c" -o -name "*.h" > cscope.files'
        exec "!cscope -bkq -i cscope.files"
        exec "!(cat cscope.files | ctags -f .tags --c++-kinds=+p --fields=+iaS --extras=+q -L -)"
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

" fold
let anyfold_fold_comments=1
set foldlevel=10
hi Folded term=NONE cterm=NONE

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

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-/> :TmuxNavigatePrevious<cr>
let g:rooter_patterns = ['.tags', '.git/']
" ydcv
nnoremap tr :let a=expand("<cword>")<Bar>exec '!ydcv ' .a<CR>

autocmd Filetype * AnyFoldActivate
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
