#This script will create a folder in a SharePoint site.

#Config Variables
$SiteURL = ""
$Subfolder= "/Shared Documents/Measurement"

Connect-PnPOnline -Url $SiteURL -Interactive 

$Folders = @(
    "",
    "",
    ""
    )
 
foreach ($Folder in $Folders) {
    $FolderURL = $SiteURL + $Subfolder 
    Write-Host "Creating Folder: $FolderURL"
    Add-PnPFolder -Name $Folder -Folder $FolderURL 
}

Disconnect-PnPOnline