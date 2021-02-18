#Requires -RunAsAdministrator

Write-Host "Antes de prosseguir com script é necessário instalar alguns aplicativos pela Microsoft Store."
Write-Host "-----------------------------------------"
Write-Host "   Windows Terminal Preview"
Write-Host "-----------------------------------------"
Write-Host ""
Write-Host ""
Write-Host "Aplicativos sugeridos:"
Write-Host "   Alienware Command Center"
Write-Host "   Seu Telefone"
Write-Host "-----------------------------------------"
Write-Host ""
Write-Host ""
Write-Host "Aperte qualquer tecla para continuar..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# Instala o Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Instala os pacotes
choco install 7zip `
							adoptopenjdk8 `
							androidstudio `
							anki `
							autohotkey `
							bulkrenameutility -y --ignore-checks `
							calibre `
							ccleaner `
							choco-cleaner `
							choco-upgrade-all-at-startup `
							chrome-remote-desktop-chrome `
							cpu-z `
							crystaldiskmark `
							ddu `
							discord `
							docker-cli `
							docker-compose `
							docker-desktop `
							dropbox `
							ds4windows `
							epicgameslauncher `
							evernote `
							ffmpeg-batch `
							firacodenf `
							firefox `
							freefilesync `
							fzf `
							gamesavemanager `
							geforce-experience `
							git `
							git-lfs `
							google-backup-and-sync `
							googlechrome `
							gpu-z `
							gradle `
							gsudo `
							handbrake `
							hwmonitor `
							icloud `
							insomnia-rest-api-client `
							irfanview `
							itunes `
							lame `
							libreoffice-fresh `
							linkshellextension `
							lockhunter `
							megasync -y --ignore-check `
							mo2 `
							mp3gain `
							mp3gain-gui `
							mp3tag `
							nodejs-lts `
							origin `
							partitionwizard `
							picpick.portable `
							powershell-core `
							powertoys `
							processhacker `
							python3 `
							recuva `
							reflect-free `
							remove-empty-directories `
							revo-uninstaller `
							samsung-magician -y --ignore-checks `
							samsung-nvme-driver `
							samsung-usb-driver `
							spotify `
							steam `
							stremio `
							transmission `
							treesizefree `
							twitch -y --ignore-checks `
							unchecky `
							veracrypt `
							virtualbox `
							virtualbox-guest-additions-guest.install `
							vlc `
							vscode `
							whatsapp `
							win32diskimager	 `
							wirelessnetview `
							xmind `
							yarn `
							youtube-dl-gui -y

[string]$currentDir = Get-Location
[string]$WTSettings = Resolve-Path ~\AppData\Local\Packages\Microsoft.WindowsTerminalPreview*\LocalState\settings.json

# Deleta as configurações existentes
Remove-Item '~\.editorconfig' -Force
Remove-Item '~\.gitattributes' -Force
Remove-Item '~\.gitconfig' -Force
Remove-Item '~\.npmrc' -Force
Remove-Item '~\.wslconfig' -Force
Remove-Item '~\.yarnrc' -Force
Remove-Item '~\android_dev.ps1' -Force
Remove-Item '~\kill_port.ps1' -Force
Remove-Item '~\wsl2_network.ps1' -Force
Remove-Item '~\.ssh' -Recurse -Force
Remove-Item '.\.ssh\' -Recurse -Force

Remove-Item $WTSettings -Force

# Extrai chaves SSH
7z e $currentDir'\.ssh.zip' -o'.ssh'

# Cria os links simbólicos
New-Item -ItemType SymbolicLink -Path '~\.ssh' -Target $currentDir'\.ssh'
New-Item -ItemType SymbolicLink -Path '~\.editorconfig' -Target $currentDir'\.editorconfig'
New-Item -ItemType SymbolicLink -Path '~\.gitattributes' -Target $currentDir'\.gitattributes'
New-Item -ItemType SymbolicLink -Path '~\.gitconfig' -Target $currentDir'\.gitconfig'
New-Item -ItemType SymbolicLink -Path '~\.npmrc' -Target $currentDir'\.npmrc'
New-Item -ItemType SymbolicLink -Path '~\.wslconfig' -Target $currentDir'\.wslconfig'
New-Item -ItemType SymbolicLink -Path '~\.yarnrc' -Target $currentDir'\.yarnrc'
New-Item -ItemType SymbolicLink -Path '~\android_dev.ps1' -Target $currentDir'\android_dev.ps1'
New-Item -ItemType SymbolicLink -Path '~\kill_port.ps1' -Target $currentDir'\kill_port.ps1'
New-Item -ItemType SymbolicLink -Path '~\wsl2_network.ps1' -Target $currentDir'\wsl2_network.ps1'
New-Item -ItemType SymbolicLink -Path $WTSettings -Target $currentDir'\prefs\windows_terminal.json'

# Importa certificados do SERPRO
Import-Certificate -Filepath $currentDir\certificados_serpro\AC_Raiz_SERPRO.crt -CertStoreLocation 'Cert:\CurrentUser\Root'
Import-Certificate -Filepath $currentDir\certificados_serpro\AC_SERPRO_Intra_SSL.crt -CertStoreLocation 'Cert:\CurrentUser\Root'
Import-Certificate -Filepath $currentDir\certificados_serpro\acserproacfv5.crt -CertStoreLocation 'Cert:\CurrentUser\Root'
Import-Certificate -Filepath $currentDir\certificados_serpro\acserprov4.crt -CertStoreLocation 'Cert:\CurrentUser\Root'
Import-Certificate -Filepath $currentDir\certificados_serpro\icpbrasilv5.crt -CertStoreLocation 'Cert:\CurrentUser\Root'

# Executa as alterações no registro do Windows
reg import $currentDir'\windows_regs\Disable_Snipping_Tool\Disable_Snipping_Tool.reg'
reg import $currentDir'\windows_regs\Disable-Bing-in-the-Start-Menu\Disable Bing Searches.reg'
reg import $currentDir'\windows_regs\Disable-Cortana\Disable Cortana.reg'
reg import $currentDir'\windows_regs\Long-Path-Names-Hacks\Remove 260 Character Path Limit.reg'
reg import $currentDir'\windows_regs\NVIDIA Control Panel Language Changer\English_US_400.reg'
reg import $currentDir'\windows_regs\PinCCF\unPinCCF.reg'
reg import $currentDir'\windows_regs\Remove-3D-Objects-Folder\Remove 3D Objects Folder (64-bit Windows).reg'
reg import $currentDir'\windows_regs\Remove-Folders-From-This-PC-on-Windows-10\64-bit versions of Windows 10\Remove All User Folders From This PC 64-bit.reg'
reg import $currentDir'\windows_regs\Taskbar Last Active Click Hacks\Enable Last Active Click.reg'
reg import $currentDir'\windows_regs\Time Fix - Windows\Windows Universal Time - On.reg'

# Cria link simbolico para backups da Apple
Remove-Item '~\AppData\Roaming\Apple Computer\MobileSync\Backup'
New-Item -ItemType SymbolicLink -Path '~\AppData\Roaming\Apple Computer\MobileSync\Backup' -Target 'D:\Backups\Apple'

Set-Alias -Name sudo -Value gsudo

# Oh-My-Posh
Remove-Item 'D:\OneDrive\Documentos\PowerShell\Microsoft.PowerShell_profile.ps1'
Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease
Install-Module posh-git -Scope CurrentUser -AllowPrerelease
Update-Module oh-my-posh -Scope CurrentUser
Update-Module posh-git -Scope CurrentUser
New-Item -ItemType SymbolicLink -Path 'D:\OneDrive\Documentos\PowerShell\Microsoft.PowerShell_profile.ps1' -Target $currentDir'\prefs\powershell_profile.ps1'

# Yarn Packages
yarn global add @angular/cli react-native-cli cjs-to-es6 create-react-app json-server react react-native @react-native-community/cli diff-so-fancy git-jump expo-cli eslint prettier eslint-config-prettier eslint-plugin-prettier npm-check nodemon

# NPM packages
npm install -g npm@7
