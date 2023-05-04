#This script will get the groups a user is a member of in Azure AD.

Param(
    [string]$Email
)

Connect-AzureAD 
$GUID1 = Get-AzureADUser -ObjectId $Email | select ObjectID
$GUID = $GUID1.ObjectId

$Groups = Get-AzureADUserMembership -ObjectId $GUID | Select DisplayName

Write-Output $Groups 