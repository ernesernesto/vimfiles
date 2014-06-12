"Pathogen first
execute pathogen#infect()

"########################
"Global Settings
"########################
filetype plugin indent on
set nocompatible
set encoding=utf-8
syntax on

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

"Keyboard movement
nnoremap j gj
nnoremap k gk
nnoremap h <C-h>
nnoremap l <space>

"Tab behaviour
set tabstop=8 
set shiftwidth=4
set softtabstop=4
set expandtab

"Exit from insert mode using jk 
inoremap jk <ESC>

"Remove F1
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

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

"Set leader key
let mapleader=","

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

nnoremap <silent> <c-]> :call MatchCaseTag()<CR>

"########################
"Color & Font settings
"########################
colorscheme monokai 

set guifont=Consolas:h11

"Transparency
autocmd GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 245)
