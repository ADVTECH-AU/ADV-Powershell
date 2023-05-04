#This script will copy the mailbox delegation from one tenant to another. It will copy the main mailbox permissions and the send as permissions. It will also create a new folder in 

Start-Job -Name 'temp' -ScriptBlock {
    $testpath = Test-Path C:\temp 
    if ($testpath -eq $false) {
        New-Item -Path 'C:\temp' -ItemType Directory
    }else {
        Write-Output "File Already Exists"
    } 
} | Wait-Job

#Connect to old Tenant Modify User List to work from
Connect-ExchangeOnline
Start-Job -Name "Gathering Permissions" -ScriptBlock {
    $Users = Import-csv -Path "C:\temp\Mailbox Permissions.csv"
    ForEach ($user in $Users) {
       Get-MailboxPermission -Identity $user.'Old Tenant Username' | where {$_.user.tostring() -ne "NT AUTHORITY\SELF" -and $_.IsInherited -eq $false} | Select Identity,User,AccessRights| export-csv C:\temp\ExportMainAccess.csv -Append
       Get-RecipientPermission -Identity $user.'Old Tenant Username' | where {$_.trustee.tostring() -ne "NT AUTHORITY\SELF"} | Select Identity,Trustee,AccessRights| export-csv C:\temp\ExportSendAsAccess.csv -Append
    } 
} | Wait-Job

Disconnect-ExchangeOnline -Confirm:$false
#Part 2 - Replicating from CSV Export Connect to new Tenant
#Connect to new Tenant
Connect-ExchangeOnline

#Use -Whatif Param for testing Remove when ready to run for real.

Start-Job -Name "Updating Permissions" -ScriptBlock {
    #$Data = Import-Csv -Path C:\temp\ExportMainAccess.csv
    #$Data1 = Import-Csv -Path C:\temp\ExportSendAsAccess.csv
    ForEach ($Item in $Users) {
        #$user = $(@{Add=($Item.User.split("@")[0])+"@knightaus.onmicrosoft.com"}.Values)  Use this to apply to another domain
        Add-MailboxPermission -Identity $Item.Identity -AccessRights FullAccess -User $Item.User 
    }
    ForEach ($Item1 in $Users) {
        #$user = $(@{Add=($Trustee.User.split("@")[0])+"@knightaus.onmicrosoft.com"}.Values)
        Add-RecipientPermission -Identity $Item1.Identity -AccessRights SendAs -Trustee $Item1.User -Confirm:$false
    } 
} | Wait-Job 

Disconnect-ExchangeOnline -Confirm:$false 