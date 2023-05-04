#This script will set the forwarding address for a mailbox in Exchange Online.

$ForwardingAddress = ''
$MailboxtoForward = ''

Connect-ExchangeOnline
Set-Mailbox $MailboxtoForward -ForwardingAddress $ForwardingAddress -DeliverToMailboxAndForward $true

Disconnect-ExchangeOnline -Confirm:$false