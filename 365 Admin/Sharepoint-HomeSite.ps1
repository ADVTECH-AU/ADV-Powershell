#Sets Sharepoint Homesite

Install-Module "Microsoft.Sharepoint.Powershell"

$homeSiteURL = ""

Connect-SPOService
Set-SPOHomeSite -HomeSiteUrl $homeSiteURL
Disconnect-SPOService -Confirm:$False