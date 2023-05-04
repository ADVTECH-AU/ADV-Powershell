#This script will export a site from Sharepoint Online to a local directory.

$SharepointSiteUrl = ""
$SiteName = ""

#Works in ISE ONLY!

#Install-Module PNP.Powershell -Force

Connect-PNPOnline -Url $SharepointSiteUrl -Interactive

If ((Test-Path -Path "C:\Users\$env:OneDrive\Sharepoint\$SiteName") -eq $false)
{
	New-Item -Path "C:\Users\$env:OneDrive\Sharepoint\$SiteName" -ItemType directory
}
Get-PnPSiteTemplate -Out "C:\Users\$env:OneDrive\Sharepoint\$SiteName\$SiteName.xml"

Disconnect-PNPOnline -confirm:$false