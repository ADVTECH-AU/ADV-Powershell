#This script will get the current calendar access for a mailbox and then set the default to AvailabilityOnly and then add the user you specify to the calendar with Editor access.

$Mailbox = ""
$User = ""

Connect-ExchangeOnline

Get-MailboxFolderPermission -Identity $Mailbox":\Calendar" | Select Identity,User,AccessRights
Set-MailboxFolderPermission -Identity $Mailbox":\Calendar" -User "default" -AccessRights AvailabilityOnly
Add-MailboxFolderPermission -Identity $Mailbox":\Calendar" -User $User -AccessRights Editor

Disconnect-ExchangeOnline -confirm:$false