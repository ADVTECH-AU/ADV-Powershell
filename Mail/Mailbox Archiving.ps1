#This script will enable the Archive Mailbox for the specified user.

#Test for Achive Mailbox
$Mailbox = 'sales@filterdiscounters.com.au'
#Get-EXOMailbox Mailbox -Archive

#Enabled Archive Mailbox
#Enable-Mailbox $Mailbox -Archive

#Start Managed Folder Assitant Migration
Start-ManagedFolderAssistant -Identity $Mailbox



