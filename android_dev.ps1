#Requires -RunAsAdministrator

sudo ~\wsl2_network.ps1
sudo ~\kill_port.ps1

adb kill-server
adb -a -P 5037 nodaemon server
