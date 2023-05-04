#This script will update the Teams Library ID to use the Desktop app.

$Path = "HKLM:\Software\Microsoft\Office\ClickToRun\Configuration"
$Name = "ProductReleaseIds"
$Type = "string"
$Value = "O365ProPlusRetail"

Set-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value 