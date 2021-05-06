# `chmod +x ./Installer macOS` then `./Installer macOS.sh`
#!/bin/sh

BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"

scriptDir=$(pwd)

# Renomeia computador
echo "${GREEN}Renomeando o computador para 'Rafael-macOS'...${WHITE}"
# scutil --set ComputerName "Rafael-macOS"
# scutil --set LocalHostName "Rafael-macOS"
# scutil --set HostName "Rafael-macOS"

echo "${GREEN}Instala as versões do XCode...${WHITE}"
xcode-select --install

# Aumenta o número de arquivos observados pelo SO
echo "${GREEN}Aumentando o número de arquivos observados pelo SO...${WHITE}"
sudo sysctl -w kern.maxfiles=524288

# Cria o link simbólico para o arquivo de hosts
echo "${GREEN}Criando o link para o arquivo de hosts...${WHITE}"
sudo rm -rf /private/etc/hosts
sudo ln -s "$(pwd)/.hosts" /private/etc/hosts

# Instala o Homebrew
if test ! $(which brew); then
    echo "${GREEN}Instalando o Homebrew...${WHITE}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Atualiza as formular do Homebrew
echo "${GREEN}Atualiza homebrew recipes${WHITE}"
brew update
brew upgrade

# Adiciona os repositórios do Homebrew
echo "${GREEN}Adiciona Third-Party Repositories to Homebrew${WHITE}"
brew tap AdoptOpenJDK/openjdk
brew tap bramstein/webfonttools
brew tap homebrew/cask-fonts

# Pacotes
echo "${GREEN}Instala os pacotes do Homebrew${WHITE}"
brew install --cask adoptopenjdk8 \
                    android-messages \
                    android-studio \
                    anki \
                    caffeine \
                    calibre \
                    ccleaner \
                    daisydisk \
                    discord \
                    docker \
                    epic-games \
                    evernote \
                    firefox \
                    font-Fira-Code-nerd-font \
                    google-backup-and-sync \
                    google-chrome \
                    handbrake \
                    insomnia \
                    iterm2 \
                    libreoffice \
                    megasync \
                    spotify \
                    steam \
                    stremio \
                    transmission \
                    veracrypt \
                    virtualbox \
                    virtualbox-extension-pack \
                    visual-studio-code \
                    xmind \
                    yacreader

brew install ack \
             automake \
             bash \
             bash-completion2 \
             coreutils \
             ffmpeg \
             findutils \
             fzf \
             gettext \
             git \
             git-lfs \
             gmp \
             gnu-indent \
             gnu-sed \
             gnu-tar \
             gnu-which \
             gnupg \
             gradle \
             grep \
             gs \
             htop \
             httpie \
             imagemagick \
             jq \
             libjpeg \
             libmemcached \
             librsvg \
             python \
             homebrew/cask/basictex \
             lua \
             lynx \
             luarocks \
             markdown \
             memcached \
             microsoft-edge \
             moreutils \
             nmap \
             node@14 \
             nvm \
             openssh \
             p7zip \
             pandoc \
             pigz \
             pkg-config \
             pv \
             pypy \
             python3 \
             rename \
             rlwrap \
             screen \
             sfnt2woff \
             sfnt2woff-zopfli \
             speedtest-cli \
             ssh-copy-id \
             terminal-notifier \
             the_silver_searcher \
             tree \
             unzip \
             vbindiff \
             vim \
             watchman \
             wget \
             woff2 \
             yarn \
             youtube-dl \
             zopfli \
             zsh

brew cleanup

# Oh-My-Zsh
echo "${GREEN}Instalando o Oh-My-ZSH${WHITE}"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "${GREEN}Instalando o Spaceship theme...${WHITE}"
git clone --depth=1 https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}//themes/spaceship-prompt
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "${GREEN}Instalando o Powerlevel10k theme...${WHITE}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "${GREEN}Instalando o zsh-autosuggestions...${WHITE}"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "${GREEN}Instalando o zsh-syntax-highlighting...${WHITE}"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "${GREEN}Instalando o fast-nvm...${WHITE}"
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

# Python
echo "${GREEN}Instalando pacotes do Python...${WHITE}"
PYTHON_PACKAGES=(
    ipython
    virtualenv
    virtualenvwrapper
)
sudo pip install ${PYTHON_PACKAGES[@]}

# Ruby
echo "${GREEN}Instalando Ruby gems${WHITE}"
RUBY_GEMS=(
    bundler
    filewatcher
    cocoapods
)
sudo gem install ${RUBY_GEMS[@]}
sudo gem install cocoapods

# NPM
echo "${GREEN}Instalando pacotes NPM...${WHITE}"
npm install -g npm-check @angular/cli npm

# YARN
echo "${GREEN}Instalando pacotes YARN...${WHITE}"
yarn global add react-native-cli cjs-to-es6 create-react-app json-server react react-native @react-native-community/cli diff-so-fancy git-jump expo-cli eslint prettier nodemon local-web-server

# Configurações
echo "${GREEN}Exigir senha assim que o protetor de tela ou o modo de espera iniciar${WHITE}"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

echo "${GREEN}Habilita tap-to-click${WHITE}"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "${GREEN}Aumentando a velocidade de redimensionamento da janela para aplicativos Cocoa${WHITE}"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "${GREEN}Expandindo o painel de salvamento por padrão${WHITE}"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

echo "${GREEN}Desativando o encerramento automático de aplicativos inativos${WHITE}"
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

echo "${GREEN}Revele o endereço IP, nome do host, versão do sistema operacional, etc. ao clicar no relógio na janela de login${WHITE}"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo "${GREEN}Desative aspas e travessões inteligentes porque são irritantes ao digitar o código${WHITE}"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "${GREEN}Aumentar a qualidade do som para fones de ouvido/headsets Bluetooth${WHITE}"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

echo "${GREEN}Ativar o acesso total do teclado para todos os controles (por exemplo, ativar a guia em caixas de diálogo modais)${WHITE}"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

echo "${GREEN}Desligue a iluminação do teclado quando o computador não for usado por 5 minutos${WHITE}"
defaults write com.apple.BezelServices kDimTime -int 300

echo "${GREEN}Ativando a renderização de fonte de subpixel em LCDs não Apple${WHITE}"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo "${GREEN}Ativar modos de exibição HiDPI (requer reinicialização)${WHITE}"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

echo "${GREEN}Mostrando ícones de discos rígidos, servidores e mídia removível na área de trabalho${WHITE}"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

echo "${GREEN}Mostrando todas as extensões de nome de arquivo no Finder por padrão${WHITE}"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "${GREEN}Mostrando a barra de status no Finder por padrão${WHITE}"
defaults write com.apple.finder ShowStatusBar -bool true

echo "${GREEN}Permitindo a seleção de texto no Quick Look / Preview no Finder por padrão${WHITE}"
defaults write com.apple.finder QLEnableTextSelection -bool true

echo "${GREEN}Exibindo o caminho completo do POSIX como título da janela do Finder${WHITE}"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "${GREEN}Desativando o aviso ao alterar uma extensão de arquivo${WHITE}"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "${GREEN}Habilitando o ajuste à grade para ícones na área de trabalho e em outras visualizações de ícones${WHITE}"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

echo "${GREEN}Definindo o tamanho do ícone dos itens do Dock para 36 pixels para um tamanho de tela ideal${WHITE}"
defaults write com.apple.dock tilesize -int 36

echo "${GREEN}Acelerando as animações do Mission Control e agrupando as janelas por aplicativo${WHITE}"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

echo "${GREEN}Configurando o Dock para ocultar automaticamente e removendo o atraso de ocultação automática${WHITE}"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

echo "${GREEN}Ativando o menu de depuração do Safari${WHITE}"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

echo "${GREEN}Permitir pressionar a tecla Backspace para ir para a página anterior do histórico${WHITE}"
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

echo "${GREEN}Ativando o menu Desenvolver e o Inspetor da Web no Safari${WHITE}"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

