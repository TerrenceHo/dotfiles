set nocompatible
let mapleader = ";"

let g:python2_host_prog = '/usr/local/Cellar/python@2/2.7.15_1/bin/python'  
let g:python3_host_prog = '/usr/local/Cellar/python@3.9/3.9.6/bin/python3'

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ----- Plugins -----
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-easy-align' "Easy alignment of text
Plug 'tpope/vim-repeat' 
Plug 'tpope/vim-surround' " Surround text
Plug 'tpope/vim-commentary' "Comment code easily

" Visual
Plug 'Lokaltog/vim-distinguished' "distinguished color scheme
Plug 'vim-airline/vim-airline' "airline
Plug 'bling/vim-bufferline' "Shows buffers on airline
Plug 'vim-airline/vim-airline-themes' "Themes for airline
Plug 'scrooloose/nerdtree' "Gives you proper file tree when called :NERDTre
Plug 'scrooloose/nerdtree-git-plugin' "Shows git status on NerdTree

Plug 'junegunn/fzf.vim' "Fuzzy Search

" AutoComplete
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
" Plug 'liuchengxu/vista.vim' " Tagbar for LSP

Plug 'fatih/vim-go', {'do': ':GoInstallBinaries' } "Go Plugin
Plug 'rust-lang/rust.vim' "Rust Plugin
Plug 'psf/black', {'branch': 'stable' } "Python Formatting
Plug 'Vimjas/vim-python-pep8-indent' " Python indentation
Plug 'alx741/vim-hindent' "Haskell Formatting
Plug 'hashivim/vim-terraform' " Terraform formatting
Plug 'cespare/vim-toml' " Toml formatting

" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

" Writing
Plug 'vimwiki/vimwiki' "Vim wiki
Plug 'junegunn/goyo.vim' "Distraction free writing
Plug 'junegunn/limelight.vim' "Highlights current line

" Tmux Integration
Plug 'christoomey/vim-tmux-navigator' "navigate tmux/vim splits easily

call plug#end()

" ----- Tabs/Spacing -----
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.
set shiftwidth=4    " Indents will have a width of 4
set softtabstop=4   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set autoindent 
set textwidth=80
set fileformat=unix
set backspace=indent,eol,start

" ----- UI -----
filetype plugin indent on
syntax on
set lazyredraw
set hidden
set updatetime=500
set relativenumber
set number
set showcmd
" set cursorline
set showmatch
set wildmenu
set cmdheight=2

" Make vim resize when host is resized
:autocmd VimResized * wincmd =

" ----- Splits -----
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ----- Copying -----
set clipboard=unnamed
set pastetoggle=<F2>

" ----- Searching -----
set ignorecase
set incsearch
set hlsearch
" nmap <silent> ,/ :nohlsearch<CR>

" ----- Folding -----
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" ----- Brackets -----
inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O<tab>
inoremap (<cr> (<cr>)<c-o>O

" ----- Keybindings -----
nnoremap <leader>t :NERDTreeToggle<CR>

nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>d :bd<CR>

nnoremap <leader>s :w<CR>
nnoremap <leader>l :nohlsearch<CR>
nnoremap <C-C> <C-A>

" ----- Last Position -----
function! PositionCursonFromViminfo()
    if !(bufname("%") =~ '\(COMMIT_EDITMSG\)') && line("'\"") > 1 && line("'\"") <= line("$") 
        exe "normal! g`\"" 
    endif
endfunction
au BufReadPost * call PositionCursonFromViminfo()

" ----- Colors -----
let g:solarized_termcolors=256 "needed for solarzied
syntax on
syntax enable
colorscheme distinguished "Color scheme
set background=dark

" ----- File Types -----
" Git Commits
au FileType gitcommit set tw=72

" Makefiles
autocmd BufEnter ?makefile* set include^s\=include
autocmd BufLeave ?makefile* set include&

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" ----- Airline -----
set laststatus=2
set ttimeoutlen=50
let g:airline#extensions#branch#enabled=1

" ----- Language Client -----
let g:LanguageClient_serverCommands = {
  \ 'go': ['gopls'],
  \ 'rust': ['rls'],
  \ 'python': ['/usr/local/bin/pyls'],
  \ 'haskell': ['hie-wrapper', '--lsp'],
  \ }
nnoremap <leader>r :call LanguageClient_contextMenu()<CR>

" ----- Deoplete -----
let g:deoplete#enable_at_startup = 1
imap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<tab>"
imap <expr> <cr>    pumvisible() ? deoplete#close_popup() : "\<cr>"
inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
" let g:deoplete#enable_camel_case = 1
" set completeopt+=noinsert
" set completeopt+=noselect
" set completeopt-=preview

" ----- Echodoc -----
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" ----- Vista -----
let g:vista_executive_for = {
  \ 'go': 'lcn',
  \ }
nnoremap <leader>v :Vista!!<CR>

" ----- Vim-Go -----
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

" ----- Rust -----
let g:rustfmt_autosave = 1

" ----- Black -----
autocmd BufWritePre *.py execute ':Black'

" ----- codefmt -----
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType proto AutoFormatBuffer clang-format
augroup END


" ----- Vim Wiki -----
let wiki_1 = {}
let wiki_1.path = '~/vimwiki_personal/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let g:vimwiki_list = [wiki_1]
" let g:vimwiki_ext2syntax = {'.md':'markdown', '.markdown':'markdown',  'mdown':'markdown'}

" ----- fzf -----
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'down': '40%' }

" ----- Easy Align -----
xmap ga <Plug>(EasyAlign)
