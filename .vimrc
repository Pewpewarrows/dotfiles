" Modeline {{{
" vim: set foldlevel=0 foldmethod=marker :
" TODO: remove this modeline, disable all modelines, use alternative
" set nomodeline
" }}}

" TODO:
" - Macro to split selection into multiple lines based on criteria
" - Auto-select whole inner scope (an intelligent vi{)
" - mastering marks
" - Refactoring with tools like rope
" - Comment header snippets
" - Zooming to particular splits, then getting them back again? (also in tmux)
" - project-wide find-and-replace / advanced refactoring
" - mastering folds
" - abbreviations vs snippets
" - mastering movement without hjkl
" - :help changelist
" - :help text-objects
" - :help format-comments
" - :help formatoptions
" - :help fo-table
" - macros for inserting and editing various comment headers in several langs:
"   http://vi.stackexchange.com/questions/415/adding-80-column-wide-comment-header-block-with-centered-text
" - Bind ":syntax sync fromstart" to a key: http://vim.wikia.com/wiki/Fix_syntax_highlighting
" - :verbose set shiftwidth?

" Preamble {{{

    " Must be first to prevent unwanted side-effects
    set nocompatible

" }}}

" Helpers {{{

    silent function! OSX()
        return has('macunix')
    endfunction

    silent function! LINUX()
        return has('unix') && !has('macunix') && !has('win32unix')
    endfunction

    silent function! WINDOWS()
        return (has('win16') || has('win32') || has('win64'))
    endfunction

" }}}

" Load Plugins {{{

    " Need to run :PlugInstall on new machines, and :PlugUpdate for updates
    call plug#begin()

    " Options
    Plug 'tpope/vim-sensible'
    Plug 'liuchengxu/vim-better-default'

    " Appearance
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'bling/vim-airline'
    Plug 'ryanoasis/vim-devicons'

    " Theme
    Plug 'dracula/vim', {'as': 'dracula'}

    " Project Management
    Plug 'tpope/vim-obsession'
    Plug 'dhruvasagar/vim-prosession'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'tpope/vim-fugitive'

    " Filetypes
    Plug 'sheerun/vim-polyglot'
    if has('nvim')
        Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
    endif
    Plug 'arzg/vim-rust-syntax-ext'

    " Navigation
    " TODO: this is macOS/homebrew specific
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'justinmk/vim-dirvish'
    Plug 'osyo-manga/vim-anzu'
    Plug 'milkypostman/vim-togglelist'

    " Editing
    Plug 'Lokaltog/vim-easymotion'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'jiangmiao/auto-pairs'
    Plug 'honza/vim-snippets'

    " Language Server Protocol
    " (Diagnostics, Code Completion, References, Formatting)
    Plug 'w0rp/ale'
    if has('nvim')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif

    " Apps
    Plug 'vimwiki/vimwiki'

    call plug#end()

    " TODO:
    " Plug 'tpope/vim-sleuth'
    " Plug 'airblade/vim-gitgutter'
    " " TODO: molasses or mediummode instead of hardmode?
    " Plug 'wikitopian/hardmode'
    " " TODO: easy-align instead of tabular/table-mode?
    " Plug 'godlygeek/tabular'
    " Plug 'dhruvasagar/vim-table-mode'
    " Plug 'tpope/vim-abolish'
    " Plug 'terryma/vim-expand-region'
    " Plug 'tpope/vim-rsi'
    " Plug 'tpope/vim-endwise'
    " Plug 'tpope/vim-repeat'
    " Plug 'ap/vim-css-color'
    " Plug 'mattn/webapi-vim'
    " Plug 'mattn/gist-vim'
    " Plug 'mattn/emmet-vim'
    " " Plug 'jamessan/vim-gnupg'
    " Plug 'mbbill/undotree'
    " Plug 'kshenoy/vim-signature'
    " Plug 'terryma/vim-multiple-cursors'
    " Plug 'solarnz/thrift.vim'
    " Plug 'craigemery/vim-autotag'
    " Plug 'xuhdev/vim-latex-live-preview'
    " " Plug 'gilligan/vim-lldb'
    " Plug 'ARM9/arm-syntax-vim'
    " Plug 'junegunn/vim-peekaboo'
    " Plug 'dag/vim-fish'
    " TODO: Indent Guides, tmux-nav, go, numbers, localvimrc, yankring, slime,
    "       scratch, rainbow parenths, vim-instant-markdown, lexical, riv?,
    "       eunuch, butane?, seek?, incsearch, easytags?, projectionist?

