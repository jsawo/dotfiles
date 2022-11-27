" https://neovim.io/doc/user/options.html

"---------------------------------------------------------------
" General settings
"---------------------------------------------------------------

colorscheme slate

set expandtab                       " Insert spaces instead of tabs
set softtabstop=4                   " Number of spaces per Tab
set shiftwidth=4                    " Number of auto-indent spaces

set linebreak                       " Break lines at word (requires Wrap lines)
set showbreak=→                     " Wrap-broken line prefix

set ignorecase                      " Search is by default ignores letter case
set smartcase                       " Search is case sensitive only if the pattern has UC letters

set signcolumn=yes:2                " Add gutter column
set relativenumber                  " Use relative line numbers
set number                          " Display absolute line number on the current line only

set termguicolors                   " Enable 24-bit RGB color

set spell                           " Enable spell checking

set wildmode=longest:full,full      " Completion mode for vim commands

set list                            " Enable showing non-printable character
set listchars=tab:▷\ ,trail:·       " Show only tabs and trailing space

set scrolloff=8                     " Start scrolling before cursor reaches window border
set sidescrolloff=8

set clipboard=unnamedplus           " Use system clipboard

set mouse=a                         " Use mouse everywhere

set confirm                         " Use confirm dialog instead of failing certain commands (like saving)

"---------------------------------------------------------------
" Key maps
"---------------------------------------------------------------

" use space as leader (default: \)
let mapleader = "\<space>"

nnoremap <Leader>vr :source $MYVIMRC<cr>                     " quickly reload nvim config
nnoremap <Leader>ve :edit ~/.config/nvim/init.vim<cr>        " edit nvim config

nnoremap <Leader><Leader> :nohlsearch<cr>                    " clear search highlights

nnoremap <Leader>Q :bufdo bdelete<cr>                        " close all buffers

map gf :edit <cfile><cr>                                     " Allow gf to open non-existent files

" Quicker switching between windows
nmap <silent> <C-h> <C-w>h
nmap <silent> <C-j> <C-w>j
nmap <silent> <C-k> <C-w>k
nmap <silent> <C-l> <C-w>l

" Reselect visual selection after indenting
vnoremap < <gv
vnoremap > >gv

" Maintain cursor position when yanking a visual selection
vnoremap y myy`y
vnoremap Y myy`y

" Paste replace visual selection without copying it
vnoremap <leader>p "_dP

" Make Y behave like other capitals
nnoremap Y y$

" Keep things centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Open the current file in the default program
nmap <leader>x :!xdg-open %<cr><cr>

" Quickly escape to normal mode
imap jj <esc>

" Easy insertion of a trailing ; or , from insert mode
imap ;; <esc>A;<Esc>
imap ,, <esc>A,<Esc>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" toggle line numbers
nmap <leader>l :set number! relativenumber! <cr>

" Remap :w and :q to allow the capital letter versions.
command! Q q
command! W w
command! WQ wq
command! Wq wq


