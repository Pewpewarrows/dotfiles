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
" - :help changelist
" - :help text-objects
" - :help format-comments
" - :help formatoptions
" - :help fo-table
" - macros for inserting and editing various comment headers in several langs:
"   http://vi.stackexchange.com/questions/415/adding-80-column-wide-comment-header-block-with-centered-text
" - :verbose set shiftwidth?
" - asyncrun/dispatch/neomake project-wide build/lint/test errorformat parsing

" profiling startup:
" $ vim --startuptime profile.log
" consider https://github.com/hyiltiz/vim-plugins-profile

" profiling specific action:
" :profile start profile.log
" :profile file *
" :profile func *
" <slow-action> (such as :e slowfile.ext)
" :profile pause
" :noautocmd qall!

" Preamble {{{

    " Must be first to prevent unwanted side-effects
    set nocompatible

" }}}

" Helpers {{{

    let s:minimode = exists('$MINIVIM')
    let s:vscode = exists('g:vscode')

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
    " got mini_vimrc working, but check if there's a better way overall

    " Options
    Plug 'tpope/vim-sensible'
    Plug 'liuchengxu/vim-better-default'
    " Plug 'embear/vim-localvimrc'

    " Theme
    " Plug 'dracula/vim', {'as': 'dracula'}
    Plug 'morhetz/gruvbox'
    " Plug 'arzg/vim-colors-xcode' " dark / high-contrast

    if !s:minimode

    " Help
    " Plug 'liuchengxu/vim-which-key'
    " Plug 'rizzatti/dash.vim'
    " Plug 'lifepillar/vim-cheat40'
    " Plug 'Shougo/echodoc.vim' " TODO: necessary given coc's preview popup?
    " Plug 'laher/fuzzymenu.vim'

    " Learning
    " " TODO: molasses or mediummode instead of hardmode?
    " Plug 'wikitopian/hardmode'
    " Plug 'ThePrimeagen/vim-be-good'
    " Plug 'jmoon018/PacVim'
    " Plug 'takac/vim-hardtime'
    " Plug 'AlphaMycelium/pathfinder.vim' " try to find the most optimal navigation motion from point A to B

    " Plugin Development
    Plug 'dstein64/vim-startuptime'
    " Plug 'mattn/webapi-vim' " also needed by gist-vim

    " Appearance
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'
    Plug 'maximbaz/lightline-ale'
    Plug 'ryanoasis/vim-devicons'
    Plug 'junegunn/goyo.vim' " distraction-free mode
    Plug 'junegunn/limelight.vim' " spotlight on current text
    " TODO: choose one
    " Plug 'norcalli/nvim-colorizer.lua'
    " Plug 'RRethy/vim-hexokinase'
    " Plug 'ap/vim-css-color'
    " Plug 'skammer/vim-css-color'
    " <end-choice>
    " Plug 'luochen1990/rainbow'
    " Plug 'roman/golden-ratio'
    " Plug 'camspiers/lens.vim' " alternative auto window resizer
    " TODO: choose either
    " Plug 'nathanaelkane/vim-indent-guides'
    " Plug 'Yggdroot/indentLine'
    " TODO:
    " `let g:indentLine_char = '▏'`
    " `let g:indentLine_faster = 1`
    " `let g:indentLine_setConceal = 0`
    " TODO: choose either
    " Plug 'psliwka/vim-smoothie'
    " Plug 'yuttie/comfortable-motion.vim'
    " Plug 'naddeoa/vim-visual-page-percent'
    " Plug 'machakann/vim-highlightedyank'
    " TODO: or other scrollbar or minimap-like emulation
    " Plug 'drzel/vim-line-no-indicator'
    " Plug 'wellle/context.vim'
    " Plug 'TaDaa/vimade' " fades inactive windows
    " Plug 'jaxbot/semantic-highlight.vim' " alternative to syntax highlighting, emphasizes vars instead
    " Plug 'liuchengxu/eleline.vim' " alternative statusline
    " Plug 'reedes/vim-wheel' " keep cursor line centered, TODO: just use scrolloff=999?

    " Project Management
    " - sessions
    Plug 'tpope/vim-obsession'
    Plug 'dhruvasagar/vim-prosession'
    " Plug 'mhinz/vim-startify'
    " - external commands (build, run, test)
    Plug 'skywind3000/asyncrun.vim'
    " Plug 'igemnace/vim-makery' " enhancements to builtin :make
    " Plug 'tpope/vim-dispatch'
    " TODO: neomake over dispatch?
    " - version control
    Plug 'tpope/vim-fugitive'
    " Plug 'rbong/vim-flog'
    " TODO: choose either
    " Plug 'airblade/vim-gitgutter'
    " Plug 'mhinz/vim-signify'
    " Plug 'mattn/gist-vim'
    " Plug 'jreybert/vimagit'
    Plug 'rhysd/git-messenger.vim'
    " Plug 'AndrewRadev/linediff.vim'
    " - file management
    Plug 'tpope/vim-eunuch' " file management with Ex commands
    " - misc
    " Plug 'vim-ctrlspace/vim-ctrlspace'
    " TODO: choose either
    " Plug 'mbbill/undotree'
    " Plug 'simnalamburt/vim-mundo'
    " Plug 'Soares/butane.vim' " kill buffers for good
    " Plug 'tpope/vim-projectionist'
    " TODO: filereadable, localleader, fzf certain conditional dirs
    Plug 'janko/vim-test'
    " Plug 'puremourning/vimspector'
    " TODO: and/or termdebug built-in
    " Plug 'direnv/direnv.vim'
    Plug 'sgur/vim-editorconfig'
    " Plug 'jpalardy/vim-slime' " repl
    " Plug 'epeli/slimux' " repl
    " Plug 'rhysd/reply.vim' " repl

    " Filetypes
    " TODO: consider this for the commands, but not the syntax or completion
    " Plug 'habamax/vim-godot'
    Plug 'sheerun/vim-polyglot'
    if has('nvim')
        Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install' }
    endif
    Plug 'arzg/vim-rust-syntax-ext', { 'for': 'rust' }
    Plug 'clktmr/vim-gdscript3', { 'for': 'gdscript3' }
    Plug 'pearofducks/ansible-vim', { 'for': 'ansible' }
    " TODO: add this utility func: https://gist.github.com/mtyurt/3529a999af675a0aff00eb14ab1fdde3
    " Plug 'ARM9/arm-syntax-vim'
    " Plug 'xuhdev/vim-latex-live-preview'
    " Plug 'lervag/vimtex'
    " Plug 'brennier/quicktex'
    " Plug 'dag/vim-fish'
    " Plug 'mattn/emmet-vim'
    " Plug 'noahfrederick/vim-skeleton'
    " Plug 'mzlogin/vim-markdown-toc'
    " Plug 'masukomi/vim-markdown-folding'
    " Plug 'plasticboy/vim-markdown'
    " Plug 'mogelbrod/vim-jsonpath'
    " Plug 'tpope/vim-dadbod'
    Plug 'reedes/vim-pencil' " collection of tiny tweaks for prose writing
    " - python
    " Plug 'python-mode/python-mode'
    " Plug 'metakirby5/codi.vim' " live playground results for python code
    " Plug 'jeetsukumaran/vim-pythonsense'
    " Plug 'jmcantrell/virtualenv.vim'
    " Plug 'numirias/semshi'

    " Navigation
    " TODO: this is macOS/homebrew specific
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'pbogut/fzf-mru.vim'
    Plug 'justinmk/vim-dirvish'
    Plug 'osyo-manga/vim-anzu' " search progress status
    Plug 'milkypostman/vim-togglelist' " toggles for quickfix/locationlist
    Plug 'ludovicchabant/vim-gutentags'
    " Plug 'skywind3000/gutentags_plus'
    Plug 'liuchengxu/vista.vim' " sidebar for tags or LSP symbols
    " TODO: determine if provides anything over sensible's binds
    " Plug 'tpope/vim-rsi'
    Plug 'kshenoy/vim-signature' " show marks in sidebar
    Plug 'haya14busa/incsearch.vim' " better incsearch
    Plug 'myusuf3/numbers.vim' " intelligent auto-toggle of relativenumber
    " Plug 'Dkendal/fzy-vim' " TODO: over fzf? then use srstevenson/vim-picker?
    Plug 'rhysd/clever-f.vim' " improved f/t movement
    " TODO:
    " `let g:clever_f_across_no_line = 1`
    " `let g:clever_f_fix_key_direction = 1`
    " TODO: instead of file beagle or vinegar or vifm or nnn?
    " Plug 'francoiscabrol/ranger.vim'
    " Plug 'tweekmonster/fzf-filemru'
    " Plug 'justinmk/vim-sneak'
    " TODO: sneak label mode
    " Plug 'yuki-ycino/fzf-preview.vim'
    " Plug 'unkarkat/vim-mark' " custom highlights for words while reading
    " Plug 'RRethy/vim-illuminate' " highlight word under cursor
    " Plug 'lfv89/vim-interestingwords' " highlight word under cursor
    " TODO: maybe remove quick-scope
    " Plug 'unblevable/quick-scope' " easily find f/t targets
    " Plug 'andymass/vim-matchup' " improved builtin matchit
    " Plug 'nelstrom/vim-visual-star-search'
    " Plug 'haya14busa/vim-asterisk' " improved * navigation
    " Plug 'romainl/vim-cool' " intelligent auto toggle for search highlighting

    " Editing
    Plug 'Lokaltog/vim-easymotion'
    Plug 'tpope/vim-commentary'
    " TODO: choose either
    Plug 'tpope/vim-surround'
    " Plug 'machakann/vim-sandwich'
    " TODO:
    " if using sandwich, may have to fix a couple of things
    " surround-compatible mappings: https://github.com/machakann/vim-sandwich/wiki/Introduce-vim-surround-keymappings
    " if highlighting is annoying: `operator#sandwich#set('all', 'all', 'highlight', 0)`
    " space-wrapped mappings: https://github.com/machakann/vim-sandwich/issues/33
    Plug 'tpope/vim-unimpaired'
    Plug 'tmsvg/pear-tree'
    Plug 'honza/vim-snippets'
    " TODO: this heuristic runs super slow on larger files?
    " Plug 'tpope/vim-sleuth' " detect options from current file conventions
    " TODO: choose one of three
    " Plug 'terryma/vim-expand-region'
    " Plug 'rhysd/vim-textobj-anyblock'
    " Plug 'gcmt/vim-wildfire' " smart selection of closest text objects
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-repeat'
    " TODO: maybe not, no use cases left not already covered by builtins
    " Plug 'terryma/vim-multiple-cursors'
    Plug 'junegunn/vim-peekaboo' " peek at contents of registers
    " Plug 'vim-scripts/YankRing.vim'
    " Plug 'svermeulen/vim-easyclip' " improved clipboard
    " Plug 'mtth/scratch.vim'
    " Plug 'markonm/traces.vim' " TODO: or just use neovim's inccommand
    " Plug 'kkoomen/vim-doge'
    Plug 'da-x/name-assign.vim'
    " Plug 'AndrewRadev/inline_edit.vim'
    " Plug 'tpope/vim-speeddating'
    " Plug 'haya14busa/vim-edgemotion'
    " Plug 'drzel/vim-split-line'
    " Plug 'FooSoft/vim-argwrap' " reformatting to/from single/multiline function calls, arrays, dicts
    " Plug 'PeterRincker/vim-argumentative'
    " Plug 'AndrewRadev/sideways.vim' " function arguments
    " - alignment
    " " TODO: easy-align instead of tabular/table-mode?
    " Plug 'godlygeek/tabular'
    " Plug 'dhruvasagar/vim-table-mode'
    " Plug 'tommcdo/vim-lion' " alignment operations
    " - find/replace, word correction
    Plug 'tpope/vim-abolish' " find-replace across many variations of same word
    " Plug 'pelodelfuego/vim-swoop' " find/replace inspired by helm-swoop
    " Plug 'wincent/ferret' " project-wide find/replace
    " Plug 'stefandtw/quickfix-reflector.vim'
    " TODO: see thoughtbot blog post for config
    " Plug 'kamykn/spelunker.vim' " improved spellcheck
    " Plug 'beloglazov/vim-online-thesaurus'
    " Plug 'reedes/vim-lexical' " improved spellcheck
    " Plug 'reedes/vim-litecorrect' " lightweight auto-correction while typing
    " - text objects
    " Plug 'welle/targets.vim' " commas especially
    " Plug 'kana/vim-textobj-user'
    " [more textobj plugins](https://github.com/kana/vim-textobj-user/wiki), ensure they actually provide benefit over romainl's text-objects.vim and targets.vim
    " Plug 'reedes/vim-textobj-sentences'
    " Plug 'reedes/vim-textobj-quote'
    " Plug 'thalesmello/vim-textobj-multiline-str'
    " Plug 'Julian/vim-textobj-variable-segment'
    " TODO: and/or chaoren/vim-wordmotion, but fixup with `nmap cw ce` and `nmap cW cE`
    " Plug 'michaeljsmith/vim-indent-object'
    " Plug 'jeetsukumaran/vim-indentwise'
    " Plug 'christoomey/vim-sort-motion'

    " Language Server Protocol
    " (Diagnostics, Code Completion, References, Formatting)
    Plug 'w0rp/ale'
    if has('nvim')
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
    endif
    " Plug 'antoinemadec/coc-fzf'
    " TODO: local mode only
    " Plug 'codota/tabnine-vim'
    " TODO: vs local/offline kite? kite's company doesn't have a great track record
    " Plug 'desmap/ale-sensible'
    " Plug 'jackguo380/vim-lsp-cxx-highlight'
    " These don't go through LSP but are diagnostics for prose
    Plug 'jamestomasino/vim-writingsyntax' " highlight adjectives, passive language, weasel words
    Plug 'reedes/vim-wordy' " collection of prose linting, not through ALE
    Plug 'dbmrq/vim-ditto' " highlight overused/repeated words

    " Apps
    Plug 'vimwiki/vimwiki'
    " Plug 'AndrewRadev/exercism.vim'
    " Plug 'segeljakt/vim-silicon'

    endif

    call plug#end()

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
    " TODO: may not be visible with kitty and tmux?
    set visualbell  " don't beep at me!
    set diffopt+=vertical
    set nostartofline
    set spellfile="$HOME/.vim/spell/en.utf-8.add"
    set showtabline=2

    " Recommended by coc.vim
    " set cmdheight=2
    set updatetime=300
    set shortmess+=c
    if has("patch-8.1.1564")
        " Recently vim can merge signcolumn and number column into one
        set signcolumn=number
    else
        set signcolumn=yes
    endif

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

    if &t_Co >= 256 || has('gui_running')
        " TODO: test for colorschemes, have backups
        if has#colorscheme('gruvbox')
            colorscheme gruvbox
        endif
        " if has#colorscheme('dracula')
        "     colorscheme dracula
        " endif
    endif

    if has('gui_running')
        " TODO: test for fonts, have backups
        " set guioptions-=T
        " set guioptions-=e " disable graphical tabline
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
    augroup reload_vimrc
        autocmd!
        " TODO: causes weird visual artifacts / incorrect colors on reload
        " autocmd BufWritePost $MYVIMRC,.vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
    augroup END

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
    " TODO: simplified? *``cgn
    nnoremap c* /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``cgn
    " TODO: simplified? #``cgn
    nnoremap c# /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``cgN
    nnoremap d* /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgn
    nnoremap d# /\<<C-r>=expand('<cword>')<CR>\>\C<CR>``dgN
    " TODO: make these work with a visual selection
    " https://old.reddit.com/r/vim/comments/2p6jqr/quick_replace_useful_refactoring_and_editing_tool/

    xnoremap <CR> :
    augroup default_cr_in_qf_and_cmds
        autocmd!
        autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
        autocmd CmdWinEnter * nnoremap <buffer> <CR> <CR>
    augroup END

    nnoremap <leader>wH <C-w>5<
    nnoremap <leader>wL <C-w>5>
    nnoremap <leader>wJ :resize +5<CR>
    nnoremap <leader>wK :resize -5<CR>

    " ? http://vim.wikia.com/wiki/Copy_or_change_search_hit

    " Improved tab movement
    " nnoremap <leader>h :tabprevious<CR>
    " nnoremap <leader>l :tabnext<CR>
    " nnoremap <leader>tn :tabnew<CR>
    " nnoremap <leader>td :tabclose<CR>

    " Improved buffer movement
    nnoremap <PageUp> :bprevious<CR>
    nnoremap <PageDown> :bnext<CR>
    " nnoremap <leader>n :enew<CR>
    nnoremap <leader>bx :bd!<CR>

    " Quickly switch to last buffer, like alt+tab. can also use <C-^> or <C-6>
    nnoremap <leader><tab> :b#<CR>
    nnoremap <bs> :b#<CR>

    " Stupid help menu right next to the Esc key...
    " inoremap <F1> <Esc>
    " nnoremap <F1> <Esc>
    " vnoremap <F1> <Esc>

    " Plain arrows for bubbling text
    " For the <Up> and <Down> binds, see vim-unimpaired config below
    " TODO: for better versions of all of these consider https://github.com/matze/vim-move
    nnoremap <Left> <<
    inoremap <Left> <C-o><<
    xnoremap <Left> <gv
    nnoremap <Right> >>
    inoremap <Right> <C-o>>>
    xnoremap <Right> >gv

    " Control-arrows conflict with macOS Mission Control shortcuts
    " TODO: Shift-arrows for splits, Alt-arrows for resizing splits? Duplicate lines?

    " TODO: find usable mappings for these
    " nnoremap <S-C-k> dd
    " duplicate the selection
    vnoremap D y`]pgv
    " nnoremap <S-C-d> yyp
    " inoremap <S-C-d> <Esc>yypa

    " Re-select text
    " nnoremap <leader>v V`]
    nnoremap gV `[v]`

    " Paragraph text wrapping galore
    " Q is legacy cruft, remap it, anything that you might need it for use `gQ` instead
    nnoremap <silent> Q gqap
    xnoremap <silent> Q gq
    nnoremap <silent> <leader>Q gqip

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

    nnoremap <leader>l :syntax sync fromstart<CR>

    " yank whole file
    nnoremap <leader>yy :%y+<CR>

    " press <Tab>/<S-Tab> to move to next match during incremental search
    " TODO: this seems to kill tab-completion in Ex mode?
    " cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
    " cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

    " project-wide find/replace requires more advanced/manual intervention, but
    " for quick paragraph and file-wide replacements:
    nnoremap <leader>rp :'{,'}s/\<<C-r>=expand("<cword>")<CR>\>/
    nnoremap <leader>r% :%s/\<<C-r>=expand("<cword>")<CR>\>/
    " replace current visual selection with yank buffer
    vnoremap <leader>rr "_dP

    " page facing view: side-by-side view of same buffer scrollbound
    nnoremap <leader>vs :<C-u>let @z=&so<cr>:set so=0 noscb<cr>:bo vs<cr>Ljzt:setl scb<cr><C-w>p:setl scb<cr>:let &so=@z<cr>

    " quick save
    nnoremap <silent> <leader><CR> :update<CR>

    " fun map ideas
    " <leader>/ search-related?

    " finish with the macro letter and hit enter to run the macro on each line
    " individually
    vnoremap <leader>@ :normal @

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
        autocmd FileType yaml setlocal softtabstop=2
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
        " TODO: hardcoded paths
        autocmd BufNewFile ~/tmp/repos/github.com/Pewpewarrows/notebook/diary/*.md :silent 0r !vimwiki-diary-entry-template "$HOME/tmp/repos/github.com/Pewpewarrows/notebook/diary/template.md" --destination-filename '%'
    augroup END

    " TODO: consider this for ensuring dirs exist to new file
    " au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" }}}

" Plugin Configuration {{{

    " TODO: configs to add
    " - vim-endwise
    " - git-messenger.vim
    " - incsearch.vim
    " - clever-f.vim
    " - vim-peekaboo
    " - vim-abolish
    " - name-assign.vim
    " - vim-signature
    " - vim-writingsyntax
    " - vim-wordy
    " - vim-ditto

    " ale {{{

        let g:ale_fixers = {}
        let g:ale_fixers['*'] = ['remove_trailing_lines', 'trim_whitespace']
        let g:ale_fixers.c = ['clang-format']
        let g:ale_fixers.css = ['prettier', 'stylelint']
        let g:ale_fixers.html = ['prettier']
        let g:ale_fixers.json = ['prettier']
        let g:ale_fixers.markdown = ['prettier']
        let g:ale_fixers.python = ['black']
        " TODO: consider also getting rufo, standardrb, sorbet
        let g:ale_fixers.ruby = ['rubocop']
        let g:ale_fixers.rust = ['rustfmt']
        let g:ale_fixers.swift = ['swiftformat']
        let g:ale_fixers.vim = ['ale_custom_linting_rules']
        let g:ale_fixers.yaml = ['prettier']

        let g:ale_linters = {}
        let g:ale_linters.html = ['fecs', 'htmlhint', 'stylelint', 'tidy']
        " languagetool is slow and clunky, run it manually outside of vim
        let g:ale_linters.markdown = ['markdownlint', 'mdl', 'remark_lint']
        " TODO: add 'pyre' back to here after fixing its buck problem
        let g:ale_linters.python = ['prospector']
        let g:ale_linters.rst = ['rstcheck']
        let g:ale_linters.yaml = ['yamllint']

        let g:ale_css_stylelint_options = '--config-basedir $(npm root --global)'
        let g:ale_html_stylelint_options = '--config-basedir $(npm root --global)'
        let g:ale_markdown_mdl_options = '--rules ~MD013'
        " TODO: --doc-warnings --test-warnings --with-tool vulture
        let g:ale_python_prospector_options = '--profile $HOME/.prospector.yaml --with-tool mypy --with-tool pep257 --with-tool pyroma --with-tool bandit'
        let g:ale_rust_cargo_check_all_targets = 1
        let g:ale_rust_cargo_check_tests = 1
        let g:ale_rust_cargo_check_examples = 1
        let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
        " TODO: -W clippy::expect_used -W clippy::unwrap_in_result -W clippy::unwrap_used
        let g:ale_rust_cargo_clippy_options = '-W clippy::all -W clippy::pedantic -W clippy::filetype_is_file -W clippy::indexing_slicing -W clippy::todo -W clippy::unimplemented -W clippy::unreachable'
        let g:ale_scss_stylelint_options = g:ale_css_stylelint_options
        let g:ale_stylelint_options = g:ale_css_stylelint_options
        " TODO: make headless work on macOS via noah or docker
        " let g:ale_gdscript3_godotheadless_executable = '$HOME/Private/Software/Tools/Godot_v3.2.2-stable_linux_headless.64'
        " let g:ale_gdscript3_godotheadless_executable = '/Applications/Godot.app/Contents/MacOS/Godot'

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

        " Trigger completion with characters ahead and navigate.
        inoremap <silent><expr> <TAB>
                    \ pumvisible() ? "\<C-n>" :
                    \ <SID>check_back_space() ? "\<TAB>" :
                    \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        if has('nvim')
            " Force to trigger completion.
            inoremap <silent><expr> <c-space> coc#refresh()
        else
            inoremap <silent><expr> <c-@> coc#refresh()
        endif

        " Confirm completion, `<C-g>u` means break undo chain at current
        " position. Coc only does snippet and additional edit on confirm.
        " TODO: conflict with pear-tree and endwise <CR> mappings?
        if exists('*complete_info')
            inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        else
            inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        endif

        " Navigate diagnostics
        " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " GoTo code navigation.
        " TODO: don't clobber built-in gd, find another bind
        " nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)

        " Show documentation in preview window.
        " TODO: same, don't clobber K
        " nnoremap <silent> K :call <SID>show_documentation()<CR>

        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction

        " Highlight the symbol and its references when holding the cursor.
        autocmd CursorHold * silent call CocActionAsync('highlight')

        " TODO: finish config from https://github.com/neoclide/coc.nvim#example-vim-configuration

        let g:coc_global_extensions = [
            \ 'coc-elixir',
            \ 'coc-json',
            \ 'coc-python',
            \ 'coc-rust-analyzer',
            \ 'coc-snippets',
            \ 'coc-lists',
            \ 'coc-sourcekit',
        \ ]

        " TODO: color highlighted suggestions like https://i.redd.it/yz5xnpl0d7g51.jpg

    " }}}

    " fzf.vim {{{

        let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
        let g:fzf_history_dir = '~/.local/share/fzf-history'
        let g:fzf_preview_window = 'right:50%' " TODO: :hidden ?
        " TODO: border used to be Ignore, find best visible alternative
        let g:fzf_colors =
        \ { 'fg':      ['fg', 'Normal'],
          \ 'bg':      ['bg', 'Normal'],
          \ 'hl':      ['fg', 'Comment'],
          \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
          \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
          \ 'hl+':     ['fg', 'Statement'],
          \ 'info':    ['fg', 'PreProc'],
          \ 'border':  ['fg', 'Comment'],
          \ 'prompt':  ['fg', 'Conditional'],
          \ 'pointer': ['fg', 'Exception'],
          \ 'marker':  ['fg', 'Keyword'],
          \ 'spinner': ['fg', 'Label'],
          \ 'header':  ['fg', 'Comment'] }

        if has('nvim') && !exists('g:fzf_layout')
            augroup fzf
                autocmd!
                autocmd! FileType fzf
                autocmd  FileType fzf set laststatus=0 noshowmode noruler signcolumn=no
                            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler signcolumn=yes
            augroup END
        endif

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

        " without fzf: :buffer *
        nnoremap <leader>bb :Buffers<CR>
        nnoremap <leader>bw :Wipeouts<CR>
        nnoremap <leader>f<Space> :Commands<CR>
        " without fzf: :find *
        nnoremap <leader>ff :Files<CR>
        nnoremap <leader>fd :FilesWithDevIcons<CR>
        nnoremap <leader>fh :History<CR>
        " :History queries the .viminfo file, which is only regenerated upon
        " quitting vim, use the fzf-mru plugin to account for files opened
        " during the current session
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
        nnoremap <leader>* :Rg <C-r>=expand('<cword>')<CR><CR>
        " TODO: close buffer while browsing them via :Buffers

        command! Todo execute ":Rg! [T]O[_ ]?DO|[F]IX[_ ]?ME|[X]XX|[H]ACK|[^(DE)|^_][B]UG|[R]EVIEW|[W]TF|[S]MELL|[B]ROKE|[N]OCOMMIT|[N]ORELEASE"
        nnoremap <leader>T :Todo<cr>

        " TODO: make work w/ devicons
        command! -bang -nargs=? -complete=dir FilesFlat call fzf#vim#files(<q-args>, fzf#vim#with_preview({'source': '$FZF_DEFAULT_COMMAND --max-depth 1'}), <bang>0)
        nnoremap <leader>fa :FilesFlat<CR>

        " TODO: make work w/ devicons
        command! -bang -nargs=? -complete=dir FilesShallow call fzf#vim#files(<q-args>, fzf#vim#with_preview({'source': '$FZF_DEFAULT_COMMAND --max-depth 4'}), <bang>0)
        nnoremap <leader>fw :FilesShallow<CR>

        " TODO: <leader>p bind for an all-in-one buffers/MRU/files/tags filter,
        "       prioritized in that order, for now it's extra bind to :Buffers,
        "       see POC: https://github.com/mike-hearn/vim-combosearch
        nnoremap <leader>p :Buffers<CR>

    " }}}

    " fzf-mru.vim {{{

        nnoremap <leader>fu :FZFMru<CR>

    " }}}

    " gist-vim {{{

        " let g:gist_clip_command = 'pbcopy'
        " let g:gist_detect_filetype = 1
        " let g:gist_open_browser_after_post = 1
        " let g:gist_post_private = 1
        " let g:gist_show_privates = 1
        " let g:gist_update_on_write = 1

    " }}}

    " goyo {{{

        " TODO: more ideas https://github.com/junegunn/goyo.vim/wiki/Customization

        let s:has_plug_limelight = exists('*limelight#execute')
        let s:has_plug_numbers = get(g:, 'enable_numbers', 0)

        function! s:goyo_enter()
            " silent !tmux set status off
            " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
            " set noshowmode
            " set noshowcmd
            " set scrolloff=999

            if s:has_plug_limelight
                Limelight
            endif

            if s:has_plug_numbers
                " silent! NumbersDisable
                call NumbersDisable()

                if !get(g:, 'goyo_linenr', 0)
                    setlocal nonu
                    if exists('&rnu')
                        setlocal nornu
                    endif
                endif
            endif
        endfunction

        function! s:goyo_leave()
            " silent !tmux set status on
            " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
            " set showmode
            " set showcmd
            " set scrolloff=5

            if s:has_plug_limelight
                Limelight!
            endif

            if s:has_plug_numbers
                " silent! NumbersEnable
                call NumbersEnable()
            endif
        endfunction

        augroup plug_goyo
            autocmd!
            " TODO: depends on https://github.com/junegunn/goyo.vim/pull/209
            " autocmd BufLeave goyo_pad setlocal norelativenumber
            autocmd! User GoyoEnter nested call <SID>goyo_enter()
            autocmd! User GoyoLeave nested call <SID>goyo_leave()
        augroup END

    " }}}

    " lightline {{{

        let g:lightline = {}
        " do NOT install shinchu/lightline-gruvbox.vim, use built-in
        let g:lightline.colorscheme = 'gruvbox'
        let g:lightline.separator = { 'left': '', 'right': '' }
        let g:lightline.subseparator = { 'left': '', 'right': '' }
        let g:lightline.active = {}
        let g:lightline.active.left = [ [ 'mode', 'paste' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
        let g:lightline.active.right = [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos' ], [ 'percent', 'lineinfo' ], [ 'filetype' ], [ 'search_status' ] ]
        let g:lightline.tabline = {}
        let g:lightline.tabline.left = [ [ 'buffers' ] ]
        let g:lightline.tabline.right = [ [ 'close' ] ]
        let g:lightline.component = {}
        let g:lightline.component.lineinfo = ' %3l:%-2v'
        let g:lightline.component_function = {}
        let g:lightline.component_function.fugitive = 'LightlineFugitive'
        let g:lightline.component_function.modified = 'LightlineModified'
        let g:lightline.component_function.readonly = 'LightlineReadonly'
        let g:lightline.component_function.search_status = 'anzu#search_status'
        let g:lightline.component_type = {}
        let g:lightline.component_type.buffers = 'tabsel'
        let g:lightline.component_type.linter_checking = 'right'
        let g:lightline.component_type.linter_infos = 'right'
        let g:lightline.component_type.linter_warnings = 'warning'
        let g:lightline.component_type.linter_errors = 'error'
        let g:lightline.component_type.linter_ok = 'right'
        let g:lightline.component_expand = {}
        let g:lightline.component_expand.buffers = 'lightline#bufferline#buffers'
        let g:lightline.component_expand.linter_checking = 'lightline#ale#checking'
        let g:lightline.component_expand.linter_infos = 'lightline#ale#infos'
        let g:lightline.component_expand.linter_warnings = 'lightline#ale#warnings'
        let g:lightline.component_expand.linter_errors = 'lightline#ale#errors'
        let g:lightline.component_expand.linter_ok = 'lightline#ale#ok'
        let g:lightline.component_raw = {}
        let g:lightline.component_raw.buffers = 1

        let g:lightline#ale#indicator_checking = "\uf110"
        let g:lightline#ale#indicator_infos = "\uf129"
        let g:lightline#ale#indicator_warnings = "\uf071"
        let g:lightline#ale#indicator_errors = "\uf05e"
        let g:lightline#ale#indicator_ok = "\uf00c"

        let g:lightline#bufferline#enable_devicons = 1
        let g:lightline#bufferline#unicode_symbols = 1
        let g:lightline#bufferline#clickable = 1

        " TODO: virtualenv, language server status, search progress toggle visible, asyncrun status?
        " Plug 'albertomontesg/lightline-asyncrun'

        " let g:lightline = {
        "       \ 'component_function': {
        "       \   'filename': 'LightlineFilename',
        "       \   'mode': 'LightlineMode',
        "       \ },
        "       \ 'component_type': {
        "       \   'readonly': 'error',
        "       \ },

        function! LightlineModified()
            return &ft =~# 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
        endfunction

        " alternative RO symbols: '' '⭤'
        function! LightlineReadonly()
            return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
        endfunction

        " function! LightLineGitGutter()
        "   if ! exists('*GitGutterGetHunkSummary')
        "         \ || ! get(g:, 'gitgutter_enabled', 0)
        "         \ || winwidth('.') <= 90
        "     return ''
        "   endif
        "   let symbols = [
        "         \ g:gitgutter_sign_added,
        "         \ g:gitgutter_sign_modified,
        "         \ g:gitgutter_sign_removed
        "         \ ]
        "   let hunks = GitGutterGetHunkSummary()
        "   let ret = []
        "   for i in [0, 1, 2]
        "     if hunks[i] > 0
        "       call add(ret, symbols[i] . hunks[i])
        "     endif
        "   endfor
        "   return join(ret, ' ')
        " endfunction

        " function! LightlineFilename()
        "   let fname = expand('%:t')
        "   return fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        "         \ fname =~# '^__Tagbar__\|__Gundo\|NERD_tree' ? '' :
        "         \ &ft ==# 'vimfiler' ? vimfiler#get_status_string() :
        "         \ &ft ==# 'unite' ? unite#get_status_string() :
        "         \ &ft ==# 'vimshell' ? vimshell#get_status_string() :
        "         \ (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
        "         \ (fname !=# '' ? fname : '[No Name]') .
        "         \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
        " endfunction

        function! LightlineFugitive()
            try
                if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*FugitiveHead')
                    " TODO: also show hunk summary
                    let mark = ''  " edit here for cool mark
                    let branch = FugitiveHead()
                    return branch !=# '' ? mark.branch : ''
                endif
            catch
            endtry
            return ''
        endfunction

        " function! LightlineMode()
        "   let fname = expand('%:t')
        "   return fname =~# '^__Tagbar__' ? 'Tagbar' :
        "         \ fname ==# 'ControlP' ? 'CtrlP' :
        "         \ fname ==# '__Gundo__' ? 'Gundo' :
        "         \ fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
        "         \ fname =~# 'NERD_tree' ? 'NERDTree' :
        "         \ &ft ==# 'unite' ? 'Unite' :
        "         \ &ft ==# 'vimfiler' ? 'VimFiler' :
        "         \ &ft ==# 'vimshell' ? 'VimShell' :
        "         \ winwidth(0) > 60 ? lightline#mode() : ''
        " endfunction

        " let g:tagbar_status_func = 'TagbarStatusFunc'

        " function! TagbarStatusFunc(current, sort, fname, ...) abort
        "     return lightline#statusline(0)
        " endfunction

        " augroup alestatus
        "   au!
        "   autocmd User ALELint call lightline#update()
        " augroup end

        " " Syntastic can call a post-check hook, let's update lightline there
        " " For more information: :help syntastic-loclist-callback
        " function! SyntasticCheckHook(errors)
        "     call lightline#update()
        " endfunction

    " }}}

    " limelight.vim {{{

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

    " numbers {{{

        " TODO: depends on https://github.com/junegunn/goyo.vim/pull/209
        " let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m', 'nerdtree', 'Mundo', 'MundoDiff', 'goyo_pad']

    " }}}

    " pear-tree {{{

        let g:pear_tree_smart_openers = 1
        let g:pear_tree_smart_closers = 1
        let g:pear_tree_smart_backspace = 1

    " }}}

    " quick-scope {{{

        " TODO: remove me after below issue fixed
        let g:qs_lazy_highlight = 1
        " TODO: conflicts with clever-f
        " https://github.com/unblevable/quick-scope/issues/55
        " let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

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
            if has('nvim-0.5')
                " New format in https://github.com/neovim/neovim/pull/13973 (f42e932, 2021-04-13).
                " TODO: see if later versions of nvim will auto-migrate undo files
                set undodir=~/.vim/tmp/undo2//,/tmp/vim/undo2//
            else
                set undodir=~/.vim/tmp/undo//,/tmp/vim/undo//
            endif
        endif

        " do not persist backup after successful write
        set nobackup

        set listchars=nbsp:·,tab:▸\ ,trail:·,extends:»,precedes:«,eol:¬

        set wildignore=*swp,*.class,*.pyc,*.png,*.jpg,*.gif,*.zip,*.o,*.obj,*.so,*.exe

        " think all the buggy behavior related to switching back to unlisted
        " buffers has been fixed, if not try out moll/vim-bbye
        " TODO: still one last gotcha: when the buffer we're returning to after
        "       closing has an ALE lint warning/error on the line its on,
        "       requires an extra <CR> press to complete the buffer switch
        nnoremap <silent> <leader>bd :bp<bar>bd#<CR>

        " Edit text without adding it to the yank stack
        nnoremap <silent> <leader>c "_c
        xnoremap <silent> <leader>c "_c
        nnoremap <silent> <leader>d "_d
        xnoremap <silent> <leader>d "_d

        " Make relativenumber and wrap behave with remapping j/k to gj/gk
        " TODO: make this work in visual mode, also does it need silent?
        nnoremap <expr> j v:count ? 'j' : 'gj'
        nnoremap <expr> k v:count ? 'k' : 'gk'

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

        " Improved splits movement
        " set splitbelow
        " set splitright
        nnoremap <leader>\ <C-w>v<C-w>p
        nnoremap <leader><bar> <C-w>v<C-w>p
        nnoremap <leader>- <C-w>s<C-w>p
        nnoremap <leader>_ <C-w>s<C-w>p
        nnoremap <C-h> <C-w>h
        nnoremap <C-j> <C-w>j
        nnoremap <C-k> <C-w>k
        nnoremap <C-l> <C-w>l

    " }}}

    " vim-better-whitespace {{{

        " Use ALEFix w/ trim_whitespace instead
        " But still want this plugin to highlight trailing whitespace
        let g:strip_whitespace_on_save = 0

        nmap <leader>ys :StripWhitespace<CR>

    " }}}

    " vim-easymotion {{{

        " s{char}{char} to move to {char}{char}
        nmap s <Plug>(easymotion-overwin-f2)
        " TODO: can this be used in visual mode?
        xmap s <Plug>(easymotion-overwin-f2)

    " }}}
    "
    " vim-gutentags {{{

        let g:gutentags_cache_dir = expand('~/.cache/gutentags/')
        " TODO: if still experiencing crashes after using vim to write git commit messages, see further potential config changes here: https://github.com/ludovicchabant/vim-gutentags/issues/178#issuecomment-575693926
        let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']

    " }}}

    " vim-latex-live-preview {{{

        " augroup plug_latex_live_preview
        "     autocmd!
        "     autocmd Filetype tex setl updatetime=1
        " augroup END
        " let g:livepreview_previewer = 'open -a Preview'

    " }}}

    " vim-pencil {{{

        nnoremap <leader>tP :TogglePencil

        function! Prose()
            call pencil#init()
            call lexical#init()
            call litecorrect#init()
            call textobj#quote#init()
            call textobj#sentence#init()

            " force top correction on most recent misspelling
            nnoremap <buffer> <c-s> [s1z=<c-o>
            inoremap <buffer> <c-s> <c-g>u<Esc>[s1z=`]A<c-g>u

            " replace common punctuation
            iabbrev <buffer> -- –
            iabbrev <buffer> --- —
            iabbrev <buffer> << «
            iabbrev <buffer> >> »

            " open most folds
            setlocal foldlevel=6

            " replace typographical quotes
            (reedes/vim-textobj-quote)
            map <silent> <buffer> <leader>qc <Plug>ReplaceWithCurly
            map <silent> <buffer> <leader>qs <Plug>ReplaceWithStraight

            " highlight words
            (reedes/vim-wordy)
            noremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
            xnoremap <silent> <buffer> <F8> :<C-u>NextWordy<cr>
            inoremap <silent> <buffer> <F8> <C-o>:NextWordy<cr>

        endfunction

        " invoke manually by command for other file types
        command! -nargs=0 Prose call Prose()

        " augroup pencil
        "     autocmd!
        "     autocmd FileType markdown,mkd call Prose()
        "     autocmd FileType text call Prose()
        "     autocmd Filetype git,gitsendemail,*commit*,*COMMIT*
        "                             \ call pencil#init({'wrap': 'hard', 'textwidth': 72})
        "                             \ | call litecorrect#init()
        "                             \ | setl spell spl=en_us et sw=2 ts=2 noai
        "     autocmd Filetype mail call pencil#init({'wrap': 'hard', 'textwidth': 60})
        "                             \ | call litecorrect#init()
        "                             \ | setl spell spl=en_us et sw=2 ts=2 noai nonu nornu
        "     autocmd Filetype html,xml call pencil#init({'wrap': 'soft'})
        "                             \ | call litecorrect#init()
        "                             \ | setl spell spl=en_us et sw=2 ts=2
        " augroup END

    " }}}

    " vim-surround {{{

        " let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
        " let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
        " let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
        " let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
        " let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"

    " }}}

    " vim-test {{{

        nmap <silent> <leader>Tt :TestNearest<CR>
        nmap <silent> <leader>Tf :TestFile<CR>
        nmap <silent> <leader>Ta :TestSuite<CR>
        nmap <silent> <leader>Tl :TestLast<CR>
        nmap <silent> <leader>Tr :TestVisit<CR>

        let test#strategy = 'asyncrun' " or 'asyncrun_background'

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

        " do not use built-in tag search, use ripgrep instead

    " }}}

    " vista.vim {{{

        nnoremap <silent> <F9> :Vista!!<CR>

        let g:vista#renderer#enable_icon = 1
        let g:vista_fzf_preview = ['right:50%']

    " }}}

" }}}

" Local {{{

    if filereadable(expand('~/.vimrc.local'))
        source ~/.vimrc.local
    endif

" }}}
