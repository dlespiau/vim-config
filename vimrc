set fileencodings=utf-8,latin1	" #UTF-8

set nocompatible		" use Vim defaults
set bs=2			" allow backspacing over everything in insert
				" mode
set background=dark		" I do prefer a dark bg
if has("gui_running")
  colorscheme torte		" and this colorschme on modern vim
else
  colorscheme elflord		" or this one when using the terminal
endif
syntax on  			" give me colors !

set modeline			" I want modelines (Debian disables it)

set autoindent                  " automatic indentation
set smartindent                 " if you like ai you'll want this one

set viminfo='20,\"50		" read/write a .viminfo file, don't store more
				" than 50 lines of registers
set history=50			" keep 50 lines of command line history
set ruler			" show the cursor position all the time
set showcmd			" show (partial) command in status line.

set wildmode=list:longest	" tab completion behaviour: mimic bash
set wildmenu
set wildignore=*.o,*.lo		" ignore object files
set autowrite			" automatically save before commands like
				" :next and :make
set hidden			" hide buffers when they are abandoned

set showmatch			" show matching [({

set mouse=a			" allow the use of the mouse (sroll, select)

set hlsearch			" highlight results
set incsearch			" incremental searh

set exrc			" enable per-directory .vimrc files
set secure			" disable any unsafe commands in .exrc files

set noswapfile

set cinoptions=:0,t0,(0,u0,w1,m1

if has("autocmd")
  " when editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

  " highlight characters > 80
  autocmd BufNewFile,BufRead *.c exec 'match Todo /\%>' . 80 . 'v.\+/'

  " Indentation rules for Makefiles
  " optional: list lcs=tab:>-,trail:x
  autocmd BufEnter ?akefile* set noet ts=8 sw=8 nocindent

  " Remove trailing spaces
  " autocmd BufWritePre * :%s/\s\+$//e

  " enable file type detection
  filetype plugin on

  " indentation rules according to the detected filetype.
  filetype indent on
endif

autocmd FileType gitcommit setlocal spell

""
" Align arguments
nmap ,a :GNOMEAlignArguments<CR>

" append :e with the path of current buffer
if has("unix")
    map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
    map ,e :e <C-R>=expand("%:p:h") . "\\" <CR>
endif

""
" C

" comment out a block of code
vmap out "zdmzO#if 0<ESC>"zp'zi#endif<CR><ESC>
