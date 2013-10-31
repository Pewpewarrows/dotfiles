" Must be first to prevent unwanted side-effects
set nocompatible

" Pathogen autoloads everything under ~/.vim/bundle
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

let os = substitute(system('uname'), "\n", "", "")

let mapleader=","
nnoremap ; :

" Quickly edit and reload the .vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Indentation
set autoindent
" NO. NEVER SET SMARTINDENT. DEPRECATED AND SHITTY.
" set smartindent

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
" if v:version >= 703
    " set relativenumber  " relative line #s in the gutter instead of absolute
" endif
set nomodeline  " never commonly used, has security vulnerabilities
set laststatus=2    " always displays the status line for consistency
set statusline=%<\ %f\ %m%r%y%h
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}%*
set statusline+=%=%-35.(%l\ of\ %L,\ %c%V%)\ %P

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
set showbreak=↪
set nolist  " don't show invisible characters by default, only for some files
noremap <leader>i :set list!<CR> " Toggle invisible chars

set title
" set titleold="Terminal"
" set titlestring=%F

if has("gui_running")
    set guioptions-=T
    if os == "Darwin"
        set guifont=Monaco:h12
    else
        set guifont=Inconsolata\ 11
    endif
endif

" Editing Behavior
set backspace=indent,eol,start  " backspace over everything in insert mode
set fileformats="unix,dos,mac"
set wrap
set textwidth=80
set formatoptions=qrnl1tc    " better line-wrapping, see :help fo-table
if v:version >= 703
    set colorcolumn=80
endif
set autoread

set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault    " search/replace is globally done on a line by default

" Ctrl-C is almost a perfect <ESC> replacement, except for InsertLeave
" autocommands. This remapping fixes that.
imap <C-c> <ESC>

" Clears the current search
map <silent> <leader><space> :noh<cr>

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
if v:version >= 703
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
set nohidden " When I close a tab, close the associated buffer

" Quick way to jump back to previous file
nnoremap <silent> Z <C-^>

" Folding
set foldmethod=indent
set foldnestmax=2
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
nnoremap <space> zA

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

" Rather have these as shortcuts to more common whole-line functions than to the
" end-of-line, which can still be accomplished with y$ and d$
map Y yy
map D dd

" Re-select text
nnoremap <leader>v V`]

" Paragraph text wrapping galore
nnoremap <leader>q gqip
vmap Q gq
nmap Q gqap

" Delete lines without adding them to the yank stack
nmap <silent> <leader>d "_d
vmap <silent> <leader>d "_d

" Forward-delete in insert mode
inoremap <C-d> <Del>

" Use the OS clipboard for all yank/paste operations
set clipboard+=unnamed

" For when you forget to sudo...
cmap w!! w !sudo tee % > /dev/null

" FileType improvements
autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" OmniCompletion
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Hightlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Tags
set tags=./tags;/

""""""""""""""
" EXTENSIONS "
""""""""""""""

" Ack-Grep
if os == "Darwin"
    let g:ackprg="ack -H --nocolor --nogroup --column"
else
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"
endif
" ... there is an intentional space at the end of this line:
nnoremap <leader>a :Ack<space>

" CommandT
let g:CommandTMatchWindowAtTop = 1
map <leader>f :CommandT<CR>
" TODO: :CommandTFlush

" DelimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_balace_matchpairs = 1
" autocmd FileType css let b:delimitMate_matchpairs = "::;"

" EasyMotion
let g:EasyMotion_leader_key = '<Leader>m'

" NERDComment
map <C-\> :call NERDComment(0, 'toggle')<CR>
vmap <C-\> :call NERDComment(1, 'toggle')<CR>

" NERDTree
map <F3> :NERDTreeToggle<CR>
let NERDTreeDirArrows=1
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

" Syntastic
let g:syntastic_check_on_open=1
" let g:syntastic_auto_loc_list=1
let g:syntastic_disabled_filetypes = ['html']
map <leader>E :Errors<CR>
map <leader>C :SyntasticCheck<CR>

" TagBar
noremap <F4> :TagbarToggle<CR>

"""""""""""""""""
" HOST-SPECIFIC "
"""""""""""""""""

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" TODO
" - Split selection into multiple lines based on criteria
" - Re-format file (faster than g=)
" - Auto-select whole inner scope (an intelligent vi{)
" - Navigating through changelist/jumplist
" - Refactoring with tools like rope
" - Comment header snippets
" - Paragraph / comment / block of text wrapping (cmd-opt-Q in ST)
" gv - reselect last visual block
" q: - view command history, edit, and re-run
" q/ - view search history, edit, and re-run
" :help changelist
" :help text-objects
" :help format-comments
" :help formatoptions
" :help fo-table
