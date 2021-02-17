#!/bin/bash

echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# Repos
cd ~
sudo add-apt-repository -y ppa:git-core/ppa
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo add-apt-repository ppa:cwchien/gradle -y

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

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
												git-lfs \
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
												zip \
												zsh

sudo apt-get autoremove -y

# Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
source ~/.bashrc
nvm install --lts
nvm use default

# Micro Editor
cd /usr/local/bin
sudo curl https://getmic.ro | sudo bash

# NPM packages
npm install -g npm@7

# Yarn Packages
yarn global add @angular/cli react-native-cli cjs-to-es6 create-react-app json-server react react-native @react-native-community/cli diff-so-fancy git-jump expo-cli eslint prettier eslint-config-prettier eslint-plugin-prettier npm-check nodemon

# Deleta configs
rm -rf ~/.aliases
rm -rf ~/.bash_profile
rm -rf ~/.bash_prompt
rm -rf ~/.bashrc
rm -rf ~/.curlrc
rm -rf ~/.editorconfig
rm -rf ~/.exports
rm -rf ~/.functions
rm -rf ~/.gitattributes
rm -rf ~/.gitconfig
rm -rf ~/.gvimrc
rm -rf ~/.hushlogin
rm -rf ~/.inputrc
rm -rf ~/.npmrc
rm -rf ~/.profile
rm -rf ~/.screenrc
rm -rf ~/.ssh
rm -rf ~/.tmux.conf
rm -rf ~/.vim
rm -rf ~/.vimrc
rm -rf ~/.wgetrc
rm -rf ~/.yarnrc
rm -rf ~/.zshrc
rm -rf ~/code_editor.sh
rm -rf ~/wsl_path.sh

currentDir=$(pwd)

# Copia configs
ln -s $currentDir/.aliases ~/.aliases
ln -s $currentDir/.bash_profile ~/.bash_profile
ln -s $currentDir/.bash_prompt ~/.bash_prompt
ln -s $currentDir/.bashrc ~/.bashrc
ln -s $currentDir/.curlrc ~/.curlrc
ln -s $currentDir/.editorconfig ~/.editorconfig
ln -s $currentDir/.exports ~/.exports
ln -s $currentDir/.functions ~/.functions
ln -s $currentDir/.gitattributes ~/.gitattributes
ln -s $currentDir/.gitconfig ~/.gitconfig
ln -s $currentDir/.gvimrc ~/.gvimrc
ln -s $currentDir/.hushlogin ~/.hushlogin
ln -s $currentDir/.inputrc ~/.inputrc
ln -s $currentDir/.npmrc ~/.npmrc
ln -s $currentDir/.profile ~/.profile
ln -s $currentDir/.screenrc ~/.screenrc
ln -s $currentDir/.ssh ~/.ssh
ln -s $currentDir/.tmux.conf ~/.tmux.conf
ln -s $currentDir/.vim ~/.vim
ln -s $currentDir/.vimrc ~/.vimrc
ln -s $currentDir/.wgetrc ~/.wgetrc
ln -s $currentDir/.yarnrc ~/.yarnrc
ln -s $currentDir/.zshrc ~/.zshrc
ln -s $currentDir/code_editor.sh ~/code_editor.sh
ln -s $currentDir/wsl_path.sh ~/wsl_path.sh

# Permissão das chaves SSH
chmod 600 ~/.ssh/id_rsa

#ZSH como padrão
sudo sh -c "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)

# Certificados SERPRO
sudo cp certificados_serpro/AC_Raiz_SERPRO.crt /usr/local/share/ca-certificates
sudo cp certificados_serpro/AC_SERPRO_Intra_SSL.crt /usr/local/share/ca-certificates
sudo cp certificados_serpro/acserproacfv5.crt /usr/local/share/ca-certificates
sudo cp certificados_serpro/acserprov4.crt /usr/local/share/ca-certificates
sudo cp certificados_serpro/icpbrasilv5.crt /usr/local/share/ca-certificates
sudo update-ca-certificates

cd ~
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

#Spaceship theme
git clone --depth=1 https://github.com/denysdovhan/spaceship-prompt.git $ZSH_CUSTOM/themes/spaceship-prompt
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

#Powerlevel10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#zsh-syntax-highlighting
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#fast-nvm
git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm

#Flutter
git clone https://github.com/flutter/flutter.git -b stable --depth 1
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor

# Android SDK Tools
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
