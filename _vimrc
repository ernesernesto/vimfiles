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

"Tab behaviour
set tabstop=8 
set shiftwidth=4
set softtabstop=4
set expandtab

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

"Easier to find pair with tab
nnoremap <Tab> %
vnoremap <Tab> %

"Easier to type command
nnoremap ; :
vnoremap ; :

"Dealing with many files
set path=**
nnoremap <Leader>f :find *
nnoremap <Leader>s :sfind *
nnoremap <Leader>v :vert sfind *
nnoremap <leader>F :find <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>S :sfind <C-R>=expand('%:h').'/*'<CR>
nnoremap <leader>V :vert sfind <C-R>=expand('%:h').'/*'<CR>

"Open recent buffer
nnoremap gb :ls<CR>:b<Space>

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

"Disable error beeping and flashing
if has("gui_running")
    autocmd GUIEnter * set vb t_vb=
endif
