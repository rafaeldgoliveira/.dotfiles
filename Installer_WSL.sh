#!/bin/bash

BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
WHITE="\033[0;37m"

currentDir=$(pwd)

echo -e "${GREEN}Aumentando o número de arquivos observados pelo SO...${WHITE}"
sudo sed -i '$ d' /etc/sysctl.conf
echo -e fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# Repos
echo -e "${GREEN}Adicionando os repositórios...${WHITE}"
cd $HOME
sudo add-apt-repository -y ppa:git-core/ppa
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo -e "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo add-apt-repository ppa:cwchien/gradle -y

echo -e "${GREEN}Atualizando o SO...${WHITE}"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

echo -e "${GREEN}Instalando os Apps...${WHITE}"
sudo apt-get install -y adoptopenjdk-8-hotspot \
												apt-transport-https \
												bash \
												build-essential \
												ca-certificates \
												curl \
												docker-ce \
												file \
												findutils \
												fonts-firacode \
												fonts-powerline \
												fzf \
												git \
												git-extras \
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
												pipenv \
												pypy3 \
												python3 \
												software-properties-common \
												speedtest-cli \
												unzip \
												wget \
												yarn \
												tree \
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
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.bashrc
nvm install --lts
nvm use default

# Micro Editor
echo -e "${GREEN}Instalando e configurando o Micro Editor...${WHITE}"
cd /usr/local/bin
sudo curl https://getmic.ro | sudo bash

# Yarn Packages
echo -e "${GREEN}Instalando os pacotes Yarn...${WHITE}"
yarn global add @angular/cli react-native-cli cjs-to-es6 create-react-app json-server react react-native @react-native-community/cli diff-so-fancy git-jump expo-cli eslint prettier eslint-config-prettier eslint-plugin-prettier npm-check nodemon local-web-server

Deleta configs
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
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.wgetrc
rm -rf $HOME/.yarnrc
rm -rf $HOME/.zshrc

currentDir=$(pwd)
echo -e "${GREEN}Deletando e extraindo as chaves SSH...${WHITE}"
sudo rm -rf $HOME/.ssh
sudo rm -rf $currentDir/.ssh
7z e $currentDir/.ssh.zip -o$currentDir/.ssh

# Copia configs
echo -e "${GREEN}Criando os links simbólicos para as configurações...${WHITE}"
ln -s $currentDir/.ssh $HOME/.ssh
ln -s $currentDir/.aliases $HOME/.aliases
ln -s $currentDir/.bash_profile $HOME/.bash_profile
ln -s $currentDir/.bash_prompt $HOME/.bash_prompt
ln -s $currentDir/.bashrc $HOME/.bashrc
ln -s $currentDir/.curlrc $HOME/.curlrc
ln -s $currentDir/.editorconfig $HOME/.editorconfig
ln -s $currentDir/.exports $HOME/.exports
ln -s $currentDir/.functions $HOME/.functions
ln -s $currentDir/.gitattributes $HOME/.gitattributes
ln -s $currentDir/.gitconfig $HOME/.gitconfig
ln -s $currentDir/.gvimrc $HOME/.gvimrc
ln -s $currentDir/.hushlogin $HOME/.hushlogin
ln -s $currentDir/.inputrc $HOME/.inputrc
ln -s $currentDir/.npmrc $HOME/.npmrc
ln -s $currentDir/.profile $HOME/.profile
ln -s $currentDir/.screenrc $HOME/.screenrc
ln -s $currentDir/.tmux.conf $HOME/.tmux.conf
ln -s $currentDir/.vim $HOME/.vim
ln -s $currentDir/.vimrc $HOME/.vimrc
ln -s $currentDir/.wgetrc $HOME/.wgetrc
ln -s $currentDir/.yarnrc $HOME/.yarnrc
ln -s $currentDir/.zshrc $HOME/.zshrc

# Permissão das chaves SSH
echo -e "${GREEN}Corrigindo as permissões das chaves SSH...${WHITE}"
sudo chmod -R 600 $HOME/.ssh

# Certificados SERPRO
echo -e "${GREEN}Instalando os certificados do SERPRO...${WHITE}"
sudo cp certificados_serpro/AC_Raiz_SERPRO.crt /usr/local/share/ca-certificates
sudo cp certificados_serpro/AC_SERPRO_Intra_SSL.crt /usr/local/share/ca-certificates
sudo cp certificados_serpro/acserproacfv5.crt /usr/local/share/ca-certificates
sudo cp certificados_serpro/acserprov4.crt /usr/local/share/ca-certificates
sudo cp certificados_serpro/icpbrasilv5.crt /usr/local/share/ca-certificates
sudo update-ca-certificates

echo -e "${GREEN}Instalando e definindo o ZSH como padrão...${WHITE}"
cd ~
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo sh -c "echo -e $(which zsh) >> /etc/shells" && chsh -s $(which zsh)

#Spaceship theme
echo -e "${GREEN}Instalando o Spaceship theme...${WHITE}"
git clone --depth=1 https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CUSTOM/themes/spaceship-prompt
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

#Powerlevel10k theme
echo -e "${GREEN}Instalando o Powerlevel10k theme...${WHITE}"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo -e "${GREEN}Instalando o zsh-autosuggestions...${WHITE}"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#zsh-syntax-highlighting
echo -e "${GREEN}Instalando o zsh-syntax-highlighting...${WHITE}"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#fast-nvm
echo -e "${GREEN}Instalando o fast-nvm...${WHITE}"
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

#Flutter
echo -e "${GREEN}Instalando o Flutter SDK...${WHITE}"
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor

# Android SDK Tools
echo -e "${GREEN}Configurando o AndroidSDK...${WHITE}"
# Update: https://developer.android.com/studio/#downloads > "Command line tools only"
wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip

mkdir Android
unzip commandlinetools-linux-6858069_latest -d Android/cmdline-tools
rm commandlinetools-linux-6858069_latest.zip

export JAVA_HOME=/usr/lib/jvm/adoptopenjdk-8-hotspot-amd64
export PATH="$PATH:$JAVA_HOME/bin"

cd ~/Android/cmdline-tools/tools/bin
./sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3"

export ANDROID_HOME=/home/rafael/Android
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/tools"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# https://developer.android.com/studio/command-line/sdkmanager
./sdkmanager --update
