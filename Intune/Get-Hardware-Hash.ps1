#This script will get the hardware hash of a device and save it to a CSV file.

#For Hybrid Worker use Only

New-Item -Type Directory -Path "C:\HWID"
Set-Location -Path "C:\HWID"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
Install-Script -Name Get-WindowsAutoPilotInfo -Force -Confirm:$false
Get-WindowsAutoPilotInfo.ps1 -OutputFile AutoPilotHWID.csv