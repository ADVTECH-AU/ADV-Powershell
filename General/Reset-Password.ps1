#This script will reset a user's password in Azure AD.

param (
    [string]$Email,
    [string]$Password
)

$AzureCredential = Get-AutomationPSCredential -Name 'Powershell'

Connect-MsolService -Credential $AzureCredential

Set-MsolUserPassword -UserPrincipalName $Email -NewPassword $Password -ForceChangePassword:$true

#Add-Type -AssemblyName 'System.Web'
#$NewPass = [System.Web.Security.Membership]::GeneratePassword(8,0)