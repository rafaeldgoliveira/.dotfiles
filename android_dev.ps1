#Requires -RunAsAdministrator

sudo .\WSL2_Network.ps1
sudo .\Kill-Port.ps1

adb kill-server
adb -a -P 5037 nodaemon server
