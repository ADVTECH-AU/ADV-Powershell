#This script will create a RDP shortcut on the desktop of the user.

#For Deployment of RDP Desktop Shortcuts for terminal server environments via Intune.
$RDSName = "test"
$Connection = "test.com"

$Test = Test-Path "$env:PUBLIC\Desktop\$RDSName.lnk" 
if ($Test -eq $false) {
    $wshshell = New-Object -ComObject WScript.Shell
    $rdp = $wshshell.CreateShortcut("$env:PUBLIC\Desktop\$RDSName.lnk")
    $rdp.TargetPath = "%windir%\system32\mstsc.exe"
    $rdp.Arguments = "/v:$Connection"
    $rdp.Description = $RDSName
    $rdp.Save()
}
else {
Write-Output "File Already Exists"
} 