" }}}

" Options {{{

    set formatoptions=qrnl1tc  " better line-wrapping, see :help fo-table
    set gdefault  " search/replace is globally done on a line by default
    set guicursor=n:blinkon1
    set lazyredraw  " don't update the display while executing macros
    set mouse=a
    set nojoinspaces
    set nolist  " don't show invisible characters by default, only for some files
    set showbreak=↪
    set textwidth=79
    set title
    set visualbell  " don't beep at me!
    set diffopt+=vertical
    set nostartofline

    " Recommended by coc.vim
    " set cmdheight=2
    set updatetime=300
    set shortmess+=c
    set signcolumn=yes

    " Hightlight VCS conflict markers
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    if exists('+colorcolumn')
        " TODO: have a variable hold the textwidth and set this to +1
        set colorcolumn=80,120
        " highlight ColorColumn ctermbg=9
    endif

    if exists('+termguicolors')
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
        set termguicolors
    endif

    " NeoVim
    if has('nvim')
        set inccommand=nosplit
    endif

    " TODO
    " set foldmethod=indent
    " set foldnestmax=2
    " set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" }}}

" Theme {{{

    if (&t_Co >= 256 || has('gui_running')) && has#colorscheme('dracula')
        " TODO: test for colorschemes, have backups
        colorscheme dracula
    endif

    if has('gui_running')
        " TODO: test for fonts, have backups
        " set guioptions-=T
        set guifont=Fura Mono Nerd Font:h12
    endif

    " Fix mouse not working on wide columns
    " if has('mouse_sgr')
    "     set ttymouse=sgr
    " else
    "     set ttymouse=xterm2
    " endif

" }}}

" Mappings {{{

    let mapleader = "\<Space>"
    " let maplocalleader = "\\"

    " Quickly edit and reload the .vimrc file
    nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>
    nnoremap <silent> <leader>sv :source $MYVIMRC<CR>

    " Toggle invisible chars
    nnoremap <leader>i :set list!<CR>

    " Use Perl-style regex syntax, not vim's butchered version
    nnoremap / /\v
    xnoremap / /\v

    " Center the line that the search result is on
    nnoremap n nzz
    nnoremap N Nzz

    " expands %% to current file's directory in command-line mode
    " tip: use %:p to get the absolute path
    cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>

    " [S]plit line (sister to [J]oin lines)
    " cc still substitutes the line like S would
    nnoremap S i<CR><Esc>^mwgk:silent! s/\v +$//<CR>:noh<CR>

    " visually select the last paste or change
    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

    " Quick find-replace for any word under the cursor
    nnoremap c* /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``cgn
    nnoremap c# /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``cgN
    nnoremap d* /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgn
    nnoremap d# /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgN
    " TODO: make these work with a visual selection
    " https://old.reddit.com/r/vim/comments/2p6jqr/quick_replace_useful_refactoring_and_editing_tool/

    " TODO: remove me, already in vim-better-default
    xnoremap <CR> :
    " TODO: put these into an augroup?
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

    nnoremap <leader>wH <C-w>5<
    nnoremap <leader>wL <C-w>5>
    nnoremap <leader>wJ :resize +5<CR>
    nnoremap <leader>wK :resize -5<CR>

    " Old split/window/tab/buffer mappings

    " Improved splits movement
    " set splitbelow
    " set splitright
    " nnoremap <leader>\ <C-w>v<C-w>l
    " nnoremap <leader><bar> <C-w>v<C-w>l
    " nnoremap <leader>- <C-w>s<C-w>j
    " nnoremap <leader>_ <C-w>s<C-w>j
    " nnoremap <C-h> <C-w>h
    " nnoremap <C-j> <C-w>j
    " nnoremap <C-k> <C-w>k
    " nnoremap <C-l> <C-w>l

    " nnoremap <leader>w :w<CR>
    " ? http://vim.wikia.com/wiki/Copy_or_change_search_hit

    " Improved tab movement
    " nnoremap <leader>h :tabprevious<CR>
    " nnoremap <leader>l :tabnext<CR>
    " nnoremap <leader>tn :tabnew<CR>
    " nnoremap <leader>td :tabclose<CR>

    " Improved buffer movement
    " nnoremap <S-h> :bprevious<CR>
    " nnoremap <S-l> :bnext<CR>
    " nnoremap <leader>n :enew<CR>
    " TODO: try instead :bp\|bd #<CR>
    " TODO: try instead :b#<bar>bd #<CR>
    "       but it has problems when closing multiple buffers back to back,
    "       ends up switching back to an already-closed buffer sometimes?
    " TODO: but the problem with bx is that it will close the split it's in
    nnoremap <leader>bx :bd!<CR>
    " Use unimpaired's [b ]b for quick buffer browsing

    " Quickly switch to last buffer, like alt+tab. can also use <C-^> or <C-6>
    nnoremap <leader><tab> :b#<CR>
    " TODO: map <bs> to that instead?
    " nnoremap <silent> Z <C-^>

    " Stupid help menu right next to the ESC key...
    " inoremap <F1> <ESC>
    " nnoremap <F1> <ESC>
    " vnoremap <F1> <ESC>

    " Plain arrows for bubbling text
    " For the <Up> and <Down> binds, see vim-unimpaired config below
    nnoremap <Left> <<
    inoremap <Left> <C-o><<
    xnoremap <Left> <gv
    nnoremap <Right> >>
    inoremap <Right> <C-o>>>
    xnoremap <Right> >gv

    " Control-arrows conflict with macOS Mission Control shortcuts
    " TODO: Shift-arrows for splits, Alt-arrows for resizing splits? Duplicate lines?

    " TODO: this might not be necessary with vim-unimpaired's [p and ]p
    " nnoremap <leader>p o<Esc>p
    " from system clipboard
    " nnoremap <leader>P o<Esc>"*p

    " Re-select text
    " nnoremap <leader>v V`]
    nnoremap gV `[v]`

    " Paragraph text wrapping galore
    " nnoremap <leader>q gqip
    " vnoremap Q gq
    " nnoremap Q gqap

    " nnoremap <space> zA

