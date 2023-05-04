#Uninstalls Windows 10 Mail

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
Get-AppxPackage Microsoft.windowscommunicationsapps | Remove-AppxPackage