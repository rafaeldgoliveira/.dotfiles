Import-Module posh-git
Import-Module oh-my-posh

Set-PoshPrompt -Theme powerlevel10k_modern

# Dracula readline configuration. Requires version 2.0, if you have 1.2 convert to `Set-PSReadlineOption -TokenType`
Set-PSReadlineOption -Color @{
	"Command" = [ConsoleColor]::Green
	"Parameter" = [ConsoleColor]::Gray
	"Operator" = [ConsoleColor]::Magenta
	"Variable" = [ConsoleColor]::White
	"String" = [ConsoleColor]::Yellow
	"Number" = [ConsoleColor]::Blue
	"Type" = [ConsoleColor]::Cyan
	"Comment" = [ConsoleColor]::DarkCyan
}

# Dracula Prompt Configuration
$GitPromptSettings.DefaultPromptPrefix.Text = "$([char]0x2192) " # arrow unicode symbol
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
$GitPromptSettings.DefaultPromptPath.ForegroundColor =[ConsoleColor]::Cyan
$GitPromptSettings.DefaultPromptSuffix.Text = "$([char]0x203A) " # chevron unicode symbol
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = [ConsoleColor]::Magenta

# Dracula Git Status Configuration
$GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::Blue

## Aliases
New-Alias g git
New-Alias cc clear
New-Alias sudo gsudo

function suu()
{
	sudo choco upgrade all -y
	ngu
	ygu
}

function wr
{
	wsl --shutdown
	# Start-Process powershell.exe -Args "wsl"
	sudo .\WSL2_Network.ps1
}

#npm aliases
function nlg
{
	npm list -g --depth=0
}
function ngu
{
	npm update -g
}
function nck
{
	npm-check -u
}

#yarn aliases
function yg
{
	yarn global list
}
function ygu
{
	yarn global upgrade
}
function yup
{
	yarn upgrade-interactive --latest
}