" }}}

" File Types {{{

    " TODO: move these to ftplugins?
    augroup filetype_improvements
        autocmd!
        " Options per filetype
        autocmd FileType gitcommit setlocal spell textwidth=72 colorcolumn=51,73
        autocmd FileType mail setlocal spell
        autocmd FileType markdown setlocal spell
        autocmd FileType netrw setlocal bufhidden=wipe
        autocmd FileType rst setlocal spell
        autocmd FileType vim setlocal keywordprg=:help
        " TODO: potentially `set complete+=kspell` for prose filetypes
        " TODO: detecting certain .conf files for dosini filetype?
        " autocmd FileType fish compiler fish
        " autocmd FileType fish setlocal foldmethod=expr
        " Filetypes per extension
        autocmd BufNewFile,BufRead *.c setfiletype doxygen
        autocmd BufNewFile,BufRead *.h,*.cpp setfiletype doxygen
        autocmd BufNewFile,BufRead *.html setfiletype htmldjango
        " autocmd BufNewFile,BufRead *.json setfiletype javascript
        autocmd BufNewFile,BufRead *.prettierrc setfiletype json
        autocmd BufNewFile,BufRead *.py setfiletype django
        autocmd BufNewFile,BufRead {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} setfiletype ruby
    augroup END

    " TODO: consider this for ensuring dirs exist to new file
    " au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" }}}

