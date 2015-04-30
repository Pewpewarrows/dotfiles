" Modeline {
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker :
" }

" Preamble {
    " Must be first to prevent unwanted side-effects
    set nocompatible
" }

" Macros {
    silent function! OSX()
        return has('macunix')
    endfunction
    silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
        return (has('win16') || has('win32') || has('win64'))
    endfunction
" }

" Load Plugins {

    function! BuildVimProc(info)
        if OSX()
            !make -f make_mac.mak
        elseif LINUX()
            " TODO: unix
            !make
        elseif WINDOWS()
            " TODO: cygwin
            !tools\update-dll-mingw
        endif
    endfunction

    " Need to run :PlugInstall on new machines, or for updates
    call plug#begin()
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-sleuth'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'wikitopian/hardmode'
    Plug 'Lokaltog/vim-easymotion'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'rking/ag.vim'
    Plug 'Shougo/vimproc.vim', {'do': function('BuildVimProc')}
    Plug 'Shougo/neomru.vim'
    Plug 'Shougo/unite.vim'
    Plug 'Shougo/unite-outline'
    " TODO: msbuild or xbuild required for --omnisharp-completer
    " TODO: make install play nicely with pyenv & system python:
    " https://github.com/Valloric/YouCompleteMe/issues/8
    Plug 'Valloric/YouCompleteMe', {'do': './install.sh --clang-completer'}
    Plug 'scrooloose/syntastic'
    Plug 'tpope/vim-vinegar'
    " TODO: easy-align instead of tabular/table-mode?
    Plug 'godlygeek/tabular'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'tpope/vim-abolish'
    Plug 'terryma/vim-expand-region'
    Plug 'tpope/vim-rsi'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-repeat'
    Plug 'ap/vim-css-color'
    Plug 'mattn/gist-vim'
    Plug 'mattn/emmet-vim'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'Raimondi/delimitMate'
    " Plug 'jamessan/vim-gnupg'
    Plug 'mbbill/undotree'
    "Plug 'jeetsukumaran/vim-markology'
    Plug 'bling/vim-airline'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'tomasr/molokai'  " TODO: look into vim-hybrid as an alternative
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-obsession'
    Plug 'dhruvasagar/vim-prosession'
    Plug 'solarnz/thrift.vim'
    " TODO: Indent Guides, tmux-nav, go, numbers, localvimrc, yankring, slime,
    "       scratch, rainbow parenths, vim-instant-markdown
    call plug#end()

" }

" Behavior {

    " Have a better memory
    set undolevels=1000

" }

" UI {

    set background=dark  " Assume a dark color scheme

    if &t_Co >= 256 || has('gui_running')
        colorscheme molokai
    endif

" }

" Formatting {

    " Tabs to 4 spaces by default
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab

" }

" Mappings {

    let mapleader=","
    " let maplocalleader = "\\"

    " TODO: make this work, find better binding?
    " Commands are more frequent than the "find next" functionality
    " Remapping : back to ; appears to break many plugins
    " nnoremap ; :

    " Quickly edit and reload the .vimrc file
    nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>
    nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

    " Uppercase the previous word entered
    inoremap <leader>U <ESC>bveU

    iabbrev <expr> dts strftime("%a %d %b %Y")

" }

" Appearance
set hidden  " hides buffers instead of closing them
set termencoding=utf-8
set lazyredraw  " don't update the display while executing macros
set showmode
set visualbell  " don't beep at me!
" set t_vb=
set cursorline  " highlight the current line
set ttyfast  " fast terminal
set number  " line numbers in the gutter
set mouse=a  " mouse interactivity
set showmatch  " show matching parenths
" gives the buffer some padding when scrolling
set scrolloff=4  " vertically
set sidescrolloff=4  " horizontally
" if v:version >= 703
    " set relativenumber  " relative line #s in the gutter instead of absolute
" endif
au FileType vim setl keywordprg=:help

" If concerned about potential security vulnerabilities, uncomment
" http://lists.alioth.debian.org/pipermail/pkg-vim-maintainers/2007-June/004020.html
" set nomodeline

"set statusline=%<\ %f\ %m%r%y%h
"set statusline+=\ %#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}%*
"set statusline+=%=%-35.(%l\ of\ %L,\ %c%V%)\ %P

if version >= 700
    set spl=en spell
    set nospell
endif

" Better command-line completion
set wildmode=list:longest
set wildignore=*.swp,*.bak,*.pyc,*.class

set listchars=nbsp:·,tab:▸\ ,trail:·,extends:»,precedes:«,eol:¬
set showbreak=↪
set nolist  " don't show invisible characters by default, only for some files
" Toggle invisible chars
nnoremap <leader>i :set list!<CR>

set title
" set titleold="Terminal"
" set titlestring=%F

