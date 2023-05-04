#This script will remove the desktop shortcuts for the following applications:
#Run as System
Write-Output "Remove Desktop Shortcut Script"
<# Has to be deployed in intunes as a run as system Script #>
Set-ExecutionPolicy Bypass -Scope Process -Force

if ((Test-Path 'C:\Users\Public\Desktop\Google Chrome.lnk') -eq $true) {Remove-Item 'C:\Users\Public\Desktop\Google Chrome.lnk' -Force}

if ((Test-Path 'C:\Users\Public\Desktop\VLC media player.lnk') -eq $true) {Remove-Item 'C:\Users\Public\Desktop\VLC media player.lnk' -Force}

if ((Test-Path 'C:\Users\Public\Desktop\Firefox.lnk') -eq $true) {Remove-Item 'C:\Users\Public\Desktop\Firefox.lnk' -Force}

if ((Test-Path 'C:\Users\Public\Desktop\Microsoft Edge.lnk') -eq $true) {Remove-Item 'C:\Users\Public\Desktop\Microsoft Edge.lnk' -Force}

if ((Test-Path 'C:\Users\Public\Desktop\TeamViewer.lnk') -eq $true) {Remove-Item 'C:\Users\Public\Desktop\TeamViewer.lnk' -Force}

Write-Output "Remove Desktop Shortcut Script"
<# Has be Deployed in intune as a run as user script#>
Set-ExecutionPolicy Bypass -Scope Process -Force

if ((Test-Path $env:OneDrive'\Desktop\Google Chrome.lnk') -eq $true) {Remove-Item $env:OneDrive'\Desktop\Google Chrome.lnk' -Force}

if ((Test-Path $env:OneDrive'\Desktop\VLC media player.lnk') -eq $true) {Remove-Item $env:OneDrive'\Desktop\VLC media player.lnk' -Force}

if ((Test-Path $env:OneDrive'\Desktop\Firefox.lnk') -eq $true) {Remove-Item $env:OneDrive'\Desktop\Firefox.lnk' -Force}

if ((Test-Path $env:OneDrive'\Desktop\Microsoft Edge.lnk') -eq $true) {Remove-Item $env:OneDrive'\Desktop\Microsoft Edge.lnk' -Force}

if ((Test-Path $env:OneDrive'\Desktop\TeamViewer.lnk') -eq $true) {Remove-Item $env:OneDrive'\Desktop\TeamViewer.lnk' -Force}