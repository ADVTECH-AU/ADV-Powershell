#This script will copy a field from AD to an extension attribute in AD.

#Script must be run on domain joined device.
#Check for AD Module and if not present install
if ((Get-Module ActiveDirectory) -eq $false) {Install-WindowsFeature RSAT-AD-PowerShell}
#If RSAT Not available. 
#Add-WindowsCapability –online –Name “Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0”

#Set Scope. do * for all or type in an AD loginname of a user to run on 1 user
$Scope = ""
$fieldtocopy = "Description"

if ($Scope -eq "*") {
    $users = Get-AdUser -Filter $Scope -properties * 
} else {
    $users = Get-AdUser $Scope -properties *
}

#Copies POBox field to ExtensionAttribute1 Field
Foreach ($User in $users) {
    $DisplayName = $User.DisplayName
    $field = Get-ADuser -Filter "Name -like '$DisplayName'" -Properties * | Select-Object -ExpandProperty $fieldtocopy
    Set-ADuser -Identity $User.DistinguishedName -replace @{ExtensionAttribute5=$field} -Verbose -ErrorAction SilentlyContinue
}