echo "${GREEN}Adicionar um item de menu de contexto para mostrar o Inspetor da Web em visualizações da web${WHITE}"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "${GREEN}Configurando endereços de e-mail para copiar como 'foo@example.com' em vez de 'Foo Bar <foo@example.com>' em Mail.app${WHITE}"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "${GREEN}Habilitando UTF-8 SOMENTE no Terminal.app e configurando o tema Pro por padrão${WHITE}"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

echo "${GREEN}Evitando que o Time Machine solicite o uso de novos discos rígidos como volume de backup${WHITE}"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Flutter
echo "${GREEN}Instalando o Flutter SDK...${WHITE}"
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor
flutter doctor --android-licenses

# Chaves SSH
echo "${GREEN}Deletando e extraindo as chaves SSH...${WHITE}"
sudo rm -rf $HOME/.ssh
sudo rm -rf $scriptDir/.ssh
7z e $scriptDir/.ssh.zip -o$scriptDir/.ssh
echo "${GREEN}Corrigindo as permissões das chaves SSH...${WHITE}"
sudo chmod -R 400 $HOME/.ssh/*

# Deleta configs
echo "${GREEN}Remove as configurações${WHITE}"
rm -rf $HOME/.aliases
rm -rf $HOME/.bash_profile
rm -rf $HOME/.bash_prompt
rm -rf $HOME/.bashrc
rm -rf $HOME/.curlrc
rm -rf $HOME/.editorconfig
rm -rf $HOME/.exports
rm -rf $HOME/.functions
rm -rf $HOME/.gitattributes
rm -rf $HOME/.gitconfig
rm -rf $HOME/.gvimrc
rm -rf $HOME/.hushlogin
rm -rf $HOME/.inputrc
rm -rf $HOME/.macos
rm -rf $HOME/.npmrc
rm -rf $HOME/.profile
rm -rf $HOME/.screenrc
rm -rf $HOME/.tmux.conf
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.wgetrc
rm -rf $HOME/.yarnrc
rm -rf $HOME/.zshrc
rm -rf '$HOME/Library/Application Support/Spectacle/Shortcuts.json'

# Links simbólicos
echo "${GREEN}Criando os links simbólicos para as configurações...${WHITE}"
ln -s $scriptDir/.aliases $HOME/.aliases
ln -s $scriptDir/.bash_profile $HOME/.bash_profile
ln -s $scriptDir/.bash_prompt $HOME/.bash_prompt
ln -s $scriptDir/.bashrc $HOME/.bashrc
ln -s $scriptDir/.curlrc $HOME/.curlrc
ln -s $scriptDir/.editorconfig $HOME/.editorconfig
ln -s $scriptDir/.exports $HOME/.exports
ln -s $scriptDir/.functions $HOME/.functions
ln -s $scriptDir/.gitattributes $HOME/.gitattributes
ln -s $scriptDir/.gitconfig $HOME/.gitconfig
ln -s $scriptDir/.gvimrc $HOME/.gvimrc
ln -s $scriptDir/.hushlogin $HOME/.hushlogin
ln -s $scriptDir/.inputrc $HOME/.inputrc
ln -s $scriptDir/.macos $HOME/.macos
ln -s $scriptDir/.npmrc $HOME/.npmrc
ln -s $scriptDir/.profile $HOME/.profile
ln -s $scriptDir/.screenrc $HOME/.screenrc
ln -s $scriptDir/.ssh $HOME/.ssh
ln -s $scriptDir/.tmux.conf $HOME/.tmux.conf
ln -s $scriptDir/.vim $HOME/.vim
ln -s $scriptDir/.vimrc $HOME/.vimrc
ln -s $scriptDir/.wgetrc $HOME/.wgetrc
ln -s $scriptDir/.yarnrc $HOME/.yarnrc
ln -s $scriptDir/.zshrc $HOME/.zshrc
ln -s $scriptDir/Preferences/spectacle.json '$HOME/Library/Application Support/Spectacle/Shortcuts.json'

echo "${GREEN}Definindo o ZSH como padrão...${WHITE}"
sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)