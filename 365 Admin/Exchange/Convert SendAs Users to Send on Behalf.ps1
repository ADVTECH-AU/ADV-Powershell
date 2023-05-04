#This script will convert all SendAs permissions to Send on Behalf permissions for all Shared Mailboxes in your tenant.

Connect-ExchangeOnline

$SharedMailboxes = Get-Mailbox -RecipientTypeDetails SharedMailbox

Foreach ($SMailbox in $SharedMailboxes) {
    $Users1 = Get-RecipientPermission -Identity $SMailbox -AccessRights SendAs | where {$_.trustee.tostring() -ne "NT AUTHORITY\SELF"} | Select Trustee
    $Users = $Users1.Trustee
    Foreach ($User in $Users) {
        Write-Host $User has Send As permissions to $SMailbox -ForegroundColor Blue
        try {
            Remove-RecipientPermission -Identity $SMailbox -Trustee $User -AccessRights SendAs -Confirm:$false
            #Set-Mailbox -Identity $SMailbox -GrantSendOnBehalfTo $User
            Write-Host "Set $User to Send on Behalf for Mailbox $SMailbox" -ForegroundColor Green
        } catch {
            Write-Host "Error Adding Send on Behalf permissions to $SMailbox for $User" -ForegroundColor Red
        }
    }
}

Disconnect-ExchangeOnline -Confirm:$false