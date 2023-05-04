#This script will query Active Directory for a list of users.

$OUs = ""
$Body1 = $OUs | Foreach {Get-ADUser -Filter * -Properties * -SearchBase $_} | Select Name,Company,Department,Title,Description
$Body = $Body1 | Format-Table
Write-output $Body
