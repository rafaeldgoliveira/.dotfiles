#!/bin/bash

BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"

scriptDir=$(pwd)

echo -e "${GREEN}Aumentando o número de arquivos observados pelo SO...${WHITE}"
sudo sed -i '$ d' /etc/sysctl.conf
echo -e fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# Repos
echo -e "${GREEN}Adicionando os repositórios...${WHITE}"
cd $HOME
sudo add-apt-repository -y ppa:git-core/ppa
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo -e "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 23E7166788B63E1E

wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8AC3B29174885C03

sudo add-apt-repository ppa:cwchien/gradle -y

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

echo -e "${GREEN}Atualizando o SO...${WHITE}"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo -e "${GREEN}Instalando os Apps...${WHITE}"
sudo apt-get install -y adoptopenjdk-8-hotspot \
	apt-transport-https \
	bash \
	build-essential \
	curl \
	file \
	findutils \
	fzf \
	git \
	google-chrome-stable \
	gradle \
	grep \
	htop \
	lib32z1 \
	libssl-dev \
	moreutils \
	net-tools \
	nmap \
	p7zip-full \
	p7zip-rar \
	pandoc \
	pipenv \
	pypy3 \
	python3 \
	software-properties-common \
	speedtest-cli \
	tree \
	unzip \
	wget \
	yarn \
	zip \
	zsh

sudo apt-get autoremove -y

# Prepara para pt_BR
echo -e "${GREEN}Configurando o idioma...${WHITE}"
sudo locale-gen pt_BR.UTF-8
sudo dpkg-reconfigure locales
sudo update-locale LANG=pt_BR.UTF-8
echo -e "${YELLOW}O idioma foi definido para: $(cat /etc/default/locale)${WHITE}"

# Node
echo -e "${GREEN}Instalando e configurando o NODEJS...${WHITE}"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.bashrc
nvm install --lts
nvm use default

# Yarn Packages
echo -e "${GREEN}Instalando os pacotes Yarn...${WHITE}"
yarn global add react-native-cli cjs-to-es6 create-react-app json-server react react-native @react-native-community/cli diff-so-fancy git-jump expo-cli eslint prettier nodemon local-web-server

# NPM Packages
echo -e "${GREEN}Instalando os pacotes NPM...${WHITE}"
npm install -g npm-check @angular/cli npm

echo -e "${GREEN}Deletando e extraindo as chaves SSH...${WHITE}"
sudo rm -rf $HOME/.ssh
sudo rm -rf $scriptDir/.ssh
7z e $scriptDir/.ssh.zip -o$scriptDir/.ssh

echo -e "${GREEN}Instalando o ZSH...${WHITE}"
cd ~
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "${GREEN}Instalando o Spaceship theme...${WHITE}"
git clone --depth=1 https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}//themes/spaceship-prompt
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo -e "${GREEN}Instalando o Powerlevel10k theme...${WHITE}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo -e "${GREEN}Instalando o zsh-autosuggestions...${WHITE}"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo -e "${GREEN}Instalando o zsh-syntax-highlighting...${WHITE}"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo -e "${GREEN}Instalando o fast-nvm...${WHITE}"
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

# Android SDK Tools
echo -e "${GREEN}Configurando o AndroidSDK...${WHITE}"
cd ~

# Update: https://developer.android.com/studio/#downloads > "Command line tools only"
wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
mkdir -p Android/cmdline-tools
unzip commandlinetools-linux-6858069_latest -d Android/cmdline-tools
mv ~/Android/cmdline-tools/cmdline-tools/ ~/Android/cmdline-tools/tools
rm commandlinetools-linux-6858069_latest.zip

export JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64
export PATH="$PATH:$JAVA_HOME/bin"

cd ~/Android/cmdline-tools/tools/bin
./sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3"

export ANDROID_HOME=/home/rafael/Android
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/tools"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

https://developer.android.com/studio/command-line/sdkmanager
./sdkmanager --update

Flutter
echo -e "${GREEN}Instalando o Flutter SDK...${WHITE}"
cd ~
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:$(pwd)/flutter/bin"
flutter doctor --android-licenses
flutter doctor

# Deleta configs
echo -e "${GREEN}Deletando as configurações existentes...${WHITE}"
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
rm -rf $HOME/.npmrc
rm -rf $HOME/.profile
rm -rf $HOME/.screenrc
rm -rf $HOME/.tmux.conf
rm -rf $HOME/.vimrc
rm -rf $HOME/.wgetrc
rm -rf $HOME/.yarnrc
rm -rf $HOME/.ssh
rm -rf $HOME/.vim
rm -rf $HOME/.zshrc
sudo rm -rf /etc/wsl.conf

# Links simbólicos
echo -e "${GREEN}Criando os links simbólicos para as configurações...${WHITE}"
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
sudo ln -s $scriptDir/.wsl.conf /etc/wsl.conf

# Permissão das chaves SSH
echo -e "${GREEN}Corrigindo as permissões das chaves SSH...${WHITE}"
sudo chmod -R 400 $HOME/.ssh/*

# echo -e "${GREEN}Definindo o ZSH como padrão...${WHITE}"
sudo sh -c "echo -e $(which zsh) >> /etc/shells" && chsh -s $(which zsh)
