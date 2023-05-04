#Bulk Updates User Fields

$From = ''
$To = ''
Get-ADUser -Filter {Department -like $From} | Set-ADUser -Department $To