set linebreak               " Break lines at word (requires Wrap lines)
set showbreak=→  	 	    " Wrap-broken line prefix

set ignorecase			    " Search is by default ignores letter case
set smartcase			    " Search is case sensitive only if the pattern has UC letters

set tabstop=4
set softtabstop=4		    " Number of spaces per Tab
set shiftwidth=4		    " Number of auto-indent spaces
set expandtab               " Insert spaces instead of tabs

set cursorline

" Remap :w and :q to allow the capital letter versions.
command! Q q
command! W w
command! WQ wq
command! Wq wq

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

" highlight last inserted text
nnoremap gV `[v`]

let mapleader=","           " set mapleader to comma (default: \)

" toggle search highlights
nnoremap <Leader><Leader> :set hlsearch!<cr>

"  quick leader actions
nnoremap <leader>e :edit<space>
nnoremap <leader>f :find<space>
nnoremap <leader>q :q<cr>
nnoremap <leader>s :%s/
nnoremap <leader>w :w!<cr>

" toggle line numbers
nmap <leader>l :set number! relativenumber! <cr>

" toggle between this and previously opened file
nnoremap <C-e> :e#<CR>

colorscheme slate
