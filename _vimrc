"Pathogen first
execute pathogen#infect()

"########################
"Global Settings
"########################
filetype plugin indent on
set nocompatible
set encoding=utf-8
syntax on

"use system clipboard as default buffer
set clipboard=unnamed

"Don't clutter filesystem
set nobackup
set noswapfile

"Search setting
set ignorecase
set smartcase
set incsearch

"Vim behaviour
set ruler
set scrolloff=3
set wrap
set autoindent
set number

"Tab behaviour
set tabstop=4 
set shiftwidth=4
set softtabstop=4
set expandtab

"backspace behavior
set backspace=indent,eol,start

"Disable toolbar, menubar, and scrollbar
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=l
set guioptions-=r
set guioptions-=b

"Make it full screen
set lines=999
set columns=999
au GUIEnter * simalt ~x

set switchbuf=useopen,split

"########################
"Keyboard mapping
"########################
"Set leader key
let mapleader=","

"Keyboard movement
nnoremap j gj
nnoremap k gk
nnoremap h <C-h>
nnoremap l <space>

"Exit from insert mode using jk
inoremap jk <ESC>

"Remove F1
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"Easier to type command
nnoremap ; :
vnoremap ; :

"Dealing with many files
set path=**
nnoremap <leader>f :find *
nnoremap <leader>s :sfind *
nnoremap <leader>v :vert sfind *
nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>

"Open recent buffer
nnoremap gb :ls<CR>:b<Space>

"Quick edit vimrc 
:nnoremap <leader>ev :split $MYVIMRC<CR>

"Quick switch between .h and .cpp
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

"########################
"Plugin settings
"########################

"NERDTree
noremap <F2> :NERDTreeToggle<CR>

"CTags 
map <F12> :!start /min ctags -R .<CR>

"Case insensitive tag matching
fun! MatchCaseTag()
   let ic = &ic
   set noic
   try
      exe 'tjump ' . expand('<cword>')
   finally
      let&ic = ic
   endtry
endfun

"Airline
"Symbols remapping for Airline
let g:airline_symbols = {}
let g:airline_left_sep = "\u2b80" 
let g:airline_left_alt_sep = "\u2b81"
let g:airline_right_sep = "\u2b82"
let g:airline_right_alt_sep = "\u2b83"
let g:airline_symbols.branch = "\u2b60"
let g:airline_symbols.readonly = "\u2b64"
let g:airline_symbols.linenr = "\u2b61"

"Airline won't appear until creating new split
set laststatus=2

nnoremap <silent> <c-]> :call MatchCaseTag()<CR>

"Ag
nnoremap <C-S-F> :Ag 

"NerdCommenter
map <C-K><C-K> <leader>ci

"########################
"Color & Font settings
"########################
colorscheme monokai 

set guifont=Consolas_for_Powerline_FixedD:h10

"Transparency
"autocmd GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 245)

"Disable error beeping and flashing
if has("gui_running")
    autocmd GUIEnter * set vb t_vb=
endif
