#This script will add a user to a mailbox in Exchange Online.

param (
    [string]$Mailbox,
    [String]$User
)

Connect-ExchangeOnline 

Add-MailboxPermission -Identity $Mailbox -User $User -AccessRights FullAccess
Add-RecipientPermission -Identity $Mailbox -Trustee $User -AccessRights SendAs -Confirm:$false

Disconnect-ExchangeOnline -Confirm:$false