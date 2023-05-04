#This script will create a shared mailbox and then add the users you specify to the mailbox with FullAccess and SendAs permissions.

param(
    [Parameter(Mandatory=$true)]
    [string]$Name,
    [Parameter(Mandatory=$true)]
    [string]$Email
    [Parameter(Mandatory=$true)]
    Write-Host "Enter the users you want to add to the shared mailbox, separated by a comma."
    [string]$Users
)

$Users1 = $Users -split ","

Connect-ExchangeOnline

New-Mailbox -Shared -Name $Name -PrimarySmtpAddress $Email -Force 

ForEach ($User in $Users1) {
    Add-MailboxPermission -Identity $Name -User $User -AccessRights FullAccess -InheritanceType All -AutoMapping $true
    Add-MailboxPermission -Identity $Name -User $User -AccessRights SendAs -InheritanceType All -AutoMapping $true
}

Disconnect-ExchangeOnline -Confirm:$False