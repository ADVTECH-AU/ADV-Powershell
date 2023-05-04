#This Script Creates multiple sharepoint groups for RW and RO Permissions on Sharepoint Libraries

Connect-ExchangeOnline

$FolderList = @(
    "#GroupName#",
    "#GroupName#",
    "#GroupName#",
    "#GroupName#",
    "#GroupName#",
    "#GroupName#"
)
Foreach ($Folder in $FolderList){
    $NewROGroup = New-UnifiedGroup -displayName "SP-$($Folder)-RO" 
    Write-Host "Creating SharePoint Group: SP-$($Folder)-RO" -ForegroundColor Green
    $NewRWGroup = New-UnifiedGroup -displayName "SP-$($Folder)-RW" 
    Write-Host "Creating SharePoint Group: SP-$($Folder)-RW" -ForegroundColor Blue
}

Disconnect-ExchangeOnline -Confirm:$false