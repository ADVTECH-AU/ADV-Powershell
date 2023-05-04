#This script will check the mailbox delegation for all mailboxes in the tenant.

#Install-Module ExchangeOnlineManagement -Force
#Connect-ExchangeOnline

Get-Mailbox | Get-MailboxPermission | where {$_.user.tostring() -ne "NT AUTHORITY\SELF" -and $_.IsInherited -eq $false} | Select Identity,User,AccessRights | FT