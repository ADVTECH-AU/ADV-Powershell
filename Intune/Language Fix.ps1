#This script will set the language of the device to English (Australia).

Set-ExecutionPolicy -ExecutionPolicy Bypass -scope Process -forcew
$1 = New-WinUserLanguageList en-AU
Set-WinUserLanguageList $1 -confirm:$false -force