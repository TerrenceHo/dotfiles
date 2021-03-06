" --------------Plugins---------------------
set nocompatible
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe' "AutoComplete server
Plug 'scrooloose/nerdtree' "Gives you proper file tree when called :NERDTre
Plug 'scrooloose/nerdtree-git-plugin' "Shows git status on NerdTree
Plug 'jistr/vim-nerdtree-tabs' "Use tabs for file searching
Plug 'vim-airline/vim-airline' "airline
Plug 'bling/vim-bufferline' "Shows buffers on airline
Plug 'vim-airline/vim-airline-themes' "Themes for airline
Plug 'tpope/vim-fugitive' "Git wrapper
Plug 'tpope/vim-commentary' "Comment code easily
Plug 'tpope/vim-surround' "Tool to surround text with certain characters
Plug 'christoomey/vim-tmux-navigator' "navigate tmux/vim splits easily
Plug 'majutsushi/tagbar' "Easily navigate code with tags
Plug 'lervag/vimtex', {'for':'markdown'} "vim support for latex documents
Plug 'fatih/vim-go'  "Plugin For Go builds
Plug 'vimwiki/vimwiki' "Vim wiki
Plug '/usr/local/opt/fzf' "fzf binary
Plug 'junegunn/fzf.vim' "fzf-vim
call plug#end()

" filetype off
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" Plugin 'VundleVim/Vundle.vim' "Vundle to download other plugins
" Plugin 'L9' " seems to be mandatory for Vundle
" Plugin 'Valloric/YouCompleteMe' "AutoComplete server
" Plugin 'scrooloose/syntastic' "Checks syntax when called :SyntasticCheck
" Plugin 'scrooloose/nerdtree' "Gives you proper file tree when called :NERDTree
" Plugin 'scrooloose/nerdtree-git-plugin' "Shows git status on NerdTree
" Plugin 'jistr/vim-nerdtree-tabs' "Use tabs for file searching
" Plugin 'vim-airline/vim-airline' "airline
" Plugin 'bling/vim-bufferline' "Shows buffers on airline
" Plugin 'vim-airline/vim-airline-themes' "Themes for airline
" Plugin 'tpope/vim-fugitive' "Git wrapper
" Plugin 'tpope/vim-commentary' "Comment code easily
" Plugin 'christoomey/vim-tmux-navigator' "navigate tmux/vim splits easily
" Plugin 'majutsushi/tagbar' "Easily navigate code with tags
" Plugin 'lervag/vimtex', {'for':'markdown'} "vim support for latex documents
" Plugin 'fatih/vim-go'  "Plugin For Go builds
" Plugin 'vimwiki/vimwiki' "Vim wiki
" " Plugin '/usr/local/bin/fzf' "fzf binary
" Plugin 'junegunn/fzf.vim' "fzf-vim
" " Plugin 'python-mode/python-mode' "Plugin for python
" " Plugin 'tmhedberg/SimpylFold' "Makes Folding Code Better for Python
" " Plugin 'vim-scripts/indentpython.vim' "Auto-indent
" " Plugin 'vim-scripts/Emmet.vim' "HTML/CSS Plugin
" " Plugin 'Townk/vim-autoclose' "Close out parenthesis
" call vundle#end()
" filetype plugin indent on

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
set backspace=indent,eol,start

"For HTML/CSS/Javascrip files, indent is 2
"-----------------Web Dev Settings------------
au BufNewFile,BufRead *.html,*.htm,*.css,*.gohtml,*.js,*.vue
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
iabbrev </ </<C-X><C-O>
autocmd BufEnter *.gohtml :setlocal filetype=html

"------------------Python Settings------------
" Marks bad whitespace as red, for python
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
let python_highlight_all=1
set encoding=utf-8

"-----------------Git Commits------------------
au FileType gitcommit set tw=72

"--------------------Makefiles-----------------
autocmd BufEnter ?makefile* set include^s\=include
autocmd BufLeave ?makefile* set include&

"--------------------Markdown------------------
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Press F8 to run python code, allows for arguments
filetype on
autocmd FileType python nnoremap <buffer> <F8> :w \| exec '!clear; python' shellescape(@%, 1)<cr>

" -------------Colors---------------------
let g:solarized_termcolors=256 "needed for solarzied
syntax on
syntax enable
colorscheme distinguished "Color scheme
set background=dark

" ----------UI Layout---------------------
set number
set relativenumber
set showcmd
set cursorline
set showmatch
set wildmenu

function! PositionCursonFromViminfo()
    if !(bufname("%") =~ '\(COMMIT_EDITMSG\)') && line("'\"") > 1 && line("'\"") <= line("$")
        exe "normal! g`\""
    endif
endfunction
:au BufReadPost * call PositionCursonFromViminfo()

inoremap {<cr> {<cr>}<c-o>O
inoremap [<cr> [<cr>]<c-o>O<tab>
inoremap (<cr> (<cr>)<c-o>O
inoremap (<SPACE> ()<Esc>i
inoremap {<SPACE> {}<Esc>i
inoremap [<SPACE> []<Esc>i
" inoremap "<SPACE> ""<Esc>i
" inoremap <<SPACE> <><Esc>i

" ---------------Buffers-----------------
nnoremap gb :buffers<CR>:buffer<Space>
set hidden

" -------------Searching-----------------
set ignorecase
set incsearch
set hlsearch
nmap <silent> ,/ :nohlsearch<CR>

"----------------Copying----------------
" if $TMUX == ''
"     set clipboard+=unnamed
" endif
set clipboard=unnamed

set pastetoggle=<F2>

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
" YouCompleteMe
" let g:ycm_server_python_interpreter = '/usr/local/bin/python'
let g:ycm_python_binary_path = '/Users/kho/anaconda/bin/python'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

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
set tags=tags
map <F7> :!ctags -R .<cr>

" Vim-Go
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
" let g:go_auto_sameids = 1


" Vim Wiki
let wiki_1 = {}
let wiki_1.path = '~/vimwiki_personal/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'
let g:vimwiki_global_ext = 0

let g:vimwiki_list = [wiki_1]
" let g:vimwiki_ext2syntax = {'.md':'markdown', '.markdown':'markdown',  'mdown':'markdown'}

" Fzf
map ; :Files<CR>

" vimtex
let g:flavor='latex'
" let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
