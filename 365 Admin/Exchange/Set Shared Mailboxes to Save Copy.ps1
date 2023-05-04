
Connect-ExchangeOnline

$Users = Get-Mailbox

foreach ($User in $Users) {
    Set-Mailbox -Identity $User -MessageCopyForSentAsEnabled $True -MessageCopyForSendOnBehalfEnabled $True
}

Disconnect-ExchangeOnline -Confirm:$False