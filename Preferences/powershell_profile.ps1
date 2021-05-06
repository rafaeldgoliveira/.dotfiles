Import-Module posh-git
Import-Module oh-my-posh

Set-PoshPrompt -Theme powerlevel10k_lean

## Aliases
New-Alias g git
New-Alias cc clear
New-Alias sudo gsudo

function suu() {Start-Process -Verb RunAs powershell.exe -Args "choco upgrade all -y"}

function wr {
  # wsl --shutdown
  # Start-Process powershell.exe -Args "wsl"
  sudo .\WSL2_Network.ps1
}

#npm aliases
function nlg {npm list -g --depth=0}
function ngu {npm update -g}
function nck {npm-check -u}

#yarn aliases
function yg {yarn global list}
function ygu {yarn global upgrade}
function yup {yarn upgrade-interactive --latest}
