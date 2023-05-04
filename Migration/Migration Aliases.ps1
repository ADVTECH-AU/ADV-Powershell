#This script will add aliases to shared mailboxes.

$Mailboxes = Get-mailbox -RecipientTypeDetails SharedMailbox | Select PrimarySMTPAddress,Name

#$Mailbox = ""
#$domains = "",""

ForEach ($mailbox in $Mailboxes) {
        Foreach ($domain in $domains) {
        Set-Mailbox $mailbox.PrimarySmtpAddress -EmailAddresses @{Add=$mailbox.Name+$domain}
        }
}

ForEach ($Mailbox in $Mailboxes.Name) {
    #Get-Mailbox $Mailbox.PrimarySmtpAddress | select name,emailaddresses 
    Get-Mailbox $Mailbox | select -ExpandProperty emailaddresses | Select-String -Pattern "smtp" -CaseSensitive | export-csv C:\temp\ExportSharedAlias.csv -Append
}

#$Username = Get-Mailbox $Mailbox | Select Name

#Adding Aliases
#Foreach ($domain in $domains) {
#    Set-Mailbox $mailbox -EmailAddresses @{Add=$Username+$domain}
#}

#Remove Aliases
#Foreach ($domain in $domains) {
#    Set-Mailbox $Mailbox -EmailAddresses @{Remove=$Username+$domain}
#}

#Check Aliases
#Get-Mailbox $Mailbox | select -ExpandProperty emailaddresses | Select-String -Pattern "smtp"