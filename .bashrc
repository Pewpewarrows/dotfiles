# Keep in mind that it's common to have this file be reloaded often, so any
# operations in here should be idempotent (particularly environmental variable
# additions).

# Reminder to use `help` for builtin command docs, `man` useless for them

# If not running interactively: exit immediately.
if [[ $- != *i* ]] || [ -z "$PS1" ]; then
    return 0
fi

case "$__distro" in
    cygstart)
        alias open="cmd /c start"
    ;;
    Linux)
        alias open="gnome-open" # Use xdg-open instead?
    ;;
esac

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

# TODO: fix the original alias?
# alias non_mas_apps="for i in /Applications/*; do [ ! -d "${i}/Contents/_MASReceipt" ] && echo $i; done"
# TODO: no underscores allowed in bash function names? that can't be right...
nonmasapps() {
    for i in /Applications/*;
      do [ ! -d "${i}/Contents/_MASReceipt" ] && echo $i;
    done
}
alias non_mas_apps="nonmasapps"

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

eg() {
  MAN_KEEP_FORMATTING=1 man "$@" 2>/dev/null \
    | sed --quiet --expression='/^E\(\x08.\)X\(\x08.\)\?A\(\x08.\)\?M\(\x08.\)\?P\(\x08.\)\?L\(\x08.\)\?E/{:a;p;n;/^[^ ]/q;ba}' \
    | ${MANPAGER:-${PAGER:-pager -s}}
}

# emacs
# TODO: get this working
# export ALTERNATE_EDITOR="/Applications/Emacs.app/Contents/MacOS/Emacs"
# alias emacs="/Applications/Emacs.app/Contents/MacOS/bin/emacs"
# alias e="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -nw -t"
# alias ec="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -c -n"
# (if I want to complete switch over:)
# export EDITOR="emacsclient -t"                  # $EDITOR should open in terminal
# export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI with non-daemon as alternate

if [ -f ~/.bashrc_local ]; then
    . ~/.bashrc_local
fi
