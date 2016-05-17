" dotmarkbt/vimrc

" Use Vim's defaults
set nocompatible

" Disable swapfiles
set noswapfile

" Disable folding
if has("folding")
  set nofoldenable
endif

" I always use dark backgrounds
set background=dark

" Allow backspacing over everything in insert mode
set bs=2

" Disable autoindentation and "smart" tabs
set noai
set nosmarttab

" Save a .viminfo file with no more than 50 lines of registers
set viminfo='20,\"50

" Keep 500 lines of history
set history=500

" Show the ruler and set up a nice status bar
set ruler
set laststatus=2
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

" Show line numbers and don't wrap lines
set number
set nowrap

" Search for tags in parent directories
set tags=tags;/

" Enable incremental search
set incsearch

" Set defaul tabstop to four spaces and expand tabs to spaces
set tabstop=4
set expandtab

" Set shiftwidth to 4 spaces
set shiftwidth=4

" Enable virtualedit in block mode
set virtualedit=block

" Sensible tab completion
set wildmode=longest,list

" Autocommands
if has("autocmd")

  " TXT, MD - limit width to 78
  autocmd BufNewFile,BufRead *.txt set tw=78
  autocmd BufNewFile,BufRead *.md set tw=78 filetype=markdown

  " TEX - limit width to 72
  autocmd BufNewFile,BufRead *.tex set tw=72

  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup cprog
    " Remove all cprog autocommands
    au!

    " When starting to edit a file:
    "   For C and C++ files set formatting of comments and set C-indenting on.
    "   For other files switch it off.
    "   Don't change the order, it's important that the line with * comes first.
    autocmd FileType *      set tabstop=4 sw=4 formatoptions=tcql nocindent comments&
    autocmd FileType c,cpp  set tabstop=2 sw=2 formatoptions=cql nocindent comments=sr:/*,mb:*,el:*/,://
    autocmd FileType c,cpp  syn keyword cType  int8_t  int16_t  int32_t  int64_t  ssize_t
    autocmd FileType c,cpp  syn keyword cType uint8_t uint16_t uint32_t uint64_t
  augroup END

endif

" Don't use Ex mode, use Q for formatting
map Q gq

" map Q to q
command Q q

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  syntax sync fromstart
  set hlsearch
endif

" GUI options
if has("gui_running")
  set number
  set scrolloffset=10
  set noshowmatch
  set novisualbell
  set noerrorbells
  set showtabline=2

  set guicursor=a:blinkon0
  set guifont=Consolas:h9:cANSI
  set lines=50 columns=120
  set guioptions-=m
  set guioptions-=T
  set cursorline

  colorscheme molokai
  hi clear Search
  hi Search guibg=#373b3d
  hi ColorColumn ctermbg=1 guibg=#1e2021
  hi CursorLine guibg=#2d3031
  hi mbtTrailSpace guibg=#0e0f0f
endif

" Work around buggy xterms
if &term=="xterm"
     set t_Co=8
     set t_Sb=^[4%dm
     set t_Sf=^[3%dm
endif

" Extra keybindings
" Scroll around with Alt+arrow keys
map <A-Up> 4<C-y>
map <A-Down> 4<C-e>
map <A-Left> 8zh
map <A-Right> 8zl

" Switch windows in insert mode
imap <C-w> <C-o><C-w>

" Stay in visual mode when indenting
vnoremap < <gv
vnoremap > >gv

" Y: yank to end of line
noremap Y y$

" Ctrl-E: Jump to end
inoremap <C-e> <C-o>$

" Read local vimrc
if filereadable($HOME."/.vimrc_local")
  source $HOME/.vimrc_local
endif

