
let g:system_copy#copy_command = $VIMCLIP

call plug#begin()
Plug 'benmills/vimux'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-system-copy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'psf/black'
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
Plug 'sbdchd/neoformat'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'dense-analysis/ale'
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
set wildignore+=*.png
set wildignore+=*.jpg

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
set foldlevel=99
lua require'nvim-treesitter.configs'.setup { highlight = { enable = true } }


fun! EmptyRegisters()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
        call setreg(r, [])
    endfor
endfun

" VIMux
" let g:VimuxOrientation = "h"
" let g:VimuxHeight = "50"

" Python
let g:python3_host_prog = '~/.venv/nvim/bin/python'
let g:black_linelength = 79
let python_highlight_all = 1                " enable all Python syntax highlighting features
au BufNewFile,BufRead *.py
    \set foldlevel=99
    \set tabstop=4
    \set softtabstop=4
    \set textwidth=79
    \set fileformat=unix
    \set foldmethod=indent
    \match BadWhitespace /\s\+$/
    \set encoding=utf-8

if $VIRTUAL_ENV != ""
    au BufNewFile,BufRead *.py noremap <Leader>py :call VimuxRunCommand($VIRTUAL_ENV . "/bin/python " . bufname("%"))<CR>
else
    au BufNewFile,BufRead *.py noremap <Leader>py :call VimuxRunCommand("python " . bufname("%"))<CR>
endif
autocmd BufWritePre *.py execute ':Black'
let g:black_virtualenv='~/.venv/nvim'

" Go
let g:go_fmt_command = "goimports"          " Autoimport on save
autocmd BufNewFile,BufRead *.go set foldmethod=syntax           " Set folding to syntax if it's a go file
autocmd BufNewFile,BufRead *.go noremap <C-a> :GoAlternate<CR>
" autocmd BufNewFile,BufRead *.go noremap <C-d> :GoDoc<CR> " Go docs
autocmd BufNewFile,BufRead *.go noremap <C-r> :GoRename<CR>
" autocmd BufNewFile,BufRead *.go noremap <C-c> <Plug>(go-coverage-toggle)
autocmd BufNewFile,BufRead *.go noremap <C-i> :GoInfo<CR>
autocmd BufNewFile,BufRead *.go noremap <Leader>t :GoTest<CR>
autocmd BufNewFile,BufRead *.go noremap <Leader>l :GoMetaLinter<CR>
autocmd BufNewFile,BufRead *.go noremap <Leader>f :GoTestFunc<CR>
autocmd BufNewFile,BufRead *.go noremap <Leader>r :GoRun<CR>
autocmd BufNewFile,BufRead *.go map <leader>c  <Plug>(go-coverage-toggle)
autocmd BufNewFile,BufRead *.go map <leader>d  :GoDoc<CR>
autocmd BufNewFile,BufRead *.go nmap <leader>i  <Plug>(go-implements)
autocmd BufNewFile,BufRead *.go nmap <leader>di  <Plug>(go-describe)
autocmd BufNewFile,BufRead *.go nmap <leader>cc  <Plug>(go-callers)
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1

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
map <leader>w :set wrap!<CR>

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

lua require("telescope_config")
nnoremap <leader>dot :lua require("telescope_config").search_dotfiles()<CR>
nnoremap <leader>gc :lua require('telescope_config').git_branches()<CR>
nnoremap <leader>fmt :Neoformat<CR>
nnoremap <leader>fmtj :Neoformat! json<CR>

" Replace highlighed
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" LSP
lua require("lsp")
lua require("compe-config")

nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>sd :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>vi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>sh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>sr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>
" nnoremap <leader>cd :lua vim.lsp.util.show_line_diagnostics(); vim.lsp.util.show_line_diagnostics()<CR>
" nnoremap <leader>gn :lua vim.lsp.diagnostic.goto_next()<CR>


" ALE
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1
let g:ale_linters = {'python': ['flake8', 'pylint']}
let g:ale_fixers = {'*': [], 'python': ['black', 'isort']}
let g:ale_python_black_options="-l 80"
let g:ale_fix_on_save=1
let g:ale_set_highlights=1
let g:ale_set_signs=1
hi StatusLineTerm ctermbg=24 ctermfg=254
" hi ALEError ctermbg=Red ctermfg=Green cterm=underline,bold ctermul=Red
" hi ALEWarning ctermfg=Yellow cterm=underline ctermul=Yellow
" hi ALEInfo cterm=underline 



"python with virtualenv support

py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF
