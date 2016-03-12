let g:pathogen_disabled = ['nerdcommenter']

"Pathogen first
execute pathogen#infect()

"########################
"Global Settings
"########################
filetype plugin indent on
set nocompatible
set encoding=utf-8
set virtualedit=all
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
set nonumber

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
map <C-j> }
map <C-k> {
map <C-h> F<Space>
map <C-l> f<Space>
 
"Move to end and beginning of line
noremap <C-b> 0
noremap <C-e> $

nnoremap <S-y> y%

"Exit from insert mode using jk
inoremap jk <ESC>

"Remove F1
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"Easier to type command
nnoremap ; :
vnoremap ; :

"Open recent buffer
nnoremap gb :ls<CR>:b<Space>

"Quick edit vimrc 
:nnoremap <leader>ev :vsplit $MYVIMRC<CR>

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
nnoremap <leader>f :Ag -i -Q 

"NerdCommenter
"map <C-K><C-K> <leader>ci

"Fugitive
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"YouCompleteMe
let g:ycm_show_diagnostics_ui = 0 

"########################
"Color & Font settings
"########################
colorscheme monokai

set guifont=Consolas_for_Powerline_FixedD

"Transparency
"autocmd GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 245)

"Disable error beeping and flashing
if has("gui_running")
    autocmd GUIEnter * set vb t_vb=
endif

"HandmadeHero build script
" Thanks to https://forums.handmadehero.org/index.php/forum?view=topic&catid=4&id=704#3982
" error message formats
" Microsoft MSBuild
set errorformat+=\\\ %#%f(%l\\\,%c):\ %m
" Microsoft compiler: cl.exe
set errorformat+=\\\ %#%f(%l)\ :\ %#%t%[A-z]%#\ %m
" Microsoft HLSL compiler: fxc.exe
set errorformat+=\\\ %#%f(%l\\\,%c-%*[0-9]):\ %#%t%[A-z]%#\ %m
 
function! DoBuildBatchFile()
    " build.bat
    set makeprg=build
    " Make sure the output doesnt interfere with anything
    silent make
    " Open the output buffer
    copen
    echo 'Build Complete'
endfunction
 
" Set F7 to build. I like this since I use visual studio with the c++ build env
nnoremap <F5> :call DoBuildBatchFile()<CR>
 
"Go to previous error
nnoremap <F6> :cp<CR>
"Go to next error
nnoremap <F7> :cn<CR>

"Set filetype to lua 
nnoremap <F9> :set syntax=lua<CR>
