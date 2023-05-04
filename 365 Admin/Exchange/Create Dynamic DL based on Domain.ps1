#This script will create a dynamic distribution group based on the users of a certain domain you specify.

$Domain = ""
$DLName = ""

Connect-ExchangeOnline

#Create Dynamic DL
New-DynamicDistributionGroup -name $DLName -RecipientFilter "(RecipientTypeDetails -eq 'UserMailbox') -and (WindowsLiveID -eq '*@$Domain')"

#To check its membership
$group = Get-DynamicDistributionGroup $DLName
Get-Recipient -RecipientPreviewFilter $group.RecipientFilter

Disconnect-ExchangeOnline -Confirm:$false

