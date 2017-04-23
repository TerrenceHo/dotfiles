" --------------Plugins---------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' "Vundle to download other plugins
Plugin 'L9' " seems to be mandatory for Vundle
Plugin 'vim-scripts/indentpython.vim' "Auto-indent
Plugin 'ajh17/VimCompletesMe' "Tab AutoComplete
Plugin 'tmhedberg/SimpylFold' "Makes Folding Code Better
Plugin 'scrooloose/syntastic' "Checks syntax when called :SyntasticCheck
Plugin 'scrooloose/nerdtree' "Gives you proper file tree when called :NERDTree
Plugin 'scrooloose/nerdtree-git-plugin' "Shows git status on NerdTree
Plugin 'jistr/vim-nerdtree-tabs' "Use tabs for file searching
Plugin 'nvie/vim-flake8' "PEP8 checking for python files
Plugin 'vim-airline/vim-airline' "airline
Plugin 'bling/vim-bufferline' "Shows buffers on airline
Plugin 'tpope/vim-fugitive' "Git wrapper
Plugin 'tpope/vim-commentary' "Comment code easily
Plugin 'christoomey/vim-tmux-navigator' "navigate tmux/vim splits easily
Plugin 'jakedouglas/exuberant-ctags' "generates tags for files
Plugin 'majutsushi/tagbar' "Easily navigate code with tags
Plugin 'Townk/vim-autoclose' "Close out parenthesis
Plugin 'vim-airline/vim-airline-themes' "Themes for airline

call vundle#end()
filetype plugin indent on

" -------------Tabs/Spacing------------------
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

"For HTML/CSS/Javascrip files, indent is 2
"-----------------Web Dev Settings------------
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

"------------------Python Settings------------
" Marks bad whitespace as red, for python
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

"For Virtual Enrivonment Python
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

let python_highlight_all=1


" ---------- Mini WordProcessor -------------
func! WordProcessorMode()
    setlocal textwidth=80
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab 
endfu
com! WP call WordProcessorMode()

" -------------Colors---------------------
syntax on
syntax enable
set background=dark
colorscheme distinguished

" ----------UI Layout---------------------
set number
set showcmd
set cursorline
set showmatch
set wildmenu

" -------------Searching-----------------
set ignorecase
set incsearch
set hlsearch
nmap <silent> ,/ :nohlsearch<CR>

"----------------Copying----------------
if has("clipboard")
    set clipboard=unnamed
endif

set clipboard=unnamed

"---------------Splitting--------------
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"---------------Folding----------------
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

"----------Plugin Settings-------------
" VimCompletesMe
"Sets enter to accept completion
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive' } "Sets syntastic checker to command only
nnoremap <silent> <F8> :SyntasticCheck<CR> 

" NerdTree
map <F9> :NERDTreeToggle<CR>

" Airline
set laststatus=2
set ttimeoutlen=50
let g:airline#extensions#branch#enabled=1

" Tagbar
let g:tagbar_ctags_bin='/usr/local/bin/ctags'  " Proper Ctags locations
let g:tagbar_width=26 "Width for tagbar
let g:tagbar_autoclose = 1
nnoremap <silent> <F10> :TagbarToggle<CR> 

"---------------Other------------------
if has("autocmd") "Opens vim where cursor was last at
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


