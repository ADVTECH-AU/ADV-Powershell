#This script will get the mailbox permissions for a user.

param(
    [Parameter (Mandatory= $true)]
    [string]$Email
)
$AzureCredential = Get-AutomationPSCredential -Name 'Powershell'
Connect-ExchangeOnline -Credential $AzureCredential

Get-MailboxPermission $Email | Select User

Disconnect-ExchangeOnline -Confirm:$false