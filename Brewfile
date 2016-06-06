# Run `brew bundle` to install these

# Brews

# Dotfile Management
brew 'mr'
brew 'vcsh'

# Development Tools
brew 'ant'
brew 'android-ndk'
brew 'android-sdk'
brew 'checkbashisms'
brew 'chisel'
brew 'clang-format'
brew 'cmake'
brew 'cppcheck'
brew 'cpputest'
brew 'ctags'
brew 'git'
brew 'git-flow'  # TODO: vs git-flow-avh
brew 'git-lfs'
# TODO: move to gvm, it needs a homebrew recipe first though
brew 'golang'
brew 'gradle'
brew 'hg'
brew 'libimobiledevice'
brew 'llvm', args: ['with-clang', 'with-clang-extra-tools', 'with-lld', 'with-lldb', 'with-rtti', 'with-all-targets', 'with-python']
brew 'lua'
brew 'maven'
brew 'mono'
brew 'multirust'
brew 'nvm'
brew 'opam'
brew 'pyenv'
brew 'pyenv-virtualenv'
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
brew 'nmap'
brew 'notmuch'
brew 'pv'
brew 'reattach-to-user-namespace'
brew 'rename'
brew 'ssh-copy-id'
brew 'thefuck'
brew 'tmux'
brew 'tree'
brew 'urlview'
brew 'vcprompt'
brew 'wget'

# For consideration
# brew 'ghi'
# brew 'mobile-shell'
# brew 'gist'
# sdkman (would need a homebrew recipe)
# brew 'swig'  # Python M2Crypto library needs this
brew 'graphviz'  # Python pygraphviz library needs this

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
cask 'cheatsheet'
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
cask 'spectacle'
cask 'spotify'
cask 'stay'
cask 'the-unarchiver'
cask 'transmission'
cask 'tunnelblick'
cask 'vlc'
cask 'ynab'

# Development
cask 'android-ndk'
cask 'android-studio'
cask 'balsamiq-mockups'
cask 'dash'
cask 'github-desktop'
cask 'haskell-platform'
cask 'hex-fiend'
cask 'hopper-disassembler'
cask 'iterm2'
cask 'java'
cask 'mactex'
cask 'oclint'
cask 'osxfuse'
cask 'vagrant'
cask 'virtualbox'
cask 'vmware-fusion'

tap 'railwaycat/homebrew-emacsmacport'
cask 'emacs-mac'

tap 'caskroom/fonts'
# Currently unused in favor of Monaco
# cask 'font-hack'

# For consideration
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
# TODO: The cask forumla was removed after the download link was removed from
#       the app's homepage. What's the status of Induction.app?
#       https://github.com/caskroom/homebrew-cask/pull/8772
# cask 'induction'
# cask 'kitematic'
# TODO: if still using safari extensions requiring simbl, install this
# cask 'easysimbl'
# cask 'mojibar'
# cask 'fantastical'
# cask 'imageoptim'
# cask 'istat-menus'
# cask 'coyim'
# cask 'intel-haxm'

# For consideration, Quick Look Plugins
# cask 'qlcolorcode'
# cask 'qlstephen'
# cask 'qlmarkdown'
# cask 'quicklook-json'
# cask 'qlprettypatch'
# cask 'quicklook-csv'
# cask 'betterzipql'
# cask 'webpquicklook'
# cask 'suspicious-package'
# after installing these: $ qlmanage -r
