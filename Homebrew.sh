#!/bin/sh

# Homebrew Script for OSX
# To execute: save and `chmod +x ./brew-install-script.sh` then `./brew-install-script.sh`

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

echo " "
echo "Update homebrew recipes"
brew update

echo " "
echo "Install GNU core utilities (those that come with OS X are outdated)"
brew install coreutils
brew install gnu-tar
brew install gnu-indent
brew install gnu-which
brew install grep
brew install htop

echo " "
echo "Install GNU find, locate, updatedb, and xargs, g-prefixed"
brew install findutils

echo " "
echo "Install Bash 4"
brew install bash

brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk
brew install git
brew install httpie
brew install wget
brew install ack
brew install nvm
brew install node@12
echo 'export PATH="/usr/local/opt/node@12/bin:$PATH"' >> ~/.zshrc
brew install autoconf
brew install automake
brew install ffmpeg
brew install gettext
brew install imagemagick
brew install jq
brew install libjpeg
brew install fzf
brew install libmemcached
brew install lynx
brew install markdown
brew install memcached
brew install pkg-config
brew install pypy
brew install rename
brew install watchman
brew install ssh-copy-id
brew install terminal-notifier
brew install the_silver_searcher
brew cask install android-studio
brew cask install google-chrome
brew cask install firefox
brew cask install daisydisk
brew tap homebrew/cask-fonts
brew cask install font-fira-code
brew install pandoc
brew install pandoc-citeproc
brew install librsvg python homebrew/cask/basictex
tlmgr install collection-fontsrecommended
brew install youtube-dl
brew cask install anki
brew cask install visual-studio-code
brew cask install steam
brew cask install megasync
brew cask install kext-updater
brew cask install kext-utility
brew cask install epic-games
brew install p7zip
brew cask install calibre
brew cask install android-messages
brew cask install yacreader
brew cask install discord
brew cask install evernote
brew cask install iterm2
brew cask install handbrake
brew cask install google-backup-and-sync
brew cask install caffeine
brew cask install transmission
brew cask install virtualbox
brew cask install virtualbox-extension-pack
brew cask install libreoffice
brew cask install spotify
brew install nmap
brew install openssh
brew install python3
brew cask install veracrypt
brew cask install xmind
brew cask install gpg-suite
brew install microsoft-edge
brew install zsh
brew cask install stremio
brew cask install ccleaner
brew install yarn
brew cask install insomnia

curl https://getmic.ro | bash

echo " "
echo "Configurando o node para o zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
echo 'export PATH="/usr/local/opt/node@12/bin:$PATH"' >> ~/.zshrc
export LDFLAGS="-L/usr/local/opt/node@12/lib"
export CPPFLAGS="-I/usr/local/opt/node@12/include"
sudo chmod g-w /usr/local/share/zsh /usr/local/share/zsh/site-functions
sudo chmod o-w /usr/local/share/zsh /usr/local/share/zsh/site-functions

echo " "
echo "Installing Python packages..."
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

echo " "
echo "Installing Ruby gems"
RUBY_GEMS=(
    bundler
    filewatcher
    cocoapods
)
sudo gem install ${RUBY_GEMS[@]}
sudo gem install cocoapods

echo " "
echo "Cleaning up..."
brew cleanup

echo " "
echo "Installing global npm packages..."
npm install -g @angular/cli cjs-to-es6 create-react-app json-server npm npm-check react react-native @react-native-community/cli diff-so-fancy git-jump --force

echo " "
echo "Configuring OSX..."

echo " "
echo "Set fast key repeat rate"
# defaults write NSGlobalDomain KeyRepeat -int 0

echo " "
echo "Require password as soon as screensaver or sleep mode starts"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo " "
echo "Enable tap-to-click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo " "
echo "Bootstrapping complete"

echo " "
echo "Increasing the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo " "
echo "Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo " "
echo "Disabling automatic termination of inactive apps"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

echo " "
echo "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo " "
echo "Disable smart quotes and smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo " "
echo "Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo " "
echo "Enabling full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo " "
echo "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo " "
echo "Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo " "
echo "Enable HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

echo " "
echo "Showing icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo " "
echo "Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo " "
echo "Showing status bar in Finder by default"
defaults write com.apple.finder ShowStatusBar -bool true

echo " "
echo "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo " "
echo "Displaying full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo " "
echo "Disabling the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo " "
echo "Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist


echo " "
echo "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

echo " "
echo "Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

echo " "
echo "Setting Dock to auto-hide and removing the auto-hiding delay"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

echo " "
echo "Enabling Safari debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo " "
echo "Allow hitting the Backspace key to go to the previous page in history"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo " "
echo "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo " "
echo "Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo " "
echo "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo " "
echo "Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

echo " "
echo "Preventing Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

echo " "
echo "Define as credenciais do Git"
git config --global user.email "rafadiego.gomes@gmail.com"
git config --global user.name "Rafael Diego Gomes de Oliveira"
git config --global credential.helper "cache --timeout=7200"
git config --global pull.rebase false
git config --global core.eol lf

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

echo "NPM Config"
npm config set init.license MIT
npm config set init.author.name "Rafael Diego Gomes de Oliveira"
npm config set init.author.email rafadiego.gomes@gmail.com
