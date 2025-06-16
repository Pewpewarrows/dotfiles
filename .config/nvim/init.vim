" Use vim configs
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Force reload
lua package.loaded.config = nil
lua require('config')
