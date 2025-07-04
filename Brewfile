# Run `brew bundle` to install these

# Brews

# Dotfile Management
brew 'mr'  # fine for now, but end-of-lifed, may want to migrate to: repo, gita, or vcstool
brew 'vcsh'

# Development Tools
brew 'ant'
# WARNING: DO NOT install asdf here, managed via mr dotfiles instead
brew 'bat'
brew 'binutils'
brew 'checkbashisms'
brew 'cflow'
brew 'chisel'
brew 'clang-format'
brew 'cmake'
brew 'cppcheck'
brew 'cpputest'
brew 'dtc'  # for https://github.com/cfig/Android_boot_image_editor until made into Docker container
# TODO: consider lsd instead of eza for backwards-compatible ticks
brew 'eza'
brew 'git'
brew 'git-credential-oauth'
brew 'git-flow'  # TODO: vs git-flow-avh
brew 'git-lfs'
brew 'gradle'
brew 'hadolint'
brew 'hg'
brew 'hugo'
brew 'ipsw'
# brew 'ideviceinstaller', args: ['HEAD']  # TODO: this doesn't have an apple silicon bottle yet
brew 'libimobiledevice', args: ['HEAD']
brew 'libplist'
# TODO: also find a virt-manager to install as alternative to UTM, see: https://www.arthurkoziel.com/running-virt-manager-and-libvirt-on-macos/
# see also: https://stackoverflow.com/questions/3921814/is-there-a-virt-manager-alternative-for-mac-os-x
brew 'libvirt'
# TODO: decide if llvm formula is still necessary
# brew 'llvm', args: ['with-clang', 'with-clang-extra-tools', 'with-lld', 'with-lldb', 'with-rtti', 'with-all-targets', 'with-python']
# brew 'lua'  # TODO: is this managed by asdf now?
brew 'maven'
# brew 'mono'  # TODO: this doesn't have an apple silicon bottle yet
brew 'nasm'
brew 'neovim'
# brew 'opam'  # TODO: is this managed by asdf now?
brew 'pipx'
brew 'radare2'
brew 'shellcheck'
brew 'socat'
brew 'splint'
brew 'swiftformat'
brew 'swiftlint'
brew 'testssl'
brew 'tig'
brew 'usbmuxd', args: ['HEAD']
brew 'uv'
# brew 'valgrind'  # TODO: this doesn't have an apple silicon bottle yet
brew 'vim'
brew 'whalebrew'
brew 'xcproj'
# brew 'xctool'  # TODO: this doesn't have an apple silicon bottle yet
brew 'yarn', args: ['ignore-dependencies']

# Workflow Tools
brew 'brew-cask-completion'
brew 'cheat'
brew 'diff-so-fancy'
brew 'entr'
# TODO: fasd is officially archived, find replacement: fork? z+f?
# tap 'wyne/tap'
# brew 'fasd'
brew 'fd'
brew 'ffmpeg'
brew 'fish'
brew 'fzf'
brew 'getmail'
brew 'gh'
brew 'gifsicle'
brew 'grc'
brew 'htop'
brew 'imagemagick'
brew 'lima'
brew 'lz4'
brew 'mas'
brew 'mosh'
brew 'ncdu'
brew 'neofetch'
brew 'nmap'
brew 'notmuch'
brew 'pam-reattach'
brew 'pandoc'
brew 'podman'
brew 'pstree'
brew 'pv'
brew 'qemu'
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
brew 'urlview'
brew 'wakeonlan'
brew 'weechat'
brew 'wget'
brew 'wireguard-tools'
brew 'xz'

# Writing
# brew 'languagetool'  # TODO: this doesn't have an apple silicon bottle yet
brew 'redpen'
brew 'vale'

# Android
brew 'apktool'
brew 'jadx'
brew 'libusb'  # req for Heimdall
brew 'pyqt5'  # req for Heimdall
brew 'simg2img'
# brew 'ext4fuse'  # TODO: deprecated due to dependency on closed-source macfuse, follow instructions below

# https://github.com/gerard/ext4fuse/issues/66#issuecomment-997398243
# curl -s -o ext4fuse.rb https://gist.githubusercontent.com/n-stone/413e407c8fd73683e7e926e10e27dd4e/raw/12b463eb0be3421bdda5db8ef967bfafbaa915c5/ext4fuse.rb
# brew install --formula --build-from-source ./ext4fuse.rb
# rm ./ext4fuse.rb

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
# TODO: this sidebar patch is old and no longer compiles, figure out what to do next
# tap 'sgeb/mutt'
# brew 'sgeb/mutt/mutt', args: ['with-gpgme', 'with-sidebar-patch']

# TODO: dupes is gone, find where gdb is now
# tap 'homebrew/dupes'
# brew 'gdb'

tap 'thoughtbot/formulae'
brew 'liftoff'

# TODO: this tap has invalid syntax, figure out what to do next along with mutt
# tap 'tgray/homebrew-tgbrew'
# brew 'contacts2'
# brew 'muttqt'

tap 'universal-ctags/homebrew-universal-ctags'
# brew 'universal-ctags', args: ['HEAD']  # TODO: this doesn't have an apple silicon bottle yet

# TODO: this is an empty installation, try tapping 'zph/homebrew-cervezas' instead
# tap 'turforlag/homebrew-cervezas'
# brew 'pdftk'

tap 'hudochenkov/sshpass'
brew 'sshpass'

