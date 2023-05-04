#This script will generate a report of the number of emails sent and received by each user in the organization.

$info = get-mailbox -ResultSize Unlimited |
foreach{
    $received = (Get-MessageTrace -RecipientAddress $_.UserPrincipalName -StartDate "$((get-date).ToShortDateString()) 00:00:00" -EndDate "$((get-date).ToShortDateString()) 23:59:59").count
    $send     = (Get-MessageTrace -SenderAddress $_.UserPrincipalName -StartDate "$((get-date).ToShortDateString()) 00:00:00" -EndDate "$((get-date).ToShortDateString()) 23:59:59").count

    new-object psobject -Property @{
        UserName     = $_.UserPrincipalName
        SendCount    = $send
        ReceiveCount = $received
        Date         = (get-date).ToShortDateString()
    }
}

$info