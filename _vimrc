let g:pathogen_disabled = ['nerdcommenter']
"let g:pathogen_disabled = ['youcompleteme']

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
set showmatch

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

"Flag bad whitespaces
highlight BadWhitespace ctermbg=red guibg=red
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

"Make it full screen
set lines=999
set columns=999
if has("win32")
    au GUIEnter * simalt ~x
endif

set switchbuf=useopen,split

"########################
"Keyboard mapping
"########################
"Set leader key
let mapleader=","

"Keyboard movement
nnoremap j gj
nnoremap k gk
"nnoremap h <C-h>
nnoremap l <space>
map <C-j> }
map <C-k> {
map <C-h> F<Space>
map <C-l> f<Space>

"Move to end and beginning of line
noremap <C-b> 0
noremap <C-e> $

nnoremap <S-y> y%

"Delete surrounding spaces
nnoremap <leader>ds F<space>xf<space>x

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

"Delete surrounding blankspace
nnoremap <leader>d F<space>xf<space>x

"Quick switch between .h and .cpp
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

"########################
"Plugin settings
"########################

"NERDTree
noremap <F1> :NERDTreeToggle<CR>

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
"nnoremap <leader>f :Ag -i --ignore=*.pbxproj -Q 
nnoremap <leader>f :Ag -i -Q 

"Rg
"nnoremap <leader>f :Rg 

"NerdCommenter
"map <C-K><C-K> <leader>ci

"CTRL-P
let g:ctrlp_max_files=0
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

"NoEOL
let g:PreserveNoEOL = 1 

"Fugitive
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
map <F2>  [c
map <F3>  ]c
nnoremap <F8>  :Gedit branch:%
nnoremap <F9>  :Git blame<CR>
nnoremap <F10> :Git<CR>
nnoremap <F11> :Gvdiffsplit!<CR>
nnoremap <F12> :Gread<CR>

"Omnisharp
"set omnifunc=syntaxcomplete#Complete

" Go Settings
autocmd FileType go nmap <F5> <Plug>(go-build)
let g:go_addtags_transform = "camelcase"

"" zig settings
"autocmd BufNewFile,BufRead *.zig set filetype=zig
"let g:ycm_language_server =
"  \ [
"  \{
"  \     'name': 'zls',
"  \     'filetypes': [ 'zig' ],
"  \     'cmdline': [ '~/zls/zls' ]
"  \}

" ********
" coc settings
set updatetime=300
set shortmess+=c
set nowritebackup

autocmd FileType zig,odin inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd FileType zig,odin inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
autocmd FileType inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
autocmd FileType zig,odin nmap <C-g> <Plug>(coc-definition)
autocmd FileType zig,odin nmap <C-f> <Plug>(coc-references)
" ********

" python format with black
"autocmd BufWritePre *.py execute ':Black'

"YouCompleteMe
nnoremap <C-g> :YcmCompleter GoTo<CR>
nnoremap <C-f> :YcmCompleter GetDoc<CR>
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 0 
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_auto_hover = ''

"Go to prev/next error
nnoremap <F6> :cp<CR>
nnoremap <F7> :cn<CR>

"########################
"Color & Font settings
"########################
colorscheme molokai

"set guifont=Consolas_for_Powerline_FixedD:h12

"Transparency
"autocmd GUIEnter * call libcallnr("vimtweak.dll", "SetAlpha", 245)

"Disable error beeping and flashing
if has("gui_running")
    autocmd GUIEnter * set vb t_vb=
endif

if has("gui_macvim")
    set guifont=ConsolasForPowerline:h12
elseif has("gui_win32")
    set guifont=Powerline\ Consolas:h12
endif
