#This script will create a group in AAD that will be used to restrict the creation of Teams. It will then disable the creation of Teams for everyone except the group you created. This is useful if you want to restrict the creation of Teams to a specific group of users.

$Group = 'TeamsCreation'

Uninstall-Module AzureAD -Confirm:$false
Install-Module AzureADPreview -Force

Connect-AzureAD

New-AzureADGroup -DisplayName $Group -Description "Group to restrict Teams creation" -MailEnabled $false -MailNickname $Group -SecurityEnabled $true

Get-AzureADGroup -SearchString $Group

#Disable Group Creation (on which a Team rely)
$Template = Get-AzureADDirectorySettingTemplate | where {$_.DisplayName -eq 'Group.Unified'}
$OldTemplateID = Get-AzureADDirectorySetting | where {$_.DisplayName -eq 'Group.Unified'}
$Setting = $Template.CreateDirectorySetting()

    if ($Template -eq $null) {
        New-AzureADDirectorySetting -DirectorySetting $Setting 
    }
    else {
        Set-AzureADDirectorySetting -DirectorySetting $Setting -Id $OldTemplateID.id
    }

$Setting = Get-AzureADDirectorySetting -Id (Get-AzureADDirectorySetting | where -Property DisplayName -Value "Group.Unified" -EQ).id
$Setting["EnableGroupCreation"] = $False

#Enable your AAD Group to group Creation
$Setting["GroupCreationAllowedGroupId"] = (Get-AzureADGroup -SearchString $Group).objectid
Set-AzureADDirectorySetting -Id (Get-AzureADDirectorySetting | where -Property DisplayName -Value "Group.Unified" -EQ).id -DirectorySetting $Setting

Disconnect-AzureAD