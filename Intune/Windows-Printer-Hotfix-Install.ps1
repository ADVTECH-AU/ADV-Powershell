#This script will install the Windows Printer Hotfix KB5001567 on a device.

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
Install-Module PSWindowsUpdate -Force
Import-Module PSWindowsUpdate -Force
Install-WindowsUpdate -KBArticleID "Kb5001567" -IgnoreReboot
#Remove-WindowsUpdate -KBArticleID "kb5000808,kb5000802" -IgnoreReboot
