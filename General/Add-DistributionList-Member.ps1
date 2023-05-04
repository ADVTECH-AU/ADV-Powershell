#This script will add a user to a distribution list in Exchange Online.

Param(
    [string]$DLName,
    [string]$User
)

Connect-ExchangeOnline 

Add-DistributionGroupMember -Identity $DLName -member $User.PrimarySmtpAddress

Disconnect-ExchangeOnline -Confirm:$false