if has('gui_running')
    set guioptions-=T
    if OSX()
        set guifont=Monaco:h12
    else
        set guifont=Inconsolata\ 11
    endif
endif

" Editing Behavior
set wrap
set textwidth=79
set formatoptions=qrnl1tc  " better line-wrapping, see :help fo-table
if (exists('+colorcolumn'))
    set colorcolumn=80
    " highlight ColorColumn ctermbg=9
endif

set ignorecase
set smartcase
set hlsearch
set gdefault  " search/replace is globally done on a line by default

" Ctrl-C is almost a perfect <ESC> replacement, except for InsertLeave
" autocommands. This remapping fixes that.
inoremap <C-c> <Esc>
" consider jk instead
inoremap jj <Esc>

" Clears the current search
" Using :nohlsearch is the wrong solution, since it will get flipped back to
" :hlsearch the next time vimrc is sourced.
" nnoremap <silent> <leader><space> :nohlsearch<CR>
nnoremap <silent> <leader><space> :let @/ = ""<CR>

" Use Perl-style regex syntax, not vim's butchered version
nnoremap / /\v
vnoremap / /\v

" Center the line that the search result is on
nnoremap N Nzz
nnoremap n nzz

" Quickly paste contents without corrupting indentation
" <C-r>+ to paste straight from the OS paste board?
set pastetoggle=<F2>

" Don't pollute the current working directory with this nonsense.
" The double trailing forward slash at the end of the path tells it to use full
" paths when storing files, so two files named "foo.txt" don't clobber each
" other's swaps or backups.
set directory=~/.vim/tmp/swap//,/tmp/vim/swap//
set backup
set backupdir=~/.vim/tmp/backup//,/tmp/vim/backup//
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/tmp/undo//,/tmp/vim/undo//
endif

" Improved splits movement
" set splitbelow
" set splitright
nnoremap <leader>\ <C-w>v<C-w>l
nnoremap <leader><bar> <C-w>v<C-w>l
nnoremap <leader>- <C-w>s<C-w>j
nnoremap <leader>_ <C-w>s<C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>w :w<CR>
" ? http://vim.wikia.com/wiki/Copy_or_change_search_hit

" Improved tab movement
nnoremap <leader>h :tabprevious<CR>
nnoremap <leader>l :tabnext<CR>
nnoremap tn :tabnew<CR>
nnoremap td :tabclose<CR>

" Improved buffer movement
set hidden  " Allows for unsaved buffers to exist in the background
nnoremap <S-h> :bprevious<CR>
nnoremap <S-l> :bnext<CR>
nnoremap <leader>t :enew<CR>
nnoremap <leader>bq :bp <BAR> bd #<CR>

" Quick way to jump back to previous file
nnoremap <silent> Z <C-^>

" Folding
set foldmethod=indent
set foldnestmax=2
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
nnoremap <space> zA

" Stupid help menu right next to the ESC key...
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Line movement changed to what you see on screen, not literal file lines
nnoremap j gj
nnoremap k gk

" Rather have these as shortcuts to more common whole-line functions than to the
" end-of-line, which can still be accomplished with y$ and d$
nnoremap Y yy
nnoremap D dd

nnoremap <leader>p o<Esc>p

