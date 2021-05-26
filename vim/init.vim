
let g:system_copy#copy_command = $VIMCLIP

call plug#begin()
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-system-copy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'ambv/black'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'tmhedberg/SimpylFold'
call plug#end()

colo gruvbox
set background=dark

" Allowing search with :find
set path+=**                                " Files from all subfolders will tabcomplete
set wildmenu                                " Display all matching file when tabcomplete
set wildmode=longest,list,full		    " 
" Ignore files
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=**/.git/*

set autoread                                " Auto reload changed files
set laststatus=2                            " status bar at the bottom
set t_Co=256                                " Color settings
syntax enable                               " syntax highligh
set number                                  " show line numbers
set relativenumber                          " relative numbers are shown
set ts=4                                    " set tabs to have 4 spaces
set autoindent                              " indent when moving to the next line while writing code
set expandtab                               " expand tabs into spaces
set shiftwidth=4                            " when using the >> or << commands, shift lines by 4 spaces
set cursorline                              " show a visual line under the cursor's current line
set splitright                              " Open new splits to the right
set splitbelow                              " Open new splits to the bottom
set history=1000                            " Set remembered lines
set hlsearch                                " Highligh searches
set incsearch                               " Show search results as you type
set timeoutlen=1000 ttimeoutlen=0           " Remove timeout when hitting escape
set list                                    " show whitespaces as characters
set listchars=tab:>-,eol:$,space:.,trail:x  " Whitespace and matching char
" set backspace=indent,eol,start              " http://vi.stackexchange.com/a/2163


fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

" Shortcuts
" quite all with leader q
map <Leader>q :qall<CR>                     " Quit all with Leader+q
nnoremap <C-h> <C-w>h                       " Moving between panes on split screen
nnoremap <C-j> <C-w>j                       " Moving between panes on split screen
nnoremap <C-k> <C-w>k                       " Moving between panes on split screen
nnoremap <C-l> <C-w>l                       " Moving between panes on split screen
nnoremap <space> za                         " fold with space
noremap <Leader>x :call VimuxCloseRunner()<CR>
" Copy to unnamed register
noremap <Leader>d "_
" Toogle NerdTree
map <C-n> :NERDTreeToggle<CR>

" Get off my lawn - helpful when learning Vim :)
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

source ~/.config/nvim/statusline.vim

" init.vim
let g:symbols_outline = {
    \ "highlight_hovered_item": v:true,
    \ "show_guides": v:true,
    \ "position": 'right',
    \ "auto_preview": v:false,
    \ "keymaps": {
        \ "close": "<Esc>",
        \ "goto_location": "<Cr>",
        \ "focus_location": "o",
        \ "hover_symbol": "<C-space>",
        \ "rename_symbol": "r",
        \ "code_actions": "a",
    \ },
    \ "lsp_blacklist": [],
\ }


