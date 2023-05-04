#Removes Users immutableid Field.

Connect-MsolService

$UserUPN = ""

Get-MsolUser -UserPrincipalName $UserUPN | Set-MsolUser -ImmutableId $null

Disconnect-MsolService -Confirm:$false