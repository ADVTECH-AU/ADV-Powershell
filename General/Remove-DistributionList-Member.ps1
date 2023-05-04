#This script will remove a user from a distribution list in Exchange Online.

Param(
    [string]$DLName,
    [string]$User
)

Connect-ExchangeOnline 

Remove-DistributionGroupMember -Identity $DLName -member $User.PrimarySmtpAddress

Disconnect-ExchangeOnline -Confirm:$false