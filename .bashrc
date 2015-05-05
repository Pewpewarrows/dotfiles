# Keep in mind that it's common to have this file be reloaded often, so any
# operations in here should be idempotent (particularly environmental variable
# additions).

# If not running interactively: exit immediately.
if [[ $- != *i* ]] || [ -z "$PS1" ]; then
    return 0
fi

# Determine which OS we're running on
# TODO: distinguish better between specific Linux flavors (like Arch or Fedora)
# TODO: use $OSTYPE instead of `uname` ?
__distro=Linux
case `uname` in
    Darwin)
        __distro=Darwin
    ;;
esac

#-------------------------
# Environmental Variables
#-------------------------

# DO NOT USE "~" IN PATH ADDITIONS. USE ${HOME} INSTEAD.

export PATH

path_prepend() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

path_append() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

path_prepend "$HOME/bin"
#PATH="/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin:$PATH"

# Viewing & Editing Text
export PAGER="less"
export EDITOR="vim"
export VISUAL=$EDITOR

# Less Colors for Man Pages
# export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
# export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
# export LESS_TERMCAP_me=$'\E[0m'           # end mode
# export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
# export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
# export LESS_TERMCAP_ue=$'\E[0m'           # end underline
# export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;016m\E[48;5;220m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# http://www.cyberciti.biz/faq/linux-unix-colored-man-pages-with-less-command/
# export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
# export LESS_TERMCAP_md=$'\E[01;31m'  # begin bold
# export LESS_TERMCAP_me=$'\E[0m'           # end mode
# export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
# export LESS_TERMCAP_so=$'\E[1;44;33m'    # begin standout-mode - info box
# export LESS_TERMCAP_ue=$'\E[0m'           # end underline
# export LESS_TERMCAP_us=$'\E[1;32m' # begin underline

# Bash History
export HISTSIZE=9001
export HISTFILESIZE=9001
# export HISTFILE="$HOME/.bash_history_${HOSTNAME}"
export HISTFILE="$HOME/.bash_history"
shopt -s histappend
if [ "$UID" != 0 ]; then
    export HISTCONTROL="ignoreboth"   # ignores duplicate lines next to each other and lines with a leading space
    export HISTIGNORE="[bf]g:exit:logout"
fi

# Fix the background bleeding problem when using vim inside tmux
# Additional reading:
#   http://superuser.com/questions/399296/256-color-support-for-vim-background-in-tmux
#   http://sunaku.github.io/vim-256color-bce.html
#   http://www.reddit.com/r/vim/comments/1a29vk/fixing_vims_background_color_erase_for_256color/c8thqe7
if [[ -z $TMUX ]]; then
    export TERM=xterm-256color
else
    export TERM=screen-256color
fi

export INPUTRC=~/.inputrc

# ls and grep default options
LS_OPTIONS="-hF"
GREP_OPTIONS="-E" # TODO: include on linux: --color=always
export CLICOLOR=1

if [ "$__distro" == "Darwin" ]; then
    export LSCOLORS=ExGxFxDxCxHxHxCbCeEbEb
    export LC_CTYPE=en_US.utf-8
else
    LS_OPTIONS="$LS_OPTIONS --color=auto --group-directories-first"
fi
export LS_OPTIONS GREP_OPTIONS

# Bash improvements
shopt -s cdspell nocaseglob
shopt -s histverify
complete -cf sudo
complete -cf which
complete -cf man

#-------------------------
# Prompt
#-------------------------

RESET_COLOR="\[\033[0m\]"
GREEN="\[\033[1;32m\]"
CYAN="\[\033[0;36m\]"
GRAY="\[\033[0;37m\]"
BLUE="\[\033[1;34m\]"
WHITE="\[\033[1;37m\]"
PINK="\[\033[1;35m\]"
ORANGE="\[\033[0;33m\]"
RED="\[\033[1;31m\]"

custom_lastcommandfailed() {
    code=$?
    if [ $code != 0 ]; then
        echo -n $' exited '
        echo -n $code
        echo -n $''
    fi
}

custom_backgroundjobs() {
  jobs|python -c 'if 1:
    import sys
    items = ["\033[36m%s\033[37m" % x.split()[2]
             for x in sys.stdin.read().splitlines()]
    if items:
      if len(items) > 2:
        string = "%s, and %s" % (", ".join(items[:-1]), items[-1])
      else:
        string = ", ".join(items)
      print "\033[37m running %s" % string
  '
}

custom_virtualenv() {
    unset VIRTUAL_ENV_BASE
    local venv=`basename "$VIRTUAL_ENV"`

    if test $venv; then
        VIRTUAL_ENV_BASE=" ${GRAY}workon ${CYAN}$venv"
    fi
}

