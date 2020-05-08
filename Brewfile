# Run `brew bundle` to install these

# Brews

# Dotfile Management
brew 'mr'
brew 'vcsh'

# Development Tools
brew 'ant'
brew 'android-ndk'
brew 'android-sdk'
brew 'asdf'
brew 'bat'
brew 'checkbashisms'
brew 'cflow'
brew 'chisel'
brew 'clang-format'
brew 'cmake'
brew 'cppcheck'
brew 'cpputest'
brew 'exa'
brew 'git'
brew 'git-flow'  # TODO: vs git-flow-avh
brew 'git-lfs'
brew 'gradle'
brew 'hg'
brew 'hugo'
brew 'ideviceinstaller', args: ['HEAD']
brew 'libimobiledevice', args: ['HEAD']
brew 'libplist'
brew 'llvm', args: ['with-clang', 'with-clang-extra-tools', 'with-lld', 'with-lldb', 'with-rtti', 'with-all-targets', 'with-python']
brew 'maven'
brew 'mono'
brew 'neovim'
brew 'pipx'
brew 'radare2'
brew 'shellcheck'
brew 'socat'
brew 'splint'
brew 'testssl'
brew 'tig'
brew 'usbmuxd', args: ['HEAD']
brew 'valgrind'
brew 'vim', args: ['override-system-vi', 'with-lua', 'with-luajit']
brew 'xcproj'
brew 'xctool'
brew 'yarn', args: ['ignore-dependencies']

# Workflow Tools
brew 'boot2docker'
brew 'brew-cask-completion'
brew 'diff-so-fancy'
brew 'docker'
brew 'fasd'
brew 'fd'
brew 'ffmpeg'
brew 'fish'
brew 'fzf'
brew 'getmail'
brew 'gifsicle'
brew 'grc'
brew 'hh'
brew 'hub'
brew 'ncdu'
brew 'neofetch'
brew 'nmap'
brew 'notmuch'
brew 'pandoc'
brew 'pv'
brew 'ranger'
brew 'reattach-to-user-namespace'
brew 'rename'
brew 'ripgrep'
brew 'ssh-copy-id'
brew 'starship'
brew 'streamlink'
brew 'terminal-notifier'
brew 'thefuck'
brew 'tmux'
brew 'tree'
brew 'urlview'
brew 'vcprompt'
brew 'wget'

# Writing
brew 'languagetool'
brew 'redpen'
brew 'vale'

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

# TODO: dupes is gone, find where gdb is now
tap 'homebrew/dupes'
brew 'gdb'

tap 'thoughtbot/formulae'
brew 'liftoff'

tap 'tgray/homebrew-tgbrew'
brew 'contacts2'
brew 'muttqt'

tap 'universal-ctags/homebrew-universal-ctags'
brew 'universal-ctags', args: ['HEAD']

# This extends brew with a "cu" subcommand, only need to tap, no further
# installs
tap 'buo/cask-upgrade'

# Casks
cask 'adium'
cask 'adobe-acrobat-reader'
cask 'amazon-cloud-drive'
cask 'anki'
cask 'appcleaner'
cask 'bartender'
cask 'beardedspice'
cask 'blender'
cask 'caffeine'
cask 'cheatsheet'
# cask 'curse'
# cask 'daisydisk'
cask 'discord'
# cask 'disk-inventory-x'
cask 'dropbox'
cask 'firefox'
# cask 'flash'  # was renamed to flash-npapi, may not want anymore anyway
cask 'flux'
cask 'focus'
cask 'godot'
cask 'google-backup-and-sync'
cask 'google-chat'
cask 'google-hangouts'
# cask 'gpgtools'
cask 'gpg-suite'
cask 'iglance'
cask 'keybase'
cask 'krita'
cask 'licecap'
cask 'loading'
cask 'mixxx'
cask 'resilio-sync'
cask 'scroll-reverser'
cask 'shotcut'
cask 'signal'
cask 'sketchbook'
cask 'skype'
cask 'slack'
cask 'spectacle'
cask 'spotify'
cask 'stay'
cask 'sublime-text'
cask 'the-unarchiver'
cask 'torbrowser'
cask 'transmission'
cask 'tunnelblick'
cask 'vlc'
cask 'vnc-viewer'
cask 'whatsapp'

# Development
cask 'adoptopenjdk'
cask 'alacritty'
cask 'android-ndk'
cask 'android-studio'
cask 'balsamiq-mockups'
cask 'cutter'
cask 'dash'
cask 'gas-mask'
cask 'ghidra'
cask 'github'
cask 'haskell-platform'
cask 'hex-fiend'
cask 'hopper-disassembler'
cask 'iterm2'
cask 'java'
cask 'kitty'
cask 'mactex'
cask 'oclint'
cask 'osxfuse'
cask 'touch-bar-simulator'
cask 'vagrant'
cask 'virtualbox'
cask 'virtualbox-extension-pack'
cask 'visual-studio-code'
cask 'vmware-fusion'

tap 'railwaycat/homebrew-emacsmacport'
cask 'emacs-mac'

tap 'caskroom/fonts'
# Alternatives instead of macOS built-ins Monaco and SF Mono
cask 'font-fira-mono'
# TODO: manually downloaded
# https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf
# copied to ~/Library/Fonts/ and ran
# $ fc-cache -fr
# will want to make a formula based on:
# https://github.com/Homebrew/homebrew-cask-fonts/blob/master/Casks/font-powerline-symbols.rb
# cask 'font-firacode-nerd-font'
cask 'font-firamono-nerd-font'
# cask 'font-hack-nerd-font'
# cask 'font-sourcecodepro-nerd-font'
# Unavailable
# - office code pro
# - proggy vector

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
