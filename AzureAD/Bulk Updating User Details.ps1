#This script will update the mobile number and job title of users in Azure AD based on a CSV file.

$Data = import-csv 'C:\temp\######.csv'

$Mobile = ""
Connect-AzureAD

Foreach ($user1 in $Data) {
    Get-AzureADUser -SearchString $user1.DisplayName | Set-AzureADUser -Mobile $user1.Mobile -ErrorAction Continue
    Get-AzureADUser -SearchString $user1.DisplayName | Set-AzureADUser  -JobTitle $user1.Title -ErrorAction Continue
}

Get-AzureADUser -all $true | Select Name, DisplayName, Mobile, JobTitle 

Disconnect-AzureAD -Confirm:$false