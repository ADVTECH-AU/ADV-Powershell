#This script will restore a disabled user in Azure AD and remove the immutable ID.
param (
    [Parameter(Mandatory=$true)]
    [string]$UPN
)
$AzureCredential = Get-AutomationPSCredential -Name 'Powershell'

Connect-MsolService -Credential $AzureCredential

Restore-MsolUser -UserPrincipalName $UPN 
Set-MsolUser -UserPrincipalName $UPN -ImmutableId "$null"