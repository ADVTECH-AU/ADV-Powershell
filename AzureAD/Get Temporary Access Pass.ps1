# Create a Temporary Access Pass for a user
$User = ""

Install-Module Microsoft.Graph.Identity.SignIns -Force
Connect-MgGraph -Scopes "UserAuthenticationMethod.ReadWrite.All"

$properties = @{}
$properties.isUsableOnce = $True
$properties.startDateTime = Get-Date
$propertiesJSON = $properties | ConvertTo-Json

#Get a user's Temporary Access Pass
$Token = Get-MgUserAuthenticationTemporaryAccessPassMethod -UserId $User

if ($Token -eq $null) {
    #Create Temporary Access Pass
    New-MgUserAuthenticationTemporaryAccessPassMethod -UserId $User -BodyParameter $propertiesJSON
    $Token = Get-MgUserAuthenticationTemporaryAccessPassMethod -UserId $User
}