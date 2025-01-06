# Reset PATH to keep it from being clobbered in tmux
# For more information: https://coderwall.com/p/4l16zq/pyenv-inside-tmux-with-zsh-on-a-mac
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    source /etc/profile
fi

# Better ulimit defaults (soft, hard)
ulimit -n 65536 65536
ulimit -u 2128 2128  # Again, ideally 1418 and 2128, once launchctl limit works

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
