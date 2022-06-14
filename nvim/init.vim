set nohlsearch!
set wildignore=**/node_modules/**
set wildignore+=**/bin/**
set wildignore+=**/dist/**
set wildignore+=**/obj/**
set completeopt-=preview
filetype plugin indent on
set foldmethod=indent
syntax on
set showbreak=↪\ 
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•
set backspace=indent,eol,start
set list
set showcmd
set nowrap
set hidden
set laststatus=2
set path=.,**
set directory^=/home/sofoca/.vim/tmp//
set nobackup
set wildmenu
set rnu
set clipboard+=unnamedplus

" environment variables
let $RTP=split(&runtimepath, ',')[0]
let $RC="$HOME/.config/nvim/init.vim"

"Custom mapping
nnoremap ; :
vnoremap ; :

" pagination configuration
set shiftwidth=4 tabstop=4 softtabstop=4 autoindent

" source /home/sofoca/.vim/configs/shorcuts.vim
" source /home/sofoca/.vim/configs/Cocnvim.vim
" source /home/sofoca/.vim/configs/omnisharp.vim
source /home/sofoca/.vim/plugins/mssql/db_connections.vim
lua require('plugins')
lua require('config')
