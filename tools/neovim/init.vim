call plug#begin('~/.local/share/nvim/plugged')
   Plug 'puremourning/vimspector', { 'dir': '~/.vim/vimspector-config', 'do': './install_gadget.py ' }
   "complete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
    "
    "
    "Plug 'gregsexton/gitv'
    " transform
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    " num rep
    Plug 'glts/vim-magnum'
    Plug 'glts/vim-radical'
    " mru
    Plug 'vim-scripts/mru.vim'
    " select
    Plug 'terryma/vim-expand-region'
    " icon
    Plug 'ryanoasis/vim-devicons'
    "indent
    Plug 'Yggdroot/indentLine'
    "undo
    Plug 'mbbill/undotree'
    Plug 'wellle/targets.vim'
    Plug 'jiangmiao/auto-pairs'
call plug#end()

" our <leader> will be the space key
let mapleader=","
set noswapfile
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" clear highlight
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>
"map K <Plug>(expand_region_expand)
map J <Plug>(expand_region_shrink)
"""""""""""""""""""""""""""""""""""""
" Mappings configurationn
"""""""""""""""""""""""""""""""""""""
map <leader>n :Defx<CR>
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

" for debug
set nu
set list

" exploer
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>e :MRU<CR>

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
  nnoremap <leader>j <c-w>j
  nnoremap <leader>k <c-w>k
  nnoremap <leader>l <c-w>l
endif

" backward
noremap \ ,

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