# TODO: this tap has invalid syntax
# tap 'linux-noah/noah'
# brew 'noah'

# TODO: this fails to build on apple silicon
# tap 'facebook/fb'
# brew 'idb-companion'

# tap 'jeffreywildman/homebrew-virt-manager'
# brew 'virt-manager'
# brew 'virt-viewer'

# This extends brew with a "cu" subcommand, only need to tap, no further
# installs
# TODO: is this still necessary?
# tap 'buo/cask-upgrade'

# For creating Windows installation media from https://uupdump.net
brew 'aria2'
brew 'cabextract'
brew 'wimlib'
brew 'cdrtools'
# Normally would install chntpw from sidneys/homebrew, but
# https://github.com/sidneys/homebrew-homebrew/issues/2#issuecomment-885728072
# tap 'sidneys/homebrew'
tap 'minacle/chntpw'
brew 'chntpw'

tap 'gromgit/fuse'
brew 'sshfs-mac'

# Casks
cask '1password'
cask '1password-cli'
cask 'adium'
cask 'adobe-acrobat-reader'
cask 'alfred'
cask 'alt-tab'
cask 'anki'
cask 'appcleaner'
cask 'audacity'
cask 'balenaetcher'
cask 'beardedspice'
cask 'blackhole-2ch'
cask 'blackhole-16ch'
cask 'blender'
cask 'chatterino'
cask 'cheatsheet'
cask 'cron'
cask 'darktable'
cask 'discord'
cask 'dozer'
cask 'dropbox'
cask 'element'
cask 'figma'
cask 'firefox'
# cask 'flash'  # was renamed to flash-npapi, may not want anymore anyway
cask 'focus'
cask 'godot'
cask 'google-chrome'
cask 'google-drive'
# cask 'gpgtools'
cask 'gpg-suite'
cask 'handbrake'
cask 'iglance'
cask 'inkscape'
# cask 'keybase' # TODO: bad CPU type in executable
cask 'krita'
cask 'licecap'
cask 'loading'
cask 'logi-options-plus'
cask 'microsoft-office'
cask 'microsoft-remote-desktop'
cask 'microsoft-teams'
cask 'mixxx'
cask 'natron'
cask 'notion'
cask 'obs'
# cask 'onedrive'  # not necessary if installing microsoft-office
cask 'reaper'
cask 'rectangle'
cask 'resilio-sync'
cask 'rocket'
cask 'shotcut'
cask 'signal'
cask 'sketchbook'
cask 'skype'
cask 'slack'
cask 'spotify'
cask 'stay'
cask 'streamlink-twitch-gui'
cask 'sublime-text'
cask 'telegram'
cask 'the-unarchiver'
cask 'thingsmacsandboxhelper'
cask 'tor-browser'
cask 'transmission'
cask 'utm'
cask 'viscosity'
cask 'vlc'
cask 'vnc-viewer'
cask 'whatsapp'
cask 'zoom'

# Alternatives instead of macOS built-ins Monaco and SF Mono
# cask 'font-fira-mono'
# cask 'font-fira-code-nerd-font'
cask 'font-fira-mono-nerd-font'
# cask 'font-hack-nerd-font'
# cask 'font-sourcecodepro-nerd-font'
# Unavailable
# - office code pro
# - proggy vector

# Development
cask 'android-studio'
cask 'balsamiq-wireframes'
cask 'cutter'
cask 'dash'
# TODO: maybe swap out for rancher, and delete lima/podman above
cask 'docker'  # after first launch/installation it will provide CLI tools, do not install non-cask docker formula
cask 'gas-mask'
cask 'ghidra'
cask 'github'
# cask 'haskell-platform'  # TODO: look into asdf versioning
# cask 'heimdall-suite'  # does not build without PR 468, installed manually
cask 'hex-fiend'
# cask 'hopper-disassembler'  # TODO: no longer exists?
cask 'insomnia'
# TODO: disarm
cask 'jtool2'
cask 'macfuse'
cask 'mactex'
cask 'metasploit'
cask 'oclint'
cask 'ollama'
cask 'vagrant'
# TODO: the oracle kernel extensions aren't working on apple silicon yet
# cask 'virtualbox'
# cask 'virtualbox-extension-pack'
cask 'visual-studio-code'
cask 'vmware-fusion'
cask 'wezterm'
# TODO: https://my.hex-rays.com/dashboard/download-center/9.1/ida-pro

tap 'railwaycat/homebrew-emacsmacport'
cask 'emacs-mac'

# For consideration
# TODO: Postgres.app has an internal check that its real directory is
#       /Applications/Postgres.app/, so even an --appdir=/Applications symlink
#       won't work for it. Would like to eventually fix this.
# cask 'postgres'
# cask 'textexpander'
# cask 'sequel-pro'
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

# Mac App Store

# TODO: add Flow
# TODO: add DaVinci Resolve
# TODO: how to handle iPadOS apps: Apollo, Overcast
# TODO: add Amphetamine
mas 'AdGuard for Safari', id: 1440147259
mas 'Dropover', id: 1355679052
mas 'GarageBand', id: 682658836
mas 'Keynote', id: 409183694
mas 'Pages', id: 409201541
mas 'Things', id: 904280696
mas 'Twitter', id: 1482454543
mas 'VMware Remote Console', id: 1230249825
mas 'WireGuard', id: 1451685025
mas 'Xcode', id: 497799835

# Whalebrews
