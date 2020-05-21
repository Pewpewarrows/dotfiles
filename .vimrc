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
" - asyncrun/dispatch/neomake project-wide build/lint/test errorformat parsing

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

    " TODO: have a minimal plugin set to switch to temporarily if a big
    " breaking change occurs and some emergency editing needs to happen, but
    " don't need to go as extreme as not loading the vimrc altogether

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
    Plug 'tpope/vim-eunuch'

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
    Plug 'majutsushi/tagbar'
    Plug 'ludovicchabant/vim-gutentags'

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
    " Plug 'xuhdev/vim-latex-live-preview'
    " " Plug 'gilligan/vim-lldb'
    " Plug 'ARM9/arm-syntax-vim'
    " Plug 'junegunn/vim-peekaboo'
    " Plug 'dag/vim-fish'
    " TODO: Indent Guides, tmux-nav, go, numbers, localvimrc, yankring, slime,
    "       scratch, rainbow parenths, vim-instant-markdown, lexical, riv?,
    "       butane?, seek?, incsearch, projectionist?

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
    set spellfile="$HOME/.vim/spell/en.utf-8.add"

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
    autocmd CmdWinEnter * nnoremap <buffer> <CR> <CR>

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

    " romainl/text-objects.vim {{{

        " 24 simple text objects
        " ----------------------
        " i_ i. i: i, i; i| i/ i\ i* i+ i- i#
        " a_ a. a: a, a; a| a/ a\ a* a+ a- a#
        for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
            execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
            execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
            execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
            execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
        endfor

        " line text objects
        " -----------------
        " il al
        xnoremap il g_o^
        onoremap il :<C-u>normal vil<CR>
        xnoremap al $o0
        onoremap al :<C-u>normal val<CR>

        " number text object (integer and float)
        " --------------------------------------
        " in
        function! VisualNumber()
            call search('\d\([^0-9\.]\|$\)', 'cW')
            normal v
            call search('\(^\|[^0-9\.]\d\)', 'becW')
        endfunction
        xnoremap in :<C-u>call VisualNumber()<CR>
        onoremap in :<C-u>normal vin<CR>

        " buffer text objects
        " -------------------
        " i% a%
        xnoremap i% :<C-u>let z = @/\|1;/^./kz<CR>G??<CR>:let @/ = z<CR>V'z
        onoremap i% :<C-u>normal vi%<CR>
        xnoremap a% GoggV
        onoremap a% :<C-u>normal va%<CR>

        " square brackets text objects
        " ----------------------------
        " ir ar
        xnoremap ir i[
        xnoremap ar a[
        onoremap ir :normal vi[<CR>
        onoremap ar :normal va[<CR>

        " block comment text objects
        " --------------------------
        " i? a?
        xnoremap a? [*o]*
        onoremap a? :<C-u>normal va?V<CR>
        xnoremap i? [*jo]*k
        onoremap i? :<C-u>normal vi?V<CR>

        " last change text object
        " -----------------------
        " ik ak
        xnoremap ik `]o`[
        onoremap ik :<C-u>normal vik<CR>
        onoremap ak :<C-u>normal vikV<CR>

    " }}}

" }}}

" File Types {{{

    " TODO: move these to ftplugins?
    augroup filetype_improvements
        autocmd!
        " Options per filetype
        autocmd FileType gitcommit setlocal spell textwidth=72 colorcolumn=51,73
        autocmd FileType mail setlocal spell
        autocmd FileType markdown setlocal spell textwidth=0
        autocmd FileType netrw setlocal bufhidden=wipe
        autocmd FileType rst setlocal spell
        autocmd FileType vim setlocal keywordprg=:help
        " TODO: decide on one of these
        autocmd FileType vimwiki set filetype=markdown
        " autocmd FileType vimwiki setfiletype markdown
        " TODO: potentially `set complete+=kspell` for prose filetypes
        " TODO: detecting certain .conf files for dosini filetype?
        " autocmd FileType fish compiler fish
        " autocmd FileType fish setlocal foldmethod=expr
        " Filetypes per extension
        autocmd BufNewFile,BufRead *.c setfiletype c.doxygen
        autocmd BufNewFile,BufRead *.h,*.cpp setfiletype doxygen
        " TODO: might want to do something fancy like:
        " function DetectGoHtmlTmpl()
        "     if search("{{") != 0
        "         set filetype=gohtmltmpl
        "     endif
        " endfunction
        " autocmd BufNewFile,BufRead *.html call DetectGoHtmlTmpl();
        " TODO: could also do the same with {{ and/or {% for django templates
        " TODO: unfortunately for both it won't help for new files
        autocmd BufNewFile,BufRead *.html setfiletype gohtmltmpl.htmldjango.html
        " autocmd BufNewFile,BufRead *.json setfiletype javascript
        autocmd BufNewFile,BufRead *.csslintrc,*.prettierrc,*.stylelintrc setfiletype json
        autocmd BufNewFile,BufRead *.py setfiletype python.django
        autocmd BufNewFile,BufRead {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} setfiletype ruby
    augroup END

    " TODO: consider this for ensuring dirs exist to new file
    " au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" }}}

" Plugin Configuration {{{

    " airline {{{

        " TODO: this is a massive performance hog, replace it

        let g:airline#extensions#tabline#enabled = 1
        let g:airline_powerline_fonts = 1
        " TODO: get rid of encoding, line progress, and column count

    " }}}

    " ale {{{

        let g:ale_fixers = {}
        let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']
        let g:ale_fixers.css = ['prettier', 'stylelint']
        let g:ale_fixers.html = ['prettier']
        let g:ale_fixers.json = ['prettier']
        let g:ale_fixers.markdown = ['prettier']
        let g:ale_fixers.python = ['black']
        let g:ale_fixers.rust = ['rustfmt']
        let g:ale_fixers.vim = ['ale_custom_linting_rules']

        let g:ale_linters = {}
        let g:ale_linters.html = ['fecs', 'htmlhint', 'stylelint', 'tidy']
        " languagetool is slow and clunky, run it manually outside of vim
        let g:ale_linters.markdown = ['markdownlint', 'mdl', 'remark_lint']
        " TODO: add 'pyre' back to here after fixing its buck problem
        let g:ale_linters.python = ['prospector']
        let g:ale_linters.rst = ['rstcheck']

        let g:ale_css_stylelint_options = '--config-basedir $(npm root --global)'
        let g:ale_html_stylelint_options = '--config-basedir $(npm root --global)'
        let g:ale_markdown_mdl_options = '--rules ~MD013'
        " TODO: --doc-warnings --test-warnings
        let g:ale_python_prospector_options = '--profile $HOME/.prospector.yaml --with-tool mypy --with-tool pep257 --with-tool pyroma --with-tool vulture --with-tool bandit'
        let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
        let g:ale_scss_stylelint_options = g:ale_css_stylelint_options
        let g:ale_stylelint_options = g:ale_css_stylelint_options

        nmap <leader>af <Plug>(ale_fix)
        nmap <leader>al <Plug>(ale_lint)
        " TODO: evaluate unimpaired loclist bindings, maybe use instead
        nmap <leader>aj <Plug>(ale_next_wrap)
        nmap <leader>ak <Plug>(ale_previous_wrap)
        nnoremap <leader>at :ALEToggle<CR>

        function! ALELintWriting()
            let l:heavy_text_linters = ['alex', 'proselint', 'redpen', 'textlint', 'vale', 'writegood']
            let l:original_ale_linters_markdown = g:ale_linters.markdown
            let l:original_ale_linters_rst = g:ale_linters.rst
            let g:ale_linters.markdown = l:original_ale_linters_markdown + l:heavy_text_linters
            let g:ale_linters.rst = l:original_ale_linters_rst + l:heavy_text_linters
            " TODO: calling this plug line did not seem to have any effect,
            "       using following line instead for now, but would like to
            "       eventually know why
            " execute 'normal \<plug>(ale_lint)'
            execute 'ALELint'
            let g:ale_linters.markdown = l:original_ale_linters_markdown
            let g:ale_linters.rst = l:original_ale_linters_rst
        endfunction

        command! ALELintWriting call ALELintWriting()

        nnoremap <leader>aw :ALELintWriting<CR>

        " TODO: evaluate some of these old syntastic configs for C-lang dev
        " TODO: make a brew formula for sparse and add it here
        "       https://sparse.wiki.kernel.org/index.php/Main_Page
        " Other c checkers to situationally use: checkpatch
        " let g:syntastic_c_checkpatch_args = '--ignore CODE_INDENT,LEADING_SPACE,C99_COMMENTS,OPEN_BRACE'
        " let g:syntastic_c_compiler_options = '-std=c11 -Wall -Wextra -Wformat=2 -pedantic -Wshadow -Wstrict-overflow -fno-strict-aliasing -Wpointer-arith'

        " could use g:ale_command_wrapper to wrap nodejs utils in npx for heavy
        " isolation, but not keen on the install/remove overhead every time it
        " runs, so put up with having those utils installed globally/locally
        " for now

    " }}}

    " asyncrun.vim {{{

        let g:asyncrun_bell = 1

        nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test<CR>
        nnoremap <silent> <F7> :AsyncRun -cwd=<root> make<CR>
        nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run<CR>
        " TODO: run current single file? lint?

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

        let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
        let g:fzf_history_dir = '~/.local/share/fzf-history'

        " let g:fzf_preview_window = 'right:50%'

        " TODO: previews everywhere
        " TODO: maybe by using yuki-ycino/fzf-preview.vim instead of manually
        " TODO: -bind alt-a:select-all,alt-d:deselect-all,alt-t:toggle-all
        " TODO: add hidden files: https://github.com/junegunn/fzf/issues/337

        function! FZFWithDevIcons(qargs)
            " TODO: use $FZF_PREVIEW_FILE_COMMAND here
            " TODO: final arg to bat, {2..}, {2..-1} ?
            let l:fzf_files_options = ' --multi --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up --preview "bat --color always --style numbers {2..}"'

            function! s:files(dir)
                let l:cmd = "$FZF_DEFAULT_COMMAND"
                if a:dir != ''
                    let l:cmd .= ' ' . shellescape(a:dir)
                endif
                let l:files = split(system(l:cmd.' | devicon-lookup'), '\n')
                return l:files
            endfunction

            function! s:edit_file(items)
                let items = a:items
                let i = 1
                let ln = len(items)
                while i < ln
                    let item = items[i]
                    let parts = split(item, ' ')
                    let file_path = get(parts, 1, '')
                    let items[i] = file_path
                    let i += 1
                endwhile
                call s:Sink(items)
            endfunction

            let opts = fzf#wrap({})
            let opts.source = <sid>files(a:qargs)
            let s:Sink = opts['sink*']
            let opts['sink*'] = function('s:edit_file')
            let opts.options .= l:fzf_files_options
            call fzf#run(opts)
        endfunction

        function! FZFWipeout()
            function! s:list_buffers()
                redir => list
                silent ls
                redir END
                return split(list, "\n")
            endfunction

            function! s:delete_buffers(lines)
                execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
            endfunction

            let opts = fzf#wrap({})
            let opts.source = <sid>list_buffers()
            let opts['sink*'] = { lines -> s:delete_buffers(lines) }
            let opts.options = '--multi --reverse --bind ctrl-a:select-all+accept'
            call fzf#run(opts)
        endfunction

        " TODO: remove me
        " command! BD call fzf#run(fzf#wrap({
        "   \ 'source': s:list_buffers(),
        "   \ 'sink*': { lines -> s:delete_buffers(lines) },
        "   \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
        " \ }))

        " Overriding fzf.vim's default :Files command.
        " Pass zero or one args to Files command (which are then passed to FZFWithDevIcons). Support file path completion too.
        " TODO: sadly, piping to devicon-lookup causes fzf to block until
        "       scanning completes, which is too costly to replace :Files as
        "       a default, so make a new command for now until fixed
        " command! -nargs=? -complete=file Files call FZFWithDevIcons(<q-args>)
        command! -nargs=? -complete=file FilesWithDevIcons call FZFWithDevIcons(<q-args>)

        command! -nargs=? -complete=buffer Wipeouts call FZFWipeout()

        nnoremap <leader>bb :Buffers<CR>
        nnoremap <leader>bw :Wipeouts<CR>
        nnoremap <leader>f<Space> :Commands<CR>
        nnoremap <leader>ff :Files<CR>
        nnoremap <leader>fd :FilesWithDevIcons<CR>
        nnoremap <leader>fh :History<CR>
        " TODO: :History queries the .viminfo file, which is only regenerated
        " upon quitting vim, need a better MRU plugin or fzf config that will
        " account for files opened during the current session
        nnoremap <leader>f: :History:<CR>
        nnoremap <leader>f/ :History/<CR>
        nnoremap <leader>f' :Marks<CR>
        nnoremap <leader>fl :BLines<CR>
        nnoremap <leader>fL :Lines<CR>
        nnoremap <leader>ft :BTags<CR>
        nnoremap <leader>fT :Tags<CR>
        nnoremap <leader>fm :Maps<CR>
        nnoremap <leader>fy :Filetypes<CR>
        nnoremap <leader>fH :Helptags!<CR>
        nnoremap <leader>rg :Rg<Space>
        " TODO: close buffer while browsing them via :Buffers

        command! Todo execute ":Rg! [T]O[_ ]?DO|[F]IX[_ ]?ME|[X]XX|[H]ACK|[^(DE)|^_][B]UG|[R]EVIEW|[W]TF|[S]MELL|[B]ROKE|[N]OCOMMIT|[N]ORELEASE"
        nnoremap <leader>T :Todo<cr>

        " TODO: make work w/ devicons
        command! FilesFlat call fzf#run(fzf#wrap({'source': '$FZF_DEFAULT_COMMAND --max-depth 1'}))
        nnoremap <leader>fa :FilesFlat<CR>

        " TODO: make work w/ devicons
        command! FilesShallow call fzf#run(fzf#wrap({'source': '$FZF_DEFAULT_COMMAND --max-depth 4'}))
        nnoremap <leader>fw :FilesShallow<CR>

        " TODO: <leader>p bind for an all-in-one buffers/MRU/files/tags filter,
        "       prioritized in that order, for now it's extra bind to :Buffers
        nnoremap <leader>p :Buffers<CR>

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

    " tagbar {{{

        " Adding new filetype support: https://github.com/majutsushi/tagbar/wiki

        nnoremap <silent> <F9> :TagbarOpenAutoClose<CR>

        " TODO: markdown outlines aren't nested correctly, look into:
        " https://github.com/majutsushi/tagbar/wiki#markdown
        " https://github.com/lvht/tagbar-markdown

        let g:tagbar_type_make = {
            \ 'kinds':[
                \ 'm:macros',
                \ 't:targets'
            \ ]
        \ }

        let g:rust_use_custom_ctags_defs = 1  " TODO: only if using rust.vim
        " TODO: hardcoded ctags path?
        let g:tagbar_type_rust = {
            \ 'ctagsbin' : '/usr/local/bin/ctags',
            \ 'ctagstype' : 'rust',
            \ 'kinds' : [
                \ 'n:modules',
                \ 's:structures:1',
                \ 'i:interfaces',
                \ 'c:implementations',
                \ 'f:functions:1',
                \ 'g:enumerations:1',
                \ 't:type aliases:1:0',
                \ 'v:constants:1:0',
                \ 'M:macros:1',
                \ 'm:fields:1:0',
                \ 'e:enum variants:1:0',
                \ 'P:methods:1',
            \ ],
            \ 'sro': '::',
            \ 'kind2scope' : {
                \ 'n': 'module',
                \ 's': 'struct',
                \ 'i': 'interface',
                \ 'c': 'implementation',
                \ 'f': 'function',
                \ 'g': 'enum',
                \ 't': 'typedef',
                \ 'v': 'variable',
                \ 'M': 'macro',
                \ 'm': 'field',
                \ 'e': 'enumerator',
                \ 'P': 'method',
            \ },
        \ }

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

        " think all the buggy behavior related to switching back to unlisted
        " buffers has been fixed, if not try out moll/vim-bbye
        nnoremap <silent> <leader>bd :bp<bar>bd#<CR>

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
    "
    " vim-gutentags {{{

        let g:gutentags_cache_dir = expand('~/.cache/gutentags/')
        " TODO: very large markdown files seem to block the foreground process upon save

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

        let g:vimwiki_global_ext = 0

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
