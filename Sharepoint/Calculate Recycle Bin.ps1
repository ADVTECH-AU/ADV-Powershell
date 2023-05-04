#This script will calculate the size of the recycle bin.

#Config Variables
$SiteURL = ""
 
#Connect to PnP Online
Connect-PnPOnline -Url $SiteURL -Interactive
 
#Sum Recycle bin Items Size
$RecycleBinSize = Get-PnPRecycleBinItem -RowLimit 500 | Measure-Object -Property Size -Sum
 
#Get Recycle bin size
Write-host "Recycle Bin Size (MB):" ([Math]::Round($RecycleBinSize.Sum/1MB,2))