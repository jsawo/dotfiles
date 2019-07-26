set autoindent			" Auto-indent new lines
set linebreak			" Break lines at word (requires Wrap lines)
set showbreak=+++ 		" Wrap-broken line prefix

set hlsearch			" Highlight all search results
set ignorecase			" Search is by default ignores letter case
set smartcase			" Search is case sensitive only if the pattern has UC letters
set incsearch			" Searches for strings incrementally

set smarttab			" Enable smart-tabs
set tabstop=8
set softtabstop=4		" Number of spaces per Tab
set shiftwidth=4		" Number of auto-indent spaces
set expandtab

set nobackup            " No backups left after done editing
set nowritebackup       " No backups made while editing
set noswapfile          " don't use a swapfile
set history=50          " keep 50 lines of command line history

set mouse=a             " Enable mouse
set showmatch			" Highlight matching brace
set clipboard=unnamed   " Use system clipboard.
set numberwidth=5       " gutter width for line numbers

" configure wildmenu tab completion
set wildmode=list:longest,full
set wildignorecase

set undolevels=1000		" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

" Remap :w and :q to allow the capital letter versions.
command! Q q
command! W w
command! WQ wq
command! Wq wq

colorscheme gruvbox     " color scheme

let mapleader=","       " set mapleader to comma (default: \)
nnoremap ' `            " marks should go to the column, not just the line

" use jk to escape in insert mode but don't wait too long for input
inoremap jk <Esc>
inoremap kj <Esc>
inoremap JK <Esc>
inoremap KJ <Esc>
:autocmd InsertEnter * set timeoutlen=100
:autocmd InsertLeave * set timeoutlen=1000

" move vertically by visual line
nnoremap j gj
nnoremap k gk

nnoremap gV `[v`]       " highlight last inserted text

" toggle search highlights
nnoremap <F3> :set hlsearch!<CR>
nnoremap <Leader><Leader> :set hlsearch!<cr>

nnoremap <leader>e :edit<space>
nnoremap <leader>f :find<space>
nnoremap <leader>q :q<cr>
nnoremap <leader>s :%s/
nnoremap <leader>w :w!<cr>

" :sudow to sudo save file
cnoremap sudow w !sudo tee % >/dev/null

" use <space> to toggle folds
nnoremap <space> za
vnoremap <space> zf

" window bindings
nnoremap <C-w>x <C-w>c
nnoremap <C-w>b <C-w>s
nnoremap <C-w>v <C-w>v
nnoremap <C-w><C-w> <C-w><C-w>

" Super fast window movement shortcuts
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Resize panes when window/terminal gets resize
autocmd VimResized * :wincmd =

" toggle between this and previously opened file
nnoremap <C-e> :e#<CR>

" Use F2 to toggle paste mode
set pastetoggle=<F2>

" Use ,l to toggle line numbers
nnoremap <Leader>l :call ToggleNumber()<cr>

" hide status lines (toggle with S-h)
nnoremap <S-h> :call ToggleHiddenAll()<CR>
let s:hidden_all = 0
set showmode
set ruler
set laststatus=2
set showcmd

" Auto-reload vim config when it changes
if has ('autocmd') " Remain compatible with earlier versions
  augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

" toggle between number, relativenumber and nonumber
function! ToggleNumber() abort
    if(&relativenumber == 1)
        set norelativenumber
        set number
    elseif(&number == 1)
        set nonumber
    else
        set relativenumber
    endif
endfunc

" toggle status lines
function! ToggleHiddenAll() abort
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

" remember cursor position when switching buffers
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Load local configurations if available
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
