#This script will create a dynamic distribution group based on the users of a certain domain you specify and then add those users to the DL.

$Domain = ""
$DisplayName = ""
#No Spaces in Alias Name
$AliasName = ""

Connect-ExchangeOnline

#Creates DL
New-DistributionGroup -DisplayName $DisplayName -Name $DisplayName -Alias $AliasName -Confirm:$false

#Gets Users based on Filter
$Users = Get-AzureADUser -top 500 | Where {$_.UserPrincipalName -like "*@$Domain"} 

#Adds users to DL
Foreach ($User in $Users) {
    try {
        Add-DistributionGroupMember -Identity $AliasName -Member $User.UserPrincipalName
        $UPN = $User.UserPrincipalName
        Write-Host "Added $UPN to $DisplayName" -ForegroundColor Green
    }
    catch {
        $UPN = $User.UserPrincipalName
        Write-Host "Failed to add $UPN to $DisplayName" -ForegroundColor Red
    }
}

Disconnect-ExchangeOnline -Confirm:$false
