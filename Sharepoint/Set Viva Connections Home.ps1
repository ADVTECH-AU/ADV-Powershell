#This script will set the Viva Connections Home Site to the Sharepoint Homesite or the Viva Connections Dashboard.

#$True = Sharepoint Homesite is Default
#$False = Viva Connections Dashboard is Default
$Homesite = ""
$AdminUrl = ""
Connect-SPOService -Url $AdminUrl

Set-SPOHomeSite -HomeSiteUrl $Homesite -VivaConnectionsDefaultStart $true 

Disconnect-SPOService 
