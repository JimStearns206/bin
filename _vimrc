" _vimrc configuration file of Jim Stearns

" Display line numbers on the left:
set number

" Change the leave-insert-mode key (default is Esc)
inoremap jk <ESC>

" Remap the leader key from backslash to space key:
let mapleader = "\<Space>"

" Not here, but consider remapping CAPSLOCK to Cntl.

filetype plugin indent on
syntax on
set encoding=utf-8

" Windows-specific (behavior on Mac/Linux not yet determined):
" Use system clipboard for all yanking/deleting operations
" For more details, see:
" http://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
set clipboard=unnamed

