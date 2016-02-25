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
set lazyredraw
set ttyfast
set history=1000		" keep 1000 lines of command line history
set ruler			" show the cursor position all the time
set laststatus=2
set showcmd			" show (partial) command in status line.

set wildmode=list:longest	" tab completion behaviour: mimic bash
set wildmenu
set wildignore=*.o,*.lo,*.pyc,*.rej
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

set t_Co=256			" 256 colors

set cinoptions=:0,t0,(0,u0,w1,m1

if has("autocmd")
  " when editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif

  " highlight characters > 80
  autocmd BufNewFile,BufRead *.c,*.py exec 'match Todo /\%>' . 80 . 'v.\+/'


  " PEP8
  au BufNewFile,BufRead *.py call SetPythonOptions()
  function SetPythonOptions()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set textwidth=79
    set expandtab
    set autoindent
    set fileformat=unix
  endfunction

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

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

""
" Align arguments
nmap ,a :GNOMEAlignArguments<CR>

"" Command T

nnoremap <C-t> :CommandT<CR>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" git grep
nnoremap <C-F> :Ggrep <cword><CR>

" previous/next buffer
nnoremap <A-Right> :bnext<CR>
nnoremap <A-Left> :bprevious<CR>

" errors
nnoremap <F10> :lnext<CR>
nnoremap <F9>  :lprevious<CR>

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

""
" Python

let python_highlight_all = 1

""
" Plugins

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'wincent/command-t', { 'tag': '1.4', 'do' : 'cd ruby/command-t; make clean; ruby extconf.rb && make' }
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/indentpython.vim'
Plug 'Valloric/YouCompleteMe', { 'do' : './install.py' }
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go'
call plug#end()

" TagBar
nmap <C-E> :TagbarToggle<CR>

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" Syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_always_populate_loc_list = 1
" pylint is just too much crap without proper ignore list
let g:syntastic_python_checkers = ['flake8']

" Airline
let g:airline_theme = 'wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#virtualenv#enabled = 0

" Need to install the powerline patches fonts for this
let g:airline_powerline_fonts = 1

function! AirLineConfiguration()
  function! Modified()
    return &modified ? " +" : ''
  endfunction

  call airline#parts#define_function('modified', 'Modified')

  let g:airline_section_b = airline#section#create(['branch'])
  let g:airline_section_c = airline#section#create_left(['%t'])
  let g:airline_section_gutter = airline#section#create(['modified', '%='])
  let g:airline_section_x = airline#section#create_right([''])
  let g:airline_section_y = airline#section#create_right([''])
  let g:airline_section_z =  airline#section#create_right(['%l,%c'])
endfunction

autocmd Vimenter * call AirLineConfiguration()
