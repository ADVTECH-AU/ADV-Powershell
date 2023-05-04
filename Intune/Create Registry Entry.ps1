#This script creates a registry entry.

$Path = ""
$Name = ""
$Type = ""
$Value = ""

if ((Test-Path $Path) -eq $False) {New-Item -Path $Path -Name $Name -Value $Value -Force}
