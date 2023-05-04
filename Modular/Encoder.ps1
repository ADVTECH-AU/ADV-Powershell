#This script will encode a string to Base64.

$Text = Get-Content -Path ""
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText =[Convert]::ToBase64String($Bytes)
$EncodedText
