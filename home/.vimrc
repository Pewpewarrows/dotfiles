" Must be first to prevent unwanted side-effects
set nocompatible

" Pathogen autoloads everything under ~/.vim/bundle
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

let mapleader=","
nnoremap ; :

" Quickly edit and reload the .vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Indentation
set autoindent
set smartindent

" Tabs to 4 spaces, always
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab

" Appearance
set hidden  " hides buffers instead of closing them
set termencoding=utf-8
set encoding=utf-8
set lazyredraw  " don't update the display while executing macros
set showmode
set showcmd
set visualbell  " don't beep at me!
" set t_vb=
set cursorline  " highlight the current line
set ttyfast " fast terminal
set ruler   " tells us the column/row we're on
set number  " line numbers in the gutter
set mouse=a " mouse interactivity
set showmatch   " show matching parenths
set scrolloff=4 " gives the buffer some padding when scrolling
if v:version >= 730
    set relativenumber  " relative line #s in the gutter instead of absolute
endif
set nomodeline  " never commonly used, has security vulnerabilities
set laststatus=2    " always displays the status line for consistency

" Better command-line completion
set wildmenu
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class

syntax on
set background=dark
if &t_Co >= 256 || has("gui_running")
    colorscheme molokai
endif

set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·,eol:¬
set nolist  " don't show invisible characters by default, only for some files
:noremap <leader>i :set list!<CR> " Toggle invisible chars

set title
" set titleold="Terminal"
" set titlestring=%F

if has("gui_running")
    set guioptions-=T
    set guifont=Monaco:h13
endif

" Editing Behavior
set backspace=indent,eol,start  " backspace over everything in insert mode
set wrap
set textwidth=80
" TODO: more intelligent line-wrapping
set formatoptions=qrn1    " better line-wrapping, see :help fo-table
if v:version >= 730
    set colorcolumn=85
endif
set autoread

set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault    " search/replace is globally done on a line by default

" Clears the current search
map <leader><space> :noh<cr>

" Use Perl-style regex syntax, not vim's butchered version
nnoremap / /\v
vnoremap / /\v

" Center the line that the search result is on
map N Nzz
map n nzz

" Quickly paste contents without corrupting indentation
set pastetoggle=<F2>

" Don't pollute the current working directory with this nonsense
set backupdir=~/.vim/tmp/backup,/tmp
set directory=~/.vim/tmp/swap,/tmp
if v:version >= 730
    set undofile
    set undodir=~/.vim/tmp/undo,/tmp
endif
set backup

" Improved splits movement
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>W <C-w>s<C-w>j
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Improved tab movement
nnoremap <S-h> :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>
map tn :tabnew<CR>
map td :tabclose<CR>

" TODO: Folding

" Remember EVERYTHING...
set history=1000
set undolevels=1000

" Stupid help menu right next to the ESC key...
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Line movement changed to what you see on screen, not literal file lines
nnoremap j gj
nnoremap k gk

" Shortcut to yank to end of line
map Y yy

" Re-select text
nnoremap <leader>v V`]

" Paragraph text wrapping galore
nnoremap <leader>q gqip
vmap Q gq
nmap Q gqap

" Delete lines without adding them to the yank stack
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P

" For when you forget to sudo...
cmap w!! w !sudo tee % > /dev/null

""""""""""""""
" EXTENSIONS "
""""""""""""""

" Ack-Grep
" let g:ackprg="ack-grep -H --nocolor --nogroup --column"
nnoremap <leader>a :Ack

" CommandT
let g:CommandTMatchWindowAtTop = 1
map <leader>f :CommandT<CR>

" EasyMotion
let g:EasyMotion_leader_key = '<Leader>m'

" NERDComment
map <C-\> :call NERDComment(0, 'toggle')<CR>
vmap <C-\> :call NERDComment(1, 'toggle')<CR>

" NERDTree
map <F3> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$','\.swp$']

" SnipMate
autocmd FileType python set ft=python.django
autocmd FileType html set ft=htmldjango.html
autocmd FileType htmldjango set ft=htmldjango.html

" Surround
" let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
" let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
" let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
" let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
" let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"

" TagList
" let Tlist_Use_Right_Window = 1
" let Tlist_Show_One_File = 1
" map <F4> :TlistToggle<CR>

"""""""""""""""""
" HOST-SPECIFIC "
"""""""""""""""""

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
