# Bootstrap fisher

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "~/.config"
    curl "https://git.io/fisher" --create-dirs -sLo "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
    fish -c fisher
end

# TODO: should certain things here be excluded if non-interactive?

# TODO: install these when some upstream issues are fixed
# - oh-my-fish/plugin-git-flow
#   - does not correctly detect standard git completions existing
# - b4b4r07/enhancd
#   - uses long options for rm command, there's a PR up to fix this
# - acomagu/fish-async-prompt
#   - does not play nice with the prefixed extra newline in starship

# Variables

# TODO: turn this back on after fixing grc/grcplugin_ls/colors, or stop caring
#       since we alias ls to exa now
# if ls --color > /dev/null 2>&1
#     # GNU ls
#     set -gx grcplugin_ls "--color"
# else
#     # BSD ls
#     set -gx grcplugin_ls "-G"
# end

# do NOT set $TERM here, it should be set within terminal app preferences or
# tmux configuration

set fish_greeting

# Aliases

alias reload="source ~/.config/fish/config.fish"
# See for universal LSCOLORS: https://geoff.greer.fm/lscolors/
# Explanation of options: https://apple.stackexchange.com/questions/282185/how-do-i-get-different-colors-for-directories-etc-in-iterm2
# TODO: turn this back on after fixing grc/grcplugin_ls/colors
# alias l="ls -lah"
# alias l="command ls -lahG"
alias e="exa"
alias l="exa --binary --group --long --git"  # TODO: --group-directories-first ?
alias la="l --all"
alias r="ranger"
# TODO: git, docker, vagrant, cargo, make, yarn, npm, pip, brew, nix, tmux aliases
# TODO: maybe:
# bind \e\[A 'history --merge ; up-or-search'
alias hr="history --merge"
if type -q nvim
    alias vim="nvim"
    alias vimdiff="nvim -d"
    alias view="nvim -R"
end
alias ports="lsof -i -P | grep -i 'listen'"
alias fix="reset; ssty sane; tput rs1; clear; echo -e \"\033c\""
alias be="bundle exec"
alias myip="curl icanhazip.com"  # TODO: ifconfig.co ?
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
# TODO: alternatively, ..3 or .3
alias 1=".."
alias 2="..."
alias 3="...."
alias 4="....."
alias 5="......"
alias todo="rg \"[T]O[_ ]?DO|[F]IX[_ ]?ME|[X]XX|[H]ACK|[^(DE)|^_][B]UG|[R]EVIEW|[W]TF|[S]MELL|[B]ROKE|[N]OCOMMIT|[N]ORELEASE\""
alias flushdns="sudo killall -HUP mDNSResponder"
# TODO: this might not work
# alias -="cd -"
# TODO: from bash
# alias trash="command mv "$@" ~/.Trash"
# alias ql="qlmanage -p "$*" >& /dev/null"
# TODO: if ever end up using kitty
# alias icat="kitty +kitten icat"
# alias kdiff="kitty +kitten diff"
# TODO: requires aspell, conversion from bash
# spl () {
#     aspell -a <<< "$1"
# }

# Mini Functions

# Package Configuration

# starship

type -q starship; and starship init fish | source

# Tool Configuration

# asdf

# TODO: these are macOS/homebrew specific
# while running (brew --prefix asdf) would be cleaner, it adds a huge amount of
# time to this test, so hardcode the path
test -d /usr/local/opt/asdf; and source /usr/local/opt/asdf/asdf.fish
# TODO: still need this?
# test -f /usr/local/share/fish/vendor_completions.d/asdf.fish; and source /usr/local/share/fish/vendor_completions.d/asdf.fish

# fasd

alias v="f -e vim"
alias o="f -e open"

# fzf

# see "$XDG_CONFIG_HOME/fish/fish_variables" for most fzf options

# NB: have --ansi in FZF_DEFAULT_OPTS despite slight performance delay due to
# fd's color options being a nice addition

# TODO: finish moving to https://github.com/patrickf3139/fzf.fish or own custom
# TODO: add more custom fzf commands: https://news.ycombinator.com/item?id=26012632

if set --query fzf_fish_custom_keybindings
    # \cf is ctrl+f, etc.
    # bind \cf '__fzf_search_current_dir'
    # bind \cl '__fzf_search_git_log'
    # bind \cr '__fzf_search_history'
    # bind \cv '__fzf_search_shell_variables'

    # set up the same keybindings for insert mode if using fish_vi_key_bindings
    # if [ $fish_key_bindings = 'fish_vi_key_bindings' ]
    #     bind --mode insert \cf '__fzf_search_current_dir'
    #     bind --mode insert \cl '__fzf_search_git_log'
    #     bind --mode insert \cr '__fzf_search_history'
    #     bind --mode insert \cv '__fzf_search_shell_variables'
    # end
end

# npx

# TODO: leaving this line uncommented causes vim/ale to error out when linting
# type -q npx; and source (npx --shell-auto-fallback fish | psub)

# thefuck

type -q thefuck; and thefuck --alias | source

# virtualfish

# remember to do "vf new --python (asdf which python) <env-name>" to play nice with asdf
# alternatively, "vf new --python (asdf which python <version>) <env-name>"
# also, "pipx install --python (asdf which python <version>) <package>"

# Local Configuration

if test -e ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
