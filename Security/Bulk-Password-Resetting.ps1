#Reset all user passwords to either preset or random.
param (
    [(Mandatory)]
    [string]$Password
)
switch ($PresetPassword) {
    $true {
        $Password1 = $Password
   }
    $false {
        $Password1 = [System.Web.Security.Membership]::GeneratePassword(12,1)
    }
} Write-Output "Password is $Password1"


if ($PresetPassword -eq $false) {
    $Password1 = $Password
} else {
    $Password1 = [System.Web.Security.Membership]::GeneratePassword(12,1)
}

#Connect-MsolService 

$Users = Get-MsolUser
Foreach ($User in $Users) {
    Set-MsolUserPassword -UserPrincipalName $User.UserPrincipalName -NewPassword $Password1 -ForceChangePassword:$true -Verbose
    Write-Host $Password1
}

#Add-Type -AssemblyName 'System.Web'
#$NewPass = [System.Web.Security.Membership]::GeneratePassword(12,2)