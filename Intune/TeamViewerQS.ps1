#What it does: Downloads TeamviewerQS.exe to the Public Desktop

$TeamviewerQSURL = ""

$Test = Test-Path "$env:Public\Desktop\TeamViewerQS.exe" 
if ($Test -eq $false) {
Start-BitsTransfer -Source $TeamviewerQSURL -Destination "$env:PUBLIC\Desktop\TeamViewerQS.exe"
Get-BitsTransfer | Complete-BitsTransfer
Write-Output "Installing Teamviewer At $env:PUBLIC\Desktop" 
}
else {
    Write-Output "File Already Exists"
} 
