#When one user has access to another users shared mailbox this enables the saving of sent items to the primary email
#user account who is sending the email
$Users = Get-Mailbox

Connect-ExchangeOnline

foreach ($User in $Users) {
    Set-Mailbox -Identity $User -MessageCopyForSentAsEnabled $True -MessageCopyForSendOnBehalfEnabled $True
}
Disconnect-ExchangeOnline -Confirm:$False