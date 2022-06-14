" colorscheme desert
" colorscheme delek
colorscheme elflord
set nohlsearch!
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
" set noswapfile
set directory^=/tmp/.vim//
set nobackup
set wildmenu
set number
set rnu
" set directory=$HOME/temp//
" set backupdir=$HOME/tmep//
" set undodir=$HOME/temp//

" environment variables
let $RTP=split(&runtimepath, ',')[0]
let $RC="$HOME/.vim/vimrc"

"Custom mapping
nnoremap ; :
vnoremap ; :
" nnoremap : ;

" pagination configuration
" set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent
set shiftwidth=4 tabstop=4 softtabstop=4

" plugin section
call plug#begin()

" A bunch of useful language related snippets (ultisnips is the engine)
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'OmniSharp/omnisharp-vim'
    Plug 'dense-analysis/ale'
    " Coc.nvim autocomplete
    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " Debug
    Plug 'puremourning/vimspector'

call plug#end()

source /home/sofoca/.vim/configs/shorcuts.vim
source /home/sofoca/.vim/configs/Cocnvim.vim
source /home/sofoca/.vim/configs/omnisharp.vim
source /home/sofoca/.vim/plugins/mssql/db_connections.vim
