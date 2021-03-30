#Requires -RunAsAdministrator

Write-Host "Instale os seguintes aplicativos pela Microsoft Store:" -ForegroundColor Green
Write-Host "	Windows Terminal" -ForegroundColor Yellow
Write-Host "	Seu Telefone" -ForegroundColor Yellow
$title   = '-----------------------------------------'
$msg     = 'Já instalou os aplicativos?'
$options = '&S', '&N'
$default = 1  # 0=S, 1=N

do {
    $response = $Host.UI.PromptForChoice($title, $msg, $options, $default)
} until ($response -eq 0)

function Reload-Profile {
    @(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost
    ) | % {
        if(Test-Path $_){
            Write-Verbose "Running $_"
            . $_
        }
    }    
}

# Renomeia o computador
Write-Host "Renomeando o computador para 'Rafael-Windows'" -ForegroundColor Green
Rename-Computer -NewName "Rafael-Windows"

# Instala o Chocolatey
Write-Host "Instalando o Chocolatey" -ForegroundColor Green
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Instala os pacotes
Write-Host "Instalando os pacotes do Chocolatey" -ForegroundColor Green
choco install 7zip `
					adoptopenjdk8 `
					androidstudio `
					anki `
					autohotkey `
					bulkrenameutility`
					calibre `
					ccleaner `
					choco-cleaner `
					choco-upgrade-all-at-startup `
					chrome-remote-desktop-chrome `
					cpu-z `
					crystaldiskmark `
					ddu `
					discord `
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
					google-backup-and-sync `
					googlechrome `
					gpu-z `
					gradle `
					gsudo `
					handbrake `
					hwmonitor `
					insomnia-rest-api-client `
					irfanview `
					lame `
					libreoffice-fresh `
					linkshellextension `
					lockhunter `
					logitech-options `
					megasync`
					mo2 `
					mp3gain `
					mp3gain-gui `
					mp3tag `
					nodejs-lts `
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
					samsung-magician`
					samsung-nvme-driver `
					samsung-usb-driver `
					spotify `
					steam `
					steam-cleaner `
					stremio `
					throttlestop `
					transmission `
					treesizefree `
					twitch`
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
					youtube-dl-gui --ignore-checksums -y 

[string]$currentDir = Get-Location
[string]$WTSettings = Resolve-Path ~\AppData\Local\Packages\Microsoft.WindowsTerminalPreview*\LocalState\settings.json

# Deleta as configurações existentes
Write-Host "Deletando as configurações existentes..." -ForegroundColor Green
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
(Get-Item '~\.ssh').Delete()
Remove-Item $WTSettings -Force

# Extrai chaves SSH
Remove-Item $currentDir'\.ssh' -Recurse -Force
Write-Host "Deletando e extraindo as chaves SSH..." -ForegroundColor Green
7z e $currentDir'\.ssh.zip' -o'.ssh'

# Cria os links simbólicos
Write-Host "Criando os links simbólicos para as configurações..." -ForegroundColor Green
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

# Hosts
Write-Host "Criando o link para o arquivo de hosts..." -ForegroundColor Green
# Copy-Item $currentDir'\.hosts.windows' -Destination 'C:\Windows\System32\drivers\etc\hosts'
sudo Remove-Item 'C:\Windows\System32\drivers\etc\hosts' -Recurse -Force
New-Item -ItemType SymbolicLink -Path 'C:\Windows\System32\drivers\etc\hosts' -Target $currentDir'\.hosts.windows'

# Importa certificados do SERPRO
Write-Host "Instalando os certificados do SERPRO..." -ForegroundColor Green
Import-Certificate -Filepath $currentDir\certificados_serpro\AC_Raiz_SERPRO.crt -CertStoreLocation 'Cert:\CurrentUser\Root'
Import-Certificate -Filepath $currentDir\certificados_serpro\AC_SERPRO_Intra_SSL.crt -CertStoreLocation 'Cert:\CurrentUser\Root'
Import-Certificate -Filepath $currentDir\certificados_serpro\acserproacfv5.crt -CertStoreLocation 'Cert:\CurrentUser\Root'
Import-Certificate -Filepath $currentDir\certificados_serpro\acserprov4.crt -CertStoreLocation 'Cert:\CurrentUser\Root'
Import-Certificate -Filepath $currentDir\certificados_serpro\icpbrasilv5.crt -CertStoreLocation 'Cert:\CurrentUser\Root'

# Executa as alterações no registro do Windows
Write-Host "Executando as alterações no registro do Windows..." -ForegroundColor Green
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
Write-Host "Criando um link simbolico para a pasta de backups Apple..." -ForegroundColor Green
Remove-Item '~\AppData\Roaming\Apple Computer\MobileSync\Backup'
New-Item -Path '~\AppData\Roaming\Apple Computer\MobileSync' -ItemType directory
New-Item -ItemType SymbolicLink -Path '~\AppData\Roaming\Apple Computer\MobileSync\Backup' -Target 'D:\Backups\Apple'

