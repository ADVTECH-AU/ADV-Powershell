#This script will set the DenyAddPages to false for a site collection.

$adminurl = ""
$SiteUrl = ""

Connect-SPOService $adminurl

Set-SPOSite $SiteUrl -DenyAddAndCustomizePages $false 