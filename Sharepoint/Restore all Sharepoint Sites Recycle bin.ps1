#This script will restore all items in the recycle bin for all Sharepoint sites.

$today = (Get-Date) 
$dateFrom = $today.date.addDays(-3)
$dateTo = $today.date



Connect-SPOService -Url "" 
$Sites = Get-SPOSite

foreach ($Site in $Sites) {
    Connect-PnPOnline -Url $Site.Url -Credentials $Creds
    $DeletedItems = (Get-PnPRecycleBinItem -ErrorAction Continue | ? {$_.DeletedDate -gt $dateFrom -and $_.DeletedDate -lt $dateTo}).Count
    $SiteUrl = $Site.Url
    $Output = "$SiteUrl Has $DeletedItems Many Items in Recycle Bin"
    $Output2 = "Restoring $DeletedItems to $SiteUrl"
    Write-Output $Output
    Get-PnPRecycleBinItem | ? {$_.DeletedDate -gt $dateFrom -and $_.DeletedDate -lt $dateTo} | Restore-PnPRecycleBinItem -Force -ErrorAction Continue
    Disconnect-PnPOnline
}
