#Connect-AzureAD

$GroupGUID = ""
#Load user list from txt file
$UserList = Get-Content -Path "C:\temp\UserList.txt"
#List of User Emails going vertical no separator.

#Add each user in $userlist to aadgroup find guid
foreach ($User in $UserList)
{
    $UserObject = Get-AzureADUser -SearchString $User 
    $UserObject.ObjectId | Add-AzureADGroupMember -ObjectId $GroupGUID
    Write-Host "Added $User to group" -ForegroundColor Green
}