# Oh-My-Posh
Write-Host "Instalando e configurando o Oh-My-Posh..." -ForegroundColor Green
Remove-Item '~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1' -Force
Install-Module PowershellGet -Force
. Reload-Profile
Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease -Force
Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
New-Item -ItemType SymbolicLink -Path '~\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1' -Target $currentDir'\prefs\powershell_profile.ps1'

# Yarn Packages
Write-Host "Instalando os pacotes Yarn..." -ForegroundColor Green
yarn global add @angular/cli react-native-cli cjs-to-es6 create-react-app json-server react react-native @react-native-community/cli diff-so-fancy git-jump expo-cli eslint prettier eslint-config-prettier eslint-plugin-prettier npm-check nodemon local-web-server

# Plugins para discord
Write-Host "Baixando os plugins para o Discord..." -ForegroundColor Green
Write-Host "É necessário instalar manualmente o Discord Better App" -ForegroundColor Yellow
[string]$downloadDir = $env:USERPROFILE+'\AppData\Roaming\BetterDiscord\plugins\'
New-Item -Path $downloadDir -ItemType directory
Invoke-WebRequest -Uri https://raw.githubusercontent.com/1Lighty/BetterDiscordPlugins/master/Plugins/BetterImageViewer/BetterImageViewer.plugin.js -OutFile $downloadDir'\BetterImageViewer.plugin.js'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/1Lighty/BetterDiscordPlugins/master/Plugins/MessageLoggerV2/MessageLoggerV2.plugin.js -OutFile $downloadDir'\MessageLoggerV2.plugin.js'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/mwittrien/BetterDiscordAddons/master/Plugins/BetterFriendList/BetterFriendList.plugin.js -OutFile $downloadDir'\BetterFriendList.plugin.js'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/mwittrien/BetterDiscordAddons/master/Plugins/BetterSearchPage/BetterSearchPage.plugin.js -OutFile $downloadDir'\BetterSearchPage.plugin.js'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/mwittrien/BetterDiscordAddons/master/Plugins/CompleteTimestamps/CompleteTimestamps.plugin.js -OutFile $downloadDir'\CompleteTimestamps.plugin.js'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/mwittrien/BetterDiscordAddons/master/Plugins/GameActivityToggle/GameActivityToggle.plugin.js -OutFile $downloadDir'\GameActivityToggle.plugin.js'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/mwittrien/BetterDiscordAddons/master/Plugins/ReadAllNotificationsButton/ReadAllNotificationsButton.plugin.js -OutFile $downloadDir'\ReadAllNotificationsButton.plugin.js'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/mwittrien/BetterDiscordAddons/master/Plugins/SendLargeMessages/SendLargeMessages.plugin.js -OutFile $downloadDir'\SendLargeMessages.plugin.js'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/mwittrien/BetterDiscordAddons/master/Plugins/SpotifyControls/SpotifyControls.plugin.js -OutFile $downloadDir'\SpotifyControls.plugin.js'
Invoke-WebRequest -Uri https://raw.githubusercontent.com/mwittrien/BetterDiscordAddons/master/Plugins/SteamProfileLink/SteamProfileLink.plugin.js -OutFile $downloadDir'\SteamProfileLink.plugin.js'

Write-Host "Instala alguns apps pré-determinados..." -ForegroundColor Green
$exeApplications = @(
'3uTools',
'Battle.net',
'Bloody7',
'Caption',
'DeviceRemover',
'Discord Better App',
'Easy Window Switcher',
'intelhaxm-android',
'iTunes',
'Kaspersky Total Security',
'MSI_Kombustor4',
'MSIAfterburner',
'QTTabBar',
'RemotePlayInstaller',
'RTSS',
'SamsungDeX',
'SmartSwitchPC',
'TeraCopy Pro 3.6.0.4\TeraCopy Pro 3.6.0.4',
'Wondershare PDFelement Professional v7.6.8.5031\pdfelement-pro_full5239',
'G5 5590\Alienware-Command-Center-Application_J4MMM_WIN_5.2.106.0_A00_01',
'G5 5590\Alienware-OC-Controls-Application_XXFYP_WIN64_1.3.21.1340_A00',
'G5 5590\Dell-Power-Manager-Service_7866H_WIN64_3.7.0_A00',
'G5 5590\Dell-Update-Application-for-Windows-10_7CKK6_WIN_4.1.0_A00'
)
ForEach ($item in $exeApplications) {
	Write-Host "Instalando o aplicativo: $item" -ForegroundColor Green
	Start-Process "D:\Mega\Aplicativos Windows\$item.exe" -Wait -Verb runas
}

$msiApplications = @(
'CorsairHeadset',
'IntelPowerGadget'
)
ForEach ($item in $msiApplications) {
	Write-Host "Instalando o aplicativo: $item" -ForegroundColor Green
	Start-Process "D:\Mega\Aplicativos Windows\$item.msi" -Wait -Verb runas
}

