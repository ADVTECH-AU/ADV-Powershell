#This script will import a site template to a site collection.

$SharepointSiteUrl = ""
$SiteName = "template.xml"
#have to run from ISE
#Got to create site first
$Path = ""

Install-Module PNP.Powershell -Force -AllowClobber

Connect-PNPOnline -Url $SharepointSiteUrl -Interactive
Test-Path -Path $Path+"\"+$SiteName
Invoke-PnPSiteTemplate -Path $Path+"\"+$SiteName -ClearNavigation
#Disconnect-PNPOnline -confirm:$false
