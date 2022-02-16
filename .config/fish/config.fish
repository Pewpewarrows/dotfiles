# Bootstrap fisher

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "~/.config"
    curl "https://git.io/fisher" --create-dirs -sLo "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
    fish -c fisher
end

# TODO: should certain things here be excluded if non-interactive? what about is-login?

# TODO: install these when some upstream issues are fixed
# - oh-my-fish/plugin-git-flow
#   - does not correctly detect standard git completions existing
# - b4b4r07/enhancd
#   - uses long options for rm command, there's a PR up to fix this
# - acomagu/fish-async-prompt
#   - does not play nice with the prefixed extra newline in starship

# Variables

# TODO: turn this back on after fixing grc/grcplugin_ls/colors, or stop caring
#       since we abbr ls to exa now
# if ls --color > /dev/null 2>&1
#     # GNU ls
#     set -gx grcplugin_ls "--color"
# else
#     # BSD ls
#     set -gx grcplugin_ls "-G"
# end

# TODO: there are some hardcoded home directory paths in fish_variables with my
# username, for it to be portable should add those paths in dynamically here if
# this is interactive

# TODO: android's platform-tools was already added to path, but may also want
# to do the same for tools and tools/bin
set -x ANDROID_HOME "$HOME/Library/Android/sdk/"

# do NOT set $TERM here, it should be set within terminal app preferences or
# tmux configuration

set fish_greeting

# Abbrs/Aliases

abbr reload "source ~/.config/fish/config.fish"
# See for universal LSCOLORS: https://geoff.greer.fm/lscolors/
# Explanation of options: https://apple.stackexchange.com/questions/282185/how-do-i-get-different-colors-for-directories-etc-in-iterm2
# TODO: turn this back on after fixing grc/grcplugin_ls/colors
# alias l="ls -lah"
# alias l="command ls -lahG"
abbr e "exa"
abbr l "exa --binary --group --long --git"  # TODO: --group-directories-first ?
abbr la "exa --binary --group --long --git --all"
abbr tree "exa --tree"
abbr r "ranger"
abbr cat "bat"
# TODO: git, docker, vagrant, cargo, make, yarn, npm, pip, brew, nix, tmux abbrs
# TODO: maybe:
# bind \e\[A 'history --merge ; up-or-search'
abbr hr "history --merge"
if type -q nvim
    abbr vim "nvim"
    abbr vimdiff "nvim -d"
    abbr view "nvim -R"
end
abbr ports "lsof -i -P | grep -i 'listen'"
abbr fix "reset; ssty sane; tput rs1; clear; echo -e \"\033c\""
abbr be "bundle exec"
abbr myip "curl icanhazip.com"  # TODO: ifconfig.co ?
abbr .. "cd .."
abbr ... "cd ../.."
abbr .... "cd ../../.."
abbr ..... "cd ../../../.."
abbr ...... "cd ../../../../.."
# TODO: alternatively, ..3 or .3
abbr 1 ".."
abbr 2 "..."
abbr 3 "...."
abbr 4 "....."
abbr 5 "......"
abbr todo "rg \"[T]O[_ ]?DO|[F]IX[_ ]?ME|[X]XX|[H]ACK|[^(DE)|^_][B]UG|[R]EVIEW|[W]TF|[S]MELL|[B]ROKE|[N]OCOMMIT|[N]ORELEASE\""
abbr flushdns "sudo killall -HUP mDNSResponder"
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
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
# TODO: this fixes outbound ssh, but TERM on ssh connections inbound to this machine show up as 'xterm-kitty' and falls back to 'ansi', this still true?
# TODO: abbrs are saved in fish_variables, the KITT_WINDOW_ID check won't work yet
type -q kitty; and set -q KITTY_WINDOW_ID; and abbr ssh "kitty +kitten ssh"
# TODO: if word dict file is unavailable, use this for a less-secure option:
# man sudoers | tr ' ' '\n' | egrep '^[a-z]{4,}$' | sort | uniq | wc -l
# TODO: read word count as env var
abbr mempass "LC_ALL=C grep -x '[a-z]*' /usr/share/dict/words | shuf --head-count=3 --random-source=/dev/urandom | paste -sd '-' -"
# TODO: complex version that includes random number and symbols at end, and capitalizes one word randomly
# shuf --input-range=0-999 --head-count=1
# LC_ALL=C tr -dc '!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' < /dev/urandom | head --bytes=3; echo
# TODO: may want to do (progn (magit-status) (delete-other-windows))
abbr magit "emacs -nw --eval \(magit-status\)"

# TODO: may need some more emacs/magit config from:
# https://gist.github.com/railwaycat/4043945
# https://gist.github.com/railwaycat/3498096
# https://emacsformacosx.com/tips

# set variables once without requiring them to be in fish_variables?
# if not set -q fish_initialized
#     set fish_initialized
# end

# Mini Functions

# TODO: remove from fish_user_paths like in: https://github.com/fish-shell/fish-shell/issues/2639#issuecomment-301896209

# TODO: remove safari HSTS cache per domain
# HSTS_DOMAIN=example.com
# killall nsurlstoraged
# /usr/libexec/PlistBuddy -c "Delete :com.apple.CFNetwork.defaultStorageSession:${HSTS_DOMAIN}" ~/Library/Cookies/HSTS.plist
# defaults read ~/Library/Cookies/HSTS.plist  # maybe import instead?
# launchctl start /System/Library/LaunchAgents/com.apple.nsurlstoraged.plist

# Package Configuration

# homebrew

# homebrew's bin and sbin were manually added to fish_user_paths even though they're re-added here, due to many custom functions from fisher plugins testing for binary existence before this config file is sourced
if status is-interactive; and test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

# starship

type -q starship; and starship init fish | source

# Tool Configuration

# asdf

# TODO: these are macOS/homebrew specific
# while running (brew --prefix asdf) would be cleaner, it adds a huge amount of
# time to this test, so hardcode the path
# TODO: may want to go back to brew prefix after this is only ran while interactive?
test -d /opt/homebrew/opt/asdf; and source /opt/homebrew/opt/asdf/asdf.fish
# TODO: still need this?
# test -f /usr/local/share/fish/vendor_completions.d/asdf.fish; and source /usr/local/share/fish/vendor_completions.d/asdf.fish
test -f ~/.asdf/plugins/java/set-java-home.fish; and source ~/.asdf/plugins/java/set-java-home.fish
type -q direnv; and direnv hook fish | source

# fasd

abbr v "f -e vim"
abbr o "f -e open"

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
