# Reset PATH to keep it from being clobbered in tmux
# For more information: https://coderwall.com/p/4l16zq/pyenv-inside-tmux-with-zsh-on-a-mac
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    source /etc/profile
fi

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
