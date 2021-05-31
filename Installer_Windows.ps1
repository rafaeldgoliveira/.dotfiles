#Requires -RunAsAdministrator

Write-Host "Não use o WindowsTerminal para executar esse script ou as configurações dele não serão sobrescritas" -ForegroundColor Red
Write-Host "Instale e INICIE 1 vez os seguintes aplicativos pela Microsoft Store:" -ForegroundColor Green
Write-Host "	Windows Terminal (Abrir antes de continuar)" -ForegroundColor Yellow
Write-Host "	Seu Telefone" -ForegroundColor Yellow
Write-Host "	ITunes" -ForegroundColor Yellow
Write-Host "	Whatsapp" -ForegroundColor Yellow
Write-Host "	Spotify" -ForegroundColor Yellow
Write-Host "	Telegram" -ForegroundColor Yellow
Write-Host "	Prime Video" -ForegroundColor Yellow
Write-Host "	Bluetooth Audio Receiver" -ForegroundColor Yellow
Write-Host "	Netflix" -ForegroundColor Yellow
Write-Host "	Xbox" -ForegroundColor Yellow
Write-Host "	Procurar 'extensões' na MS Store" -ForegroundColor Yellow
$title   = '-----------------------------------------'
Write-Host "	Configure o OneDrive para o drive D" -ForegroundColor Yellow
$msg     = 'Já instalou os aplicativos?'
$options = '&S', '&N'
$default = 1  # 0=S, 1=N

Write-Host "Instala alguns apps pré-determinados..." -ForegroundColor Green
$exeApplications = @(
	# '3uTools_v2.56.012_Setup',
	# 'Battle.net',
	# 'Bloody7',
	# 'Caption',
	# 'DeviceRemover',
	# 'BetterDiscord',
	# 'Kaspersky Total Security',
	# 'MSI_Kombustor4',
	# 'MSIAfterburner',
	# 'QTTabBar',
	# 'RemotePlayInstaller',
	# 'RTSS',
	# 'SamsungDeX',
	# 'SmartSwitchPC',
	# 'WeMod',
	# 'FreeFileSync',
	# 'NVIDIA_RTX_Voice',
	# 'VdhCoApp',
	# 'Samsung_Magician',
	# 'TeraCopy Pro 3.6.0.4\TeraCopy Pro 3.6.0.4',
	# 'Foxit PhantomPDF Business 10.0.1.35811 + Crack\FoxitPhantomPDF1001_L10N_Setup_Website',
	# 'G5 5590\Dell-Update-Application-for-Windows-10_7CKK6_WIN_4.1.0_A00'
	# 'G5 5590\SupportAssist-Update-Plugin-Application_5K3C0_WIN_5.1.0.11858_A00'
)
ForEach ($item in $exeApplications)
{
	Write-Host "Instalando o aplicativo: $item" -ForegroundColor Green
	Start-Process "D:\Mega\Aplicativos Windows\$item.exe" -Wait -Verb runas
}

do
{
	$response = $Host.UI.PromptForChoice($title, $msg, $options, $default)
} until ($response -eq 0)

function Reload-Profile
{
	@(
		$Profile.AllUsersAllHosts,
		$Profile.AllUsersCurrentHost,
		$Profile.CurrentUserAllHosts,
		$Profile.CurrentUserCurrentHost
	) | % {
		if(Test-Path $_)
		{
			Write-Verbose "Running $_"
			. $_
		}
	}
}


