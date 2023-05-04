#Enables Online Archiving for a mailbox (Requires Suitable Licence)
#Enter Mailbox UPN
$User = ""

#Import-Module ExchangeOnlineManagement

Connect-ExchangeOnline

Start-ManagedFolderAssistant -Identity $User

Disconnect-ExchangeOnline -Confirm:$false
