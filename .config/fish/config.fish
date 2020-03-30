# Bootstrap fisher

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "~/.config"
    curl "https://git.io/fisher" --create-dirs -sLo "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
    fish -c fisher
end

# Variables

# TODO: turn this back on after fixing grc/grcplugin_ls/colors, or moving to
# exa
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
alias l="command ls -lahG"
# TODO: maybe:
# bind \e\[A 'history --merge ; up-or-search'
alias hr="history --merge"
alias vim="nvim"
alias vimdiff="nvim -d"
alias view="nvim -R"
alias ports="lsof -i -P | grep -i 'listen'"
alias fix="reset; ssty sane; tput rs1; clear; echo -e \"\033c\""
alias be="bundle exec"
alias myip="curl icanhazip.com"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias todo="rg \"[T]O[_ ]?DO|[F]IX[_ ]?ME|[X]XX|[H]ACK|[^(DE)|^_][B]UG|[R]EVIEW|[W]TF|[S]MELL|[B]ROKE|[N]OCOMMIT|[N]ORELEASE\""

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

# npx

# TODO: leaving this line uncommented causes vim/ale to error out when linting
# type -q npx; and source (npx --shell-auto-fallback fish | psub)

# thefuck

type -q thefuck; and thefuck --alias | source

# virtualfish

test -d ~/.local/pipx/venvs/virtualfish; and ~/.local/pipx/venvs/virtualfish/bin/python -m virtualfish | source

# Local Configuration

if test -e ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
