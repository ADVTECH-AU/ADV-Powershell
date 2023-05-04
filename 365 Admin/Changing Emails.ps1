#This script will change the UPN of a user in Office 365 and add the old UPN as an alias.
#For Bulk Changes

Set-ExecutionPolicy Bypass Process

Connect-MsolService

$Users = @(
    "#CURRENT USER EMAIL"
)

Connect-ExchangeOnline

foreach ($User in $Users) {
    $UPN1 = Get-Mailbox -Identity $User | Select UserPrincipalName 
    $UPN = $UPN1.UserPrincipalName
    $Firstname1 = Get-MsolUser -UserPrincipalName $User | Select FirstName
    $Firstname = $Firstname1.FirstName
    $Lastname1 = Get-MsolUser -UserPrincipalName $User | Select LastName
    $LastName = $Lastname1.LastName
    $NewUPN = "$Firstname.$Lastname@barclayeng.com.au"
    Write-Host "User $Firstname $Lastname's UPN is $UPN"

    try {
        Set-MsolUserPrincipalName -UserPrincipalName $UPN -NewUserPrincipalName $NewUPN
        Write-Host "User $Firstname $Lastname's UPN has been changed from $UPN to $NewUPN" -ForegroundColor Green
    }
    catch {
        Write-Error "User $Firstname $Lastname's UPN has not been changed as there was an error."
    }
    try {
        Set-Mailbox -Identity $UPN -EmailAddresses @{add=$UPN}
        Write-Host "User $Firstname $Lastname's Old UPN was added as Alias" -ForegroundColor Yellow
    }
    catch {
        Write-Error "User $Firstname $Lastname's UPN has not been changed as there was an error."
    }
}

Get-Mailbox | Select UserPrincipalName, EmailAddresses