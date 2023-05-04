#This script will delete all conditional access policies in Azure AD using App Registration Connection Details.

$ApplicationID = ""
$TenatDomainName = ""
$AccessSecret = ""


$Body = @{    
Grant_Type    = "client_credentials"
Scope         = "https://graph.microsoft.com/.default"
client_Id     = $ApplicationID
Client_Secret = $AccessSecret
} 

$ConnectGraph = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenatDomainName/oauth2/v2.0/token" -Method POST -Body $Body
$token = $ConnectGraph.access_token

$Header = @{Authorization = "Bearer $($token)"}

$policies = invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies" -Method Get -Headers $Header

$PolicyID = ""
#Delete Policies
Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/identity/conditionalAccess/policies/{$PolicyID}" -Method Delete -Headers $Header

