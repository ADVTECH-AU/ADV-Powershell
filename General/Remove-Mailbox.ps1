#This script will remove a user from a mailbox in Exchange Online.

param (
    [string]$Mailbox,
    [String]$User
)

$AzureCredential = Get-AutomationPSCredential -Name 'Powershell'

Connect-ExchangeOnline -Credential $AzureCredential

Remove-MailboxPermission -Identity $Mailbox -User $User -AccessRights FullAccess -Confirm:$false
Remove-RecipientPermission -Identity $Mailbox -Trustee $User -AccessRights SendAs -Confirm:$false

Disconnect-ExchangeOnline -Confirm:$false