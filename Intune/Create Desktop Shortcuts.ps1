#This script creates desktop shortcuts for Outlook, Excel, and Word.

$TargetFile = "C:\Program Files\Microsoft Office\root\Office16\outlook.exe"
$DesktopPath = "$env:PUBLIC\Desktop"
$ShortcutFile = "$DesktopPath\Outlook.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()

$TargetFile1 = "C:\Program Files\Microsoft Office\root\Office16\excel.exe"
$DesktopPath1 = "$env:PUBLIC\Desktop"
$ShortcutFile1 = "$DesktopPath1\Excel.lnk"
$WScriptShell1 = New-Object -ComObject WScript.Shell
$Shortcut1 = $WScriptShell1.CreateShortcut($ShortcutFile1)
$Shortcut1.TargetPath = $TargetFile1
$Shortcut1.Save()

$TargetFile2 = "C:\Program Files\Microsoft Office\root\Office16\winword.exe"
$DesktopPath2 = "$env:PUBLIC\Desktop"
$ShortcutFile2 = "$DesktopPath2\Word.lnk"
$WScriptShell2 = New-Object -ComObject WScript.Shell
$Shortcut2 = $WScriptShell2.CreateShortcut($ShortcutFile2)
$Shortcut2.TargetPath = $TargetFile2
$Shortcut2.Save()