function Remove-ItemAlternative
{
	[cmdletbinding()]
	param(
		[alias('LiteralPath')][string] $Path,
		[switch] $SkipFolder
	)
	if ($Path -and (Test-Path -LiteralPath $Path))
	{
		$Items = Get-ChildItem -LiteralPath $Path -Recurse
		foreach ($Item in $Items)
		{
			try
			{
				$Item.Delete()
			} catch
			{
				Write-Warning "Remove-ItemAlternative - Couldn't delete $($Item.FullName), error: $($_.Exception.Message)"
			}
		}
		if (-not $SkipFolder)
		{
			$Item = Get-Item -LiteralPath $Path
			try
			{
				$Item.Delete($true)
			} catch
			{
				Write-Warning "Remove-ItemAlternative - Couldn't delete $($Item.FullName), error: $($_.Exception.Message)"
			}
		}
	} else
	{
		Write-Warning "Remove-ItemAlternative - Path $Path doesn't exists. Skipping. "
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
	batteryinfoview `
	bulkrenameutility `
	calibre `
	ccleaner `
	choco-cleaner `
	choco-upgrade-all-at-startup `
	chrome-remote-desktop-chrome `
	cpu-z `
	crystaldiskmark `
	ddu `
	discord `
	docker-compose `
	docker-desktop `
	dropbox `
	ds4windows `
	epicgameslauncher `
	evernote `
	rufus `
	ffmpeg-batch `
	firefox `
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
	megasync `
	mo2 `
	mp3gain `
	mp3gain-gui `
	mp3tag `
	nodejs-lts `
	pandoc `
	powertoys `
	processhacker `
	python3 `
	recuva `
	remove-empty-directories `
	revo-uninstaller `
	rufus `
	samsung-nvme-driver `
	samsung-usb-driver `
	screentogif `
	steam `
	steam-cleaner `
	stremio `
	throttlestop `
	transmission `
	treesizefree `
	twitch `
	unchecky `
	veracrypt `
	virtualbox `
	vlc `
	vscode `
	wirelessnetview `
	xmind `
	yarn `
	yacreader `
	unity-hub `
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
New-Item -ItemType SymbolicLink -Path $WTSettings -Target $currentDir'\Preferences\windows_terminal.json'

# Hosts
Write-Host "Criando o link para o arquivo de hosts..." -ForegroundColor Green
# Copy-Item $currentDir'\.hosts.windows' -Destination 'C:\Windows\System32\drivers\etc\hosts'
Remove-Item 'C:\Windows\System32\drivers\etc\hosts' -Recurse -Force
New-Item -ItemType SymbolicLink -Path 'C:\Windows\System32\drivers\etc\hosts' -Target $currentDir'\.hosts'

# Executa as alterações no registro do Windows
Write-Host "Executando as alterações no registro do Windows..." -ForegroundColor Green
reg import $currentDir'\Windows_Registry\Disable_Snipping_Tool\Disable_Snipping_Tool.reg'
reg import $currentDir'\Windows_Registry\Disable-Bing-in-the-Start-Menu\Disable Bing Searches.reg'
reg import $currentDir'\Windows_Registry\Disable-Cortana\Disable Cortana.reg'
reg import $currentDir'\Windows_Registry\Long-Path-Names-Hacks\Remove 260 Character Path Limit.reg'
reg import $currentDir'\Windows_Registry\NVIDIA Control Panel Language Changer\English_US_400.reg'
reg import $currentDir'\Windows_Registry\PinCCF\unPinCCF.reg'
reg import $currentDir'\Windows_Registry\Remove-3D-Objects-Folder\Remove 3D Objects Folder (64-bit Windows).reg'
reg import $currentDir'\Windows_Registry\Remove-Folders-From-This-PC-on-Windows-10\64-bit versions of Windows 10\Remove All User Folders From This PC 64-bit.reg'
reg import $currentDir'\Windows_Registry\Taskbar Last Active Click Hacks\Enable Last Active Click.reg'
reg import $currentDir'\Windows_Registry\Time Fix - Windows\Windows Universal Time - On.reg'

# Cria link simbolico para backups da Apple
Write-Host "Criando um link simbolico para a pasta de backups Apple..." -ForegroundColor Green
Remove-Item '%HOMEPATH%\Apple\MobileSync\Backup'
New-Item -Path '%HOMEPATH%\Apple\MobileSync' -ItemType directory
New-Item -ItemType SymbolicLink -Path '%HOMEPATH%\Apple\MobileSync\Backup' -Target 'D:\Backups\Apple'

# Oh-My-Posh
Write-Host "Instalando e configurando o Oh-My-Posh..." -ForegroundColor Green
Remove-Item 'D:\OneDrive\Documentos\WindowsPowerShell\Microsoft.PowerShell_profile.ps1' -Force
Remove-ItemAlternative -Path "D:\OneDrive\Documentos\WindowsPowerShell\Modules"
Remove-ItemAlternative -Path "D:\OneDrive\Documentos\WindowsPowerShell\Scripts"
& .\Update-Powershell-Modules.ps1
Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease -Force
Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
New-Item -ItemType SymbolicLink -Path 'D:\OneDrive\Documentos\WindowsPowerShell\Microsoft.PowerShell_profile.ps1' -Target $currentDir'\Preferences\powershell_profile.ps1'

Reload-Profile

# Yarn Packages
Write-Host "Instalando os pacotes Yarn..." -ForegroundColor Green
yarn global add react-native-cli cjs-to-es6 create-react-app json-server react react-native @react-native-community/cli diff-so-fancy git-jump expo-cli eslint prettier nodemon local-web-server

# NPM Packages
Write-Host "Instalando os pacotes NPM..." -ForegroundColor Green
npm install -g npm-check @angular/cli npm

# Plugins para discord
Write-Host "Baixando os plugins para o Discord..." -ForegroundColor Green
Write-Host "É necessário instalar manualmente o Discord Better App" -ForegroundColor Yellow
[string]$downloadDir = $env:USERPROFILE+'\AppData\Roaming\BetterDiscord\plugins\'
Remove-ItemAlternative -Path  $downloadDir
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

#Tema para o Files
Write-Host "Copiando o tema do Files" -ForegroundColor Green
[string]$FilesFolder = Resolve-Path %userprofile%\AppData\Local\Packages\*FilesUWP*\LocalState\
New-Item -ItemType directory -Path $FilesFolder'\Themes'
New-Item -ItemType SymbolicLink -Path $FilesFolder'\Themes\Dracula.files.xaml' -Target $currentDir'\Themes\Dracula.files.xaml'

# Tema para o Powershell
Write-Host "Instando o tema Dracula no Powershell" -ForegroundColor Green
& Themes\Powershell\install.cmd
Write-Host "É interessante setar a cor da Barra de Titulos do Windows para: #262835" -ForegroundColor Yellow
