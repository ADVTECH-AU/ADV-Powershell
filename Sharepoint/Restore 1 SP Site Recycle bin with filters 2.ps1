# =================================================================== #
#         Load SharePoint PnP PowerShell Module
# =================================================================== #
#Save-module  SharePointPnPPowerShellOnline -literalPath "C:\Sharepoint"
#Import-Module (Get-ChildItem -Recurse -Filter "*.psd1").FullName -ErrorAction Continue

$SiteURL = ""
Connect-PnPOnline -Url $SiteURL -UseWebLogin -TenantAdminUrl ""

$ErrorActionPreference = 'SilentlyContinue'

# =================================================================== #
#            RESTORE RECYCE BIN IN BATCHES USING REST API
# =================================================================== #
$firstLevelItems = @(Get-PnPRecycleBinItem  -FirstStage -RowLimit 99999999 )
$secondLevelItems = @(Get-PnPRecycleBinItem  -SecondStage -RowLimit 99999999 )

Write-Host First Stage Recycle Bin Items: $firstLevelItems.Count -ForegroundColor Cyan
Write-Host Second Stage Recycle Bin Items: $secondLevelItems.Count -ForegroundColor Yellow

$restoreSet = $firstLevelItems + $secondLevelItems
Write-Host Both Stages Recycle Bin Items: $restoreSet.Count -ForegroundColor Cyan

$restoreFileSorted = $restoreSet | ?{$_.ItemType -eq "File"} | sort DirName, LeafName
Write-Host Both Stages Recycle Bin, Documents count: $restoreSet.Count -ForegroundColor Yellow
$ErrorActionPreference = "Stop"

function Restore-RecycleBinItem {
    param(
        [Parameter(Mandatory)]
        [String]
        $Ids
    )
    
    $siteUrl = (Get-PnPSite).Url
    $apiCall = $siteUrl + "/_api/site/RecycleBin/RestoreByIds"
    $body = "{""ids"":[$($Ids)]}"   
    Invoke-PnPSPRestMethod -Method Post -Url $apiCall -Content $body -ErrorAction Continue

}

$stopWatch = [system.diagnostics.stopwatch]::StartNew()

# Batch restore up to 200 at a time
$restoreList = $restoreFileSorted | select Id, ItemType, LeafName, DirName

$restoreListCount = $restoreList.count
$start = 0
$leftToProcess = $restoreListCount - $start


$stopWatch = [system.diagnostics.stopwatch]::StartNew()
while($leftToProcess -gt 0){
    If($leftToProcess -lt 200){$numToProcess = $leftToProcess} Else {$numToProcess = 200}
    Write-Host -ForegroundColor Yellow "Building statement to restore the following $numToProcess files"
    $Ids = @()
    for($i=0; $i -lt $numToProcess; $i++){
        $cur = $start + $i
        $curItem = $restoreList[$cur]
        
        $Ids+=$curItem.Id
    }
   
    Write-Host -ForegroundColor Yellow "Performing API Call to Restore items from RecycleBin..."
    $Ids_As_string = [System.String]::Join(",", $($Ids | % {'"'+ $_.tostring() + '"'}))
    Clear-RecycleBinItem -Ids $Ids_As_string
    
    
    $start += 200
    $leftToProcess = $restoreListCount - $start
}

$stopWatch.Stop()
Write-Host Time it took to restore $restoreListCount documents from the $($SiteURL+$DestinationFolderUrl)  -ForegroundColor Cyan
$stopWatch
 