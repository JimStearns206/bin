" _vimrc configuration file of Jim Stearns

" (No:Display line numbers on the left:)
""set number

" Or not: display current line number in the ruler line:
set ruler

" Conway recommendation: "watchdog" plugin for status line.

" Change the leave-insert-mode key (default is Esc)
inoremap jk <ESC>

" Remap the leader key from backslash to space key:
let mapleader = "\<Space>"

" Not here, but in OS: consider remapping CAPSLOCK to Cntl.

filetype plugin indent on
syntax on
set encoding=utf-8

" Windows-specific (behavior on Mac/Linux not yet determined):
" Use system clipboard for all yanking/deleting operations
" For more details, see:
" http://stackoverflow.com/questions/11489428/how-to-make-vim-paste-from-and-copy-to-systems-clipboard
set clipboard=unnamed

" Allow cntl-c/cntl-v to be copy/paste on Windows:
" (and does other stuff as well, TBD)
if has('win32')
	source $VIMRUNTIME/mswin.vim
endif

" From Damian Conway O'Reilly "Mastering Vim" video:
" Turn on highlighting in search:
set hlsearch
" To turn off the last search's highlighting, the command is:
" :nohlsearch
" Damiam suggests mapping backspace in normal mode to turn off highlighting:
nmap <silent> <BS> :nohlsearch<CR>

