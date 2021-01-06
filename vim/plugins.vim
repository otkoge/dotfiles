
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-system-copy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'benmills/vimux'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/indentpython.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'
Plug 'ekalinin/Dockerfile.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'vim-python/python-syntax'
Plug 'tmhedberg/SimpylFold'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'dense-analysis/ale'
call plug#end()
filetype plugin indent on
