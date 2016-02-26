# Run `brew bundle` to install these

# Brews

# Dotfile Management
brew 'mr'
brew 'vcsh'

# Development Tools
brew 'checkbashisms'
brew 'chisel'
brew 'clang-format'
brew 'cmake'
brew 'cppcheck'
brew 'cpputest'
brew 'ctags'
# TODO: move to gvm, it needs a homebrew recipe first though
brew 'golang'
brew 'llvm', args: ['with-clang', 'with-lld', 'with-lldb', 'with-rtti', 'with-all-targets', 'with-python']
brew 'mono'
brew 'multirust'
brew 'nvm'
brew 'opam'
brew 'pyenv'
brew 'rbenv'
brew 'ruby-build'
brew 'shellcheck'
brew 'splint'
brew 'tig'
brew 'valgrind'
brew 'vim', args: ['override-system-vi', 'with-lua', 'with-luajit']
brew 'xcproj'
brew 'xctool'

# Workflow Tools
brew 'ack'
brew 'ag'
brew 'bash-completion'
brew 'boot2docker'
brew 'diff-so-fancy'
brew 'docker'
brew 'fasd'
brew 'ffmpeg'
brew 'getmail'
brew 'gifsicle'
brew 'hh'
brew 'hub'
brew 'notmuch'
brew 'reattach-to-user-namespace'
brew 'rename'
brew 'thefuck'
brew 'tmux'
brew 'tree'
brew 'urlview'
brew 'vcprompt'

# For consideration
# brew 'ghi'
# brew 'mobile-shell'
# brew 'gist'
# sdkman (would need a homebrew recipe)

# Used to: $ brew install --with-gpgme --with-sidebar-patch https://gist.githubusercontent.com/Pewpewarrows/b9f545306a00004d8009/raw/7e47a7660491f5dfbae31dc43001cc6eb9aac12b/mutt.rb
# Still need to (on locked down networks): $ brew edit sgeb/mutt/mutt
#   mirror "https://bitbucket.org/mutt/mutt/downloads/mutt-1.5.24.tar.gz"
# TODO: this sidebar patch is old...
tap 'sgeb/mutt'
brew 'sgeb/mutt/mutt', args: ['with-gpgme', 'with-sidebar-patch']

tap 'homebrew/dupes'
brew 'gdb'

tap 'thoughtbot/formulae'
brew 'liftoff'

tap 'tgray/homebrew-tgbrew'
brew 'contacts2'
brew 'muttqt'

# Casks
cask 'adium'
cask 'amazon-cloud-drive'
cask 'anki'
cask 'appcleaner'
cask 'bartender'
cask 'beardedspice'
cask 'bittorrent-sync'
cask 'caffeine'
cask 'clipmenu'
cask 'daisydisk'
cask 'disk-inventory-x'
cask 'dropbox'
cask 'flash'
cask 'flux'
cask 'google-drive'
cask 'gpgtools'
cask 'hipchat'
cask 'licecap'
cask 'loading'
cask 'skype'
cask 'slack'
cask 'slate'
cask 'spotify'
cask 'stay'
cask 'the-unarchiver'
cask 'transmission'
cask 'tunnelblick'
cask 'vlc'
cask 'ynab'

# Development
cask 'balsamiq-mockups'
cask 'dash'
cask 'github-desktop'
cask 'iterm2'
cask 'mactex'
cask 'oclint'
cask 'vagrant'
cask 'virtualbox'
cask 'vmware-fusion'

# For consideration
# cask 'moom'  # TODO: confirm that slate replaces this completely, then remove
# TODO: Postgres.app has an internal check that its real directory is
#       /Applications/Postgres.app/, so even an --appdir=/Applications symlink
#       won't work for it. Would like to eventually fix this.
# cask 'postgres'
# cask 'alfred'
# cask 'textexpander'
# cask 'sequel-pro'
# TODO: Google Chrome from cask doesn't play nice with the 1Password extension?
# cask 'google-chrome'
# cask 'cloudapp'
# cask 'divvy'
# TODO: The cask forumla was removed after the download link was removed from
#       the app's homepage. What's the status of Induction.app?
#       https://github.com/caskroom/homebrew-cask/pull/8772
# cask 'induction'
# cask 'kitematic'
# TODO: if still using safari extensions requiring simbl, install this
# cask 'easysimbl'
# cask 'mojibar'
