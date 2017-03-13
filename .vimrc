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
"for js/html/css files, indent is 2
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
" Marks bad whitespace as red, for python
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set encoding=utf-8


" ---------- Mini WordProcessor -------------
func! WordProcessorMode()
    setlocal textwidth=80
    setlocal smartindent
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfu
com! WP call WordProcessorMode()

" --------------Plugins---------------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'L9'
call vundle#end()
filetype plugin indent on

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

"----------------Copying----------------
if has("clipboard")
    set clipboard=unnamed
endif

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
