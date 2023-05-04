#This script will configure OneDrive to sync a Sharepoint Library.

Add-Type -AssemblyName System.Web
$WebURL = [System.Web.HttpUtility]::UrlEncode("https://plop.sharepoint.com")
$SiteID = [System.Web.HttpUtility]::UrlEncode("{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
$WebID = [System.Web.HttpUtility]::UrlEncode("{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}")
$ListID = [System.Web.HttpUtility]::UrlEncode("{xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx}")
$WebTitle = [System.Web.HttpUtility]::UrlEncode("PLOP")
$ListTitle = [System.Web.HttpUtility]::UrlEncode("Folder")
$UserName = [System.Web.HttpUtility]::UrlEncode("me@exemple.com")

Write-Output "Configure OneDrive"
$odopen = "odopen://sync/?onPrem=0&webTemplate=68&libraryType=4&siteId=" + $SiteID + "&webId=" + $WebID + "&webUrl=" + $webURL + "&listId=" + $ListID + "&userEmail=" + $UserName + "&webTitle=" + $WebTitle + "&listTitle=" + $ListTitle

Start-Process $odopen