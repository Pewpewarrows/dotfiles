
# If not running interactively: exit immediately.
if [[ $- != *i* ]] || [ -z "$PS1" ]; then
    return 0
fi

# Determine which OS we're running on
# TODO: distinguish better between specific Linux flavors (like Arch or Fedora)
__distro=Linux
case `uname` in
    Darwin)
        __distro=Darwin
    ;;
esac

#-------------------------
# Environmental Variables
#-------------------------

# Path
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi
export PATH

# Viewing & Editing Text
export PAGER="less"
export EDITOR="vim"
export VISUAL=$EDITOR

# Bash History
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTFILE="$HOME/.bash_history_${HOSTNAME}"
if [ "$UID" != 0 ]; then
    export HISTCONTROL="ignoreboth"   # ignores duplicate lines next to each other and lines with a leading space
    export HISTIGNORE="[bf]g:exit:logout"
fi

export TERM=xterm-256color

# ls and grep default options
LS_OPTIONS="-hF"
GREP_OPTIONS="-r -E" # TODO: include on linux: --color=always
export CLICOLOR=1

if [ "$__distro" == "Darwin" ]; then
    export LSCOLORS=ExGxFxDxCxHxHxCbCeEbEb
    export LC_CTYPE=en_US.utf-8
else
    LS_OPTIONS="$LS_OPTIONS --color=auto --group-directories-first"
fi
export LS_OPTIONS GREP_OPTIONS

#-------------------------
# Prompt
#-------------------------

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
    vcprompt -f " on ${BLUE}%n${WHITE}:%b${GREEN}%m%u"
}

update_prompt() {
    custom_virtualenv
    export BASEPROMPT="$(custom_lastcommandfailed)${BLUE}\u ${GRAY}@ ${RED}\h ${GRAY}in ${GREEN}\w${GRAY}$(custom_vcprompt)${VIRTUAL_ENV_BASE}$(custom_backgroundjobs)${WHITE}"
    export PS1="
${BASEPROMPT}
$ "
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

# Virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
if [ "$__distro" = "Darwin" ]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi
export PIP_VIRTUALENV_BASE=$WORKON_HOME

if [ "$__distro" = "Darwin" ]; then
    # For psycopg2 to install correctly
    export PATH=$PATH:/Library/PostgreSQL/9.0/bin/

    # MacPorts Installer addition on 2011-04-08_at_10:51:06: adding an appropriate PATH variable for use with MacPorts.
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
    # Finished adapting your PATH environment variable for use with MacPorts.

    export PATH=$PATH:~/.gem/ruby/1.8/bin
fi

if [ -f ~/Projects/Forks/django/extras/django_bash_completion ]; then
    . ~/Projects/Forks/django/extras/django_bash_completion
fi

alias git="hub"