custom_vcprompt() {
    if which vcprompt > /dev/null; then
        vcprompt -f " on ${BLUE}%n${WHITE}:%b${GREEN}%m%u"
    fi
}

update_prompt() {
    history -a
    history -c
    history -r
    custom_virtualenv
    #export BASEPROMPT="$(custom_lastcommandfailed)${BLUE}\u ${GRAY}@ ${RED}\h ${GRAY}in ${GREEN}\w${GRAY}$(custom_vcprompt)${VIRTUAL_ENV_BASE}$(custom_backgroundjobs)${WHITE}"
    export BASEPROMPT="$(custom_lastcommandfailed)${BLUE}\u ${GRAY}@ ${RED}\h ${GRAY}in ${GREEN}\w${GRAY}$(custom_vcprompt)${VIRTUAL_ENV_BASE}${WHITE}"
    export PS1="
${BASEPROMPT}
$ ${RESET_COLOR}"
}
PROMPT_COMMAND=update_prompt

#-------------------------
# Aliases
#-------------------------

alias ls="ls $LS_OPTIONS"
alias l="ls -l"
alias la="ls -lA"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# That's what I call directory navigation! (function 'cdpushd' defined below)
alias cd="cdpushd >/dev/null"
alias b="popd >/dev/null"

# New defaults
alias df="df -h"
alias du="du -hc"
alias grep="grep $GREP_OPTIONS"
alias mkdir="mkdir -p" # make intermediate directories if they don't exist
# TODO: ps
# `which -s htop` && alias top="htop"

# Custom aliases
alias myip="curl icanhazip.com"
alias reload=". ~/.bash_profile"
alias hist="history | grep"
# This used to be aliased to "f", but fasd clobbers that...
alias search="find . -name"
alias dcommit-preview="git svn dcommit --dry-run | grep '^diff-tree' | cut -b 11- | git diff-tree --stdin -p -v | less"
alias ports="lsof -i -P | grep -i 'listen'"

case "$__distro" in
    cygstart)
        alias open="cmd /c start"
    ;;
    Linux)
        alias open="gnome-open" # Use xdg-open instead?
    ;;
esac

server() {
    port=${1:-8000}
    [[ "$SSH_TTY" ]] || ( { open "http://localhost:${port}"; } & )
    python -m SimpleHTTPServer $port
}

if [ "$__distro" = "Darwin" ]; then
    alias ,="brew"
    alias ,i="brew install"
    alias ,l="brew list"
    alias ,?="brew info"
    alias ,s="brew search"
    alias ,u="brew update"
    alias ,r="brew uninstall"

    alias updatedb="sudo /usr/libexec/locate.updatedb"
else
    alias ,="aptitude"
    alias ,i="aptitude install"
    alias ,l="dpkg -l"
    alias ,?="aptitude show"
    alias ,s="aptitude search"
    alias ,u="aptitude update"
    alias ,uu="aptitude update && sudo apt-get upgrade"
    alias ,r="aptitude remove"
fi

alias gimme=",i"
alias donotwant=",r"

# Development aliases
alias fv="fab vagrant"
alias be="bundle exec"

# TODO: fix the original alias?
# alias non_mas_apps="for i in /Applications/*; do [ ! -d "${i}/Contents/_MASReceipt" ] && echo $i; done"
# TODO: no underscores allowed in bash function names? that can't be right...
nonmasapps() {
    for i in /Applications/*;
      do [ ! -d "${i}/Contents/_MASReceipt" ] && echo $i;
    done
}
alias non_mas_apps="nonmasapps"

alias svn_git_authors="svn log --xml | grep author | sort -u | perl -pe 's/.*>(.*?)<.*/$1 = /'"

# Custom functions

# This makes pushd behave like cd when no argument is passed, so we can alias to cd
cdpushd() {
    if [ -n "$1" ]; then
        pushd "$*"
    else
        if [ "`pwd`" != "$HOME" ]; then
            pushd ~
        fi
    fi
}

# Stops you (or a script) from accidentally doing a `git clean -dfx` on $HOME
# TODO: finish writing this. needs to catch --git-dir and pass along to
#       rev-parse, and figure out if I can make it work w/ vcsh.
# git() {
#     local top_level=$(command git rev-parse --show-toplevel 2>/dev/null)
#     local clean=false

#     echo "hi"

#     for i in "$@"; do
#         if [[ $i == "clean" ]]; then
#             clean=true
#             break
#         fi
#     done

#     echo $clean
#     echo [[ "${top_level}" == "${HOME}" ]]

#     if [[ "${top_level}" == "${HOME}" ]] && [ "$clean" = true ]; then
#         >&2 echo "Do NOT run git clean in this repository."
#         return
#     fi

#     command git "$@"
# }

# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }

# Extract an archive (subdir will be made if the archive may contain multiple files)
# TODO: find/write better solution, this is kinda ugly.
# Usage: x <file>
x() {
    for prog in uncompress tar 7za unzip unrar unace tar gunzip bunzip2; do
        if ! which $prog &>/dev/null; then
            echo "${FUNCNAME[0]}(): Warning: Can't find program '$prog'."
        fi
    done

    local is_tgz=0
    local is_tbz2=0
    local n=""

    local ext="${1##*.}"
    local ext_lc="`echo $ext | tr [:upper:] [:lower:]`"

    # For .tar.gz and .tar.bz2, strip "both extensions", otherwise just strip one
    case "$1" in
        *.tar.gz)  n="`echo "$1" | sed 's/\.tar\..\+$//'`"; is_tgz=1  ;;
        *.tar.bz2) n="`echo "$1" | sed 's/\.tar\..\+$//'`"; is_tbz2=1 ;;
        *)         n="${1%.*}"
    esac

    case "$ext_lc" in
        z)        uncompress "$1" ;;
        tar)      mkdir "$n"; mv "$1" "$n"; cd "$n"; tar xvf "$1" ; mv "$1" ..; cd .. ;;
        7z)       mkdir "$n"; mv "$1" "$n"; cd "$n"; 7za x "$1"   ; mv "$1" ..; cd .. ;;
        zip)      mkdir "$n"; mv "$1" "$n"; cd "$n"; unzip "$1"   ; mv "$1" ..; cd .. ;;
        rar)      mkdir "$n"; mv "$1" "$n"; cd "$n"; unrar x "$1" ; mv "$1" ..; cd .. ;;
        ace)      mkdir "$n"; mv "$1" "$n"; cd "$n"; unace x "$1" ; mv "$1" ..; cd .. ;;
        tgz)      mkdir "$n"; mv "$1" "$n"; cd "$n"; tar xvzf "$1"; mv "$1" ..; cd .. ;;
        tbz|tbz2) mkdir "$n"; mv "$1" "$n"; cd "$n"; tar xvjf "$1"; mv "$1" ..; cd .. ;;
        gz)
            if [ $is_tgz ]; then
                mkdir "$n"; mv "$1" "$n"; cd "$n"; tar xvzf "$1"; mv "$1" ..; cd ..
            else
                gunzip "$1"
            fi ;;
        bz2)
            if [ $is_tbz2 ]; then
                mkdir "$n"; mv "$1" "$n"; cd "$n"; tar xvjf "$1"; mv "$1" ..; cd ..
            else
                bunzip2 "$1"
            fi ;;
        *) echo "${FUNCNAME[0]}(): Can't extract: unknown file extension $ext"; return 1
    esac
}

#-------------------------
# Completions
#-------------------------

if [ "$__distro" = "Darwin" ]; then
    if [ -f `brew --prefix`/etc/bash_completion ]; then
        . `brew --prefix`/etc/bash_completion
    fi
else
    if [ -r /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi

#-------------------------
# Application-specific modifications
#-------------------------

if [ "$__distro" = "Darwin" ]; then
    export ARCHFLAGS='-arch i386 -arch x86_64'
fi

# Virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
# TODO: PROJECT_HOME, and use pyenv global version to deduce virtualenvwrapper.sh location
if [ "$__distro" = "Darwin" ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi
export PIP_RESPECT_VIRTUALENV=true
export PIP_VIRTUALENV_BASE=$WORKON_HOME

if [ "$__distro" = "Darwin" ]; then
    # For psycopg2 to install correctly
    #export PATH=$PATH:/Library/PostgreSQL/9.0/bin
    path_append "/Applications/Postgres.app/Contents/Versions/9.4/bin"

    # MacPorts Installer addition on 2011-04-08_at_10:51:06: adding an appropriate PATH variable for use with MacPorts.
    #export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    # Finished adapting your PATH environment variable for use with MacPorts.

    # export PATH=$PATH:~/.gem/ruby/1.8/bin

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

if [ -f ~/Projects/Forks/django/extras/django_bash_completion ]; then
    . ~/Projects/Forks/django/extras/django_bash_completion
fi

# fasd
if which fasd > /dev/null; then eval "$(fasd --init auto)"; fi
alias v='f -e vim'
alias o='f -e open'

if which hub > /dev/null; then alias git="hub"; fi

# brew-cask
# TODO: figure out if I want the symlinks going here or default: ~/Applications
# export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

# nvm
export NVM_DIR=~/.nvm
[[ -s $(brew --prefix nvm) ]] && source $(brew --prefix nvm)/nvm.sh

# golang
if [[ -d $HOME/go ]]; then
    export GOPATH="$HOME/go"
    path_append "$GOPATH/bin"
fi

# For vi-mode in zsh:
# bindkey -v

# OPAM configuration
. /Users/Marco/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Reminder to use `help` for builtin command docs, `man` useless for them
