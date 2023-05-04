#This script will enroll a device in Autopilot and upload the hardware hash to Intune.

Set-ExecutionPolicy Bypass Process
Install-Script -name Get-WindowsAutopilotInfo -Force
Get-WindowsAutopilotInfo -Online
