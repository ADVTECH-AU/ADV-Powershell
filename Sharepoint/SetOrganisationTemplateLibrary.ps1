#Sets the organisation template library to a specified location

$SharepointAdminUrl = ""
$TemplateDirectory = ""

Connect-SPOService -Url $SharepointAdminUrl 

Add-SPOOrgAssetsLibrary -LibraryURL $TemplateDirectory -OrgAssetType OfficeTemplateLibrary -Confirm:$false

Disconnect-SPOService