" Plugin Configuration {{{

    " airline {{{

        let g:airline#extensions#tabline#enabled = 1

    " }}}

    " ale {{{

        let g:ale_fixers = {}
        let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']
        let g:ale_fixers.html = ['prettier']
        let g:ale_fixers.json = ['prettier']
        let g:ale_fixers.markdown = ['prettier']
        let g:ale_fixers.python = ['black']
        let g:ale_fixers.rust = ['rustfmt']
        let g:ale_fixers.vim = ['ale_custom_linting_rules']

        let g:ale_linters = {}
        " TODO: add 'pyre' back to here after fixing its buck problem
        let g:ale_linters.python = ['prospector']

        " TODO: --doc-warnings --test-warnings
        let g:ale_python_prospector_options = '--profile $HOME/.prospector.yaml --with-tool mypy --with-tool pep257 --with-tool pyroma --with-tool vulture --with-tool bandit'
        let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')

        nmap <Leader>af <Plug>(ale_fix)
        " TODO: evaluate unimpaired loclist bindings, maybe use instead
        nmap <Leader>aj <Plug>(ale_next_wrap)
        nmap <Leader>ak <Plug>(ale_previous_wrap)

        " TODO: evaluate some of these old syntastic configs for C-lang dev
        " TODO: make a brew formula for sparse and add it here
        "       https://sparse.wiki.kernel.org/index.php/Main_Page
        " Other c checkers to situationally use: checkpatch
        " let g:syntastic_c_checkpatch_args = '--ignore CODE_INDENT,LEADING_SPACE,C99_COMMENTS,OPEN_BRACE'
        " let g:syntastic_c_compiler_options = '-std=c11 -Wall -Wextra -Wformat=2 -pedantic -Wshadow -Wstrict-overflow -fno-strict-aliasing -Wpointer-arith'

    " }}}

    " asyncrun.vim {{{

        let g:asyncrun_bell = 1

        nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test<CR>
        nnoremap <silent> <F7> :AsyncRun -cwd=<root> make<CR>
        nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run<CR>
        " TODO: toggle quickfix window? run current single file? lint?

        augroup asyncrun
            autocmd!
            autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(8, 1)
        augroup END

    " }}}

    " coc.nvim {{{

        if has('nvim')
            " Use <c-space> to trigger completion.
            inoremap <silent><expr> <c-space> coc#refresh()

            let g:coc_global_extensions = [
                \ 'coc-elixir',
                \ 'coc-json',
                \ 'coc-python',
                \ 'coc-rust-analyzer',
                \ 'coc-snippets',
            \ ]
        endif

    " }}}

    " fzf.vim {{{

        nnoremap <Leader>bb :Buffers<CR>
        nnoremap <Leader>f<Space> :Commands<CR>
        nnoremap <Leader>ff :Files<CR>
        nnoremap <Leader>fh :History<CR>
        " TODO: :History queries the .viminfo file, which is only regenerated
        " upon quitting vim, need a better MRU plugin or fzf config that will
        " account for files opened during the current session
        nnoremap <Leader>f: :History:<CR>
        nnoremap <Leader>f/ :History/<CR>
        nnoremap <Leader>fl :Lines<CR>
        nnoremap <Leader>rg :Rg<Space>
        " TODO: close buffer while browsing them via :Buffers

        command! Todo execute ":Rg! [T]O[_ ]?DO|[F]IX[_ ]?ME|[X]XX|[H]ACK|[^(DE)|^_][B]UG|[R]EVIEW|[W]TF|[S]MELL|[B]ROKE|[N]OCOMMIT|[N]ORELEASE"
        nnoremap <leader>T :Todo<cr>

        command! FilesFlat call fzf#run(fzf#wrap({'source': '$FZF_DEFAULT_COMMAND --max-depth 1'}))
        nnoremap <leader>fa :FilesFlat<CR>

        command! FilesShallow call fzf#run(fzf#wrap({'source': '$FZF_DEFAULT_COMMAND --max-depth 4'}))
        nnoremap <leader>fs :FilesShallow<CR>

    " }}}

    " gist-vim {{{

        " let g:gist_clip_command = 'pbcopy'
        " let g:gist_detect_filetype = 1
        " let g:gist_open_browser_after_post = 1
        " let g:gist_post_private = 1
        " let g:gist_show_privates = 1
        " let g:gist_update_on_write = 1

    " }}}

    " netrw {{{

        let g:netrw_fastbrowse = 0
        let g:netrw_altfile = 1  " don't let netrw occupy a buffer space

        " See: https://github.com/tpope/vim-vinegar/issues/13
        function! QuitNetrw()
          for i in range(1, bufnr('$'))
            if buflisted(i)
              if getbufvar(i, '&filetype') == "netrw"
                silent exe 'bwipeout ' . i
              endif
            endif
          endfor
        endfunction

        augroup plug_netrw
            autocmd!
            autocmd VimLeavePre * call QuitNetrw()
        augroup END

    " }}}

    " undotree {{{

        " nnoremap <leader>u :UndotreeToggle<CR>

    " }}}

    " vim-better-default {{{

        let g:vim_better_default_backup_on = 1
        let g:vim_better_default_persistent_undo = 1
        let g:vim_better_default_enable_folding = 1
        " Most of the window mappings are unnecessary, copying the same default
        " <C-w> maps, and conflict with vimwiki
        let g:vim_better_default_window_key_mapping = 0

        " Override some of its options
        " TODO: move these options to an "after" config instead?
        runtime! plugin/default.vim

        set scrolljump=1
        set wrap

        " Don't pollute the current working directory with this nonsense.
        " The double trailing forward slash at the end of the path tells it to use
        " full paths when storing files, so two files named "foo.txt" don't clobber
        " each other's swaps or backups.
        set directory=~/.vim/tmp/swap//,/tmp/vim/swap//
        set backupdir=~/.vim/tmp/backup//,/tmp/vim/backup//
        if has('persistent_undo')
            set undodir=~/.vim/tmp/undo//,/tmp/vim/undo//
        endif

        " do not persist backup after successful write
        set nobackup

        set listchars=nbsp:·,tab:▸\ ,trail:·,extends:»,precedes:«,eol:¬

        set wildignore=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip,*.o,*.obj,*.so,*.exe

        " TODO: the trouble with :b# is it may switch back to an already-closed
        " buffer (see them still visible via :ls!)
        nnoremap <leader>bd :b#<bar>bd#<CR>

        " Edit text without adding it to the yank stack
        nnoremap <silent> <leader>c "_c
        xnoremap <silent> <leader>c "_c
        nnoremap <silent> <leader>d "_d
        xnoremap <silent> <leader>d "_d

        " TODO: remap U back to undo line?

        " :nohlsearch used to not always work correctly, this was an alternate
        " solution
        " nnoremap <leader>sc :let @/ = ""<CR>

        " Rather have these as shortcuts to more common whole-line functions
        " than to the end-of-line, which can still be accomplished with y$ and
        " d$
        " TODO: maybe not anymore, try default behavior
        " nnoremap Y yy
        " nnoremap D dd

    " }}}

    " vim-better-whitespace {{{

        " Use ALEFix w/ trim_whitespace instead
        " But still want this plugin to highlight trailing whitespace
        let g:strip_whitespace_on_save = 0

    " }}}

    " vim-easymotion {{{

        " s{char}{char} to move to {char}{char}
        nmap s <Plug>(easymotion-overwin-f2)
        xmap s <Plug>(easymotion-overwin-f2)

    " }}}

    " vim-latex-live-preview {{{

        " augroup plug_latex_live_preview
        "     autocmd!
        "     autocmd Filetype tex setl updatetime=1
        " augroup END
        " let g:livepreview_previewer = 'open -a Preview'

    " }}}

    " vim-surround {{{

        " let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
        " let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
        " let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
        " let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
        " let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"

    " }}}

    " vim-togglelist {{{

        let g:toggle_list_no_mappings = 0
        nmap <script> <silent> <leader>tl :call ToggleLocationList()<CR>
        nmap <script> <silent> <leader>tq :call ToggleQuickfixList()<CR>

    " }}}

    " vim-unimpaired {{{

        nmap <Up> <Plug>unimpairedMoveUp
        imap <Up> <C-o><Plug>unimpairedMoveUp
        xmap <Up> <Plug>unimpairedMoveSelectionUpgv
        nmap <Down> <Plug>unimpairedMoveDown
        imap <Down> <C-o><Plug>unimpairedMoveDown
        xmap <Down> <Plug>unimpairedMoveSelectionDowngv

    " }}}

    " vimwiki {{{

        let g:vimwiki_list = [
            \ {
                \ 'path': '~/tmp/repos/github.com/Pewpewarrows/notebook',
                \ 'syntax': 'markdown',
                \ 'ext': '.md',
            \ },
        \ ]

    " }}}

" }}}

" Local {{{

    if filereadable(expand('~/.vimrc.local'))
        source ~/.vimrc.local
    endif

" }}}