" Re-select text
nnoremap <leader>v V`]

" Paragraph text wrapping galore
nnoremap <leader>q gqip
vnoremap Q gq
nnoremap Q gqap

" Delete lines without adding them to the yank stack
nnoremap <silent> <leader>d "_d
vnoremap <silent> <leader>d "_d

" Forward-delete in insert mode
inoremap <C-d> <Del>

" Use the OS clipboard for all yank/paste operations
set clipboard+=unnamed

" For when you forget to sudo...
cmap w!! w !sudo tee % > /dev/null

" FileType improvements
augroup filetype_improvements
    autocmd!
    autocmd BufNewFile,BufRead *.json setfiletype javascript
    autocmd BufNewFile,BufRead {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} setfiletype ruby
    " TODO: is sleuth good enough for detecting filetype indentation?
    " http://stackoverflow.com/questions/158968/changing-vim-indentation-behavior-by-file-type
    " autocmd filetype make setlocal noexpandtab
augroup END

" OmniCompletion
augroup omnicompletion
    autocmd!
    "autocmd FileType python set omnifunc=pythoncomplete#Complete
    "autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    "autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    "autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    "autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    "autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    "autocmd FileType c set omnifunc=ccomplete#Complete
augroup END

" Hightlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" expands %% to current file's directory in command-line mode
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

" [S]plit line (sister to [J]oin lines)
" cc still substitutes the line like S would
nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

" visually select the last paste or change
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" switch to last buffer, like alt+tab. can also use <C-^>
nnoremap <leader><tab> :b#<CR>

""""""""""""""
" EXTENSIONS "
""""""""""""""

" Ag
nnoremap <leader>a :Ag!<space>
command! Todo execute ":Ag! \"[T]ODO|[F]IXME|[X]XX|[H]ACK|[N]OCOMMIT|[N]ORELEASE\""
nnoremap <leader>T :Todo<cr>

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
" TODO: getting some weird artifacts of > and < as airline seps
let g:airline_left_sep=''
let g:airline_right_sep=''

" Better Whitespace
augroup plug_better_whitespace
    autocmd!
    autocmd BufWritePre <buffer> StripWhitespace  " strip on save
augroup END
let g:better_whitespace_filetypes_blacklist = ['unite']

" DelimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_balace_matchpairs = 1
augroup plug_delimitmate
    autocmd!
    " autocmd FileType css let b:delimitMate_matchpairs = "::;"
augroup END

" EasyMotion

" Fugitive

" HardMode
augroup plug_delimitmate
    autocmd!
    " autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
    " to disable :call EasyMode()
augroup END

" Netrw
let g:netrw_altfile = 1  " don't let netrw occupy a buffer space

" SnipMate
augroup plug_delimitmate
    autocmd!
    "autocmd FileType python set ft=python.django
    "autocmd FileType html set ft=htmldjango.html
    "autocmd FileType htmldjango set ft=htmldjango.html
augroup END

" Surround
" let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
" let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
" let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
" let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
" let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"

" Syntastic
" TODO: re-enable the check_on_open option when it's faster and/or async
" let g:syntastic_check_on_open=1
let g:syntastic_aggregate_errors = 1
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_disabled_filetypes = ['html']
" NOTE: tmux and nvm don't play nicely, need to run the following:
" nvm deactivate && nvm use v0.12.0
" (can also place this in "pre_window:" in tmuxinator confs)
" http://stackoverflow.com/questions/18221847/managing-multiple-node-js-versions-with-nvm-in-a-tmux-session
let g:syntastic_javascript_checkers = ['jshint']  " Add 'flow' later
let g:syntastic_python_checkers = ['python', 'flake8']
let g:syntastic_sh_checkers = ['sh', 'shellcheck', 'checkbashisms']
let g:syntastic_python_flake8_args = "--ignore=E501"
nnoremap <leader>E :Errors<CR>
nnoremap <leader>C :SyntasticCheck<CR>

" Ultisnips
let g:UltiSnipsExpandTrigger = "<c-j>"

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>

" Unite
let g:unite_data_directory = '~/.vim/tmp/unite/'
let g:unite_prompt = '➜ '
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ 'tmp/',
      \ 'node_modules/',
      \ 'vendor/',
      \ 'env/',
      \ ], '\|'))
nnoremap <leader>f :Unite -buffer-name=files -start-insert -auto-resize file file_rec/async<CR>
nnoremap <leader>b :Unite -buffer-name=buffer -auto-resize buffer<CR>
nnoremap <leader>m :Unite -buffer-name=mru -auto-resize file_mru<CR>
nnoremap <leader>o :Unite -buffer-name=outline -vertical outline<CR>

" YouCompleteMe
" TODO: investigate if can/should use pyenv shim here...
let g:ycm_path_to_python_interpreter = '/usr/bin/python'

"""""""""""""""""
" HOST-SPECIFIC "
"""""""""""""""""

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" TODO
" - Split selection into multiple lines based on criteria
" - Re-format file (faster than g=)
" - Auto-select whole inner scope (an intelligent vi{)
" - Navigating through changelist/jumplist (<C-o> <C-i> g; g,)
" - Navigating through tag stacks (<C-]> <C-T>)
" - Refactoring with tools like rope
" - Comment header snippets
" - Paragraph / comment / block of text wrapping (cmd-opt-Q in ST)
" - Learn how to use this as a 3-way diff/merge tool
"   (vsplit, :e, :diffthis, ]c, [c, do, dp, <C-w>o, :diffoff, etc)
" - GitGutter ]h [h <leader>hs <leader>hr
" - :TOhtml
" - Zooming to particular splits, then getting them back again? (also in tmux)
" - ctags / symbols
" - project-wide find-and-replace / advanced refactoring
" - conflicting tmux key <C-o> and vim jumplist key
" - mastering folds
" - quickfix/context pane/split, :cc, :copen, :cclose
" - abbreviations vs snippets
" <C-v> to do block visual mode, then I to enter a special insert mode that
"       will replay the insert on every selection. A for append. $ for EOL.
" gv - reselect last visual block
" gx - open URL under cursor in default browser, g:netrw_browsex_viewer
" g_ - go to end of line WITHOUT newline, for yanking without break, etc
" ciw instead of cw
" `` to jump back to where you just came from
" q: - view command history, edit, and re-run
" q/ - view search history, edit, and re-run
" U - undo all changes on the line this far
" :help changelist
" :help text-objects
" :help format-comments
" :help formatoptions
" :help fo-table
