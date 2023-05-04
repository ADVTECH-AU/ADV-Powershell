#This script will restore items in the recycle bin that meet a certain criteria.

#Parameter
$SiteURL= ""
$DirPath = ""
$DeletedByUserEmail = ""
$recycleBin = Get-PnPRecycleBinItem
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL
#Restore items that don't exist only
$recycleBin | ForEach-Object {
    $dir = $_.DirName
    $title = $_.Title
    $path = "$dir/$title"

 

    $fileExists = Get-PnPFile -url $path -ErrorAction SilentlyContinue

 

    if ($fileExists) {
        Write-Host "$title exists"
    } else {
        Write-Host "$title Restoring"
        $_ | Restore-PnpRecycleBinItem -Force
    }
}