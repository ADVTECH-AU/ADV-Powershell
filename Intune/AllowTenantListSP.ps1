#This script adds the SharePoint Online Tenant ID to the AllowTenantList registry key for OneDrive for Business. This is required for the OneDrive for Business client to sync with SharePoint Online.

$Path = "HKLM:\SOFTWARE\Policies\Microsoft\Onedrive\AllowTenantList"
$Name = "AllowTenantList"
$Type = "String"
$Value = #"TenantID"

function Test-RegistryValue {

    param (
    
     [parameter(Mandatory=$true)]
     [ValidateNotNullOrEmpty()]$Path,
    
    [parameter(Mandatory=$true)]
     [ValidateNotNullOrEmpty()]$Value
    )
    
    try {
    
    Get-ItemProperty -Path $Path -Name $Value -ErrorAction Stop | Out-Null
    return $true
    }
    
    catch {
    
    return $false
    
    }
    
    }
    

if ((Test-Path $Path) -eq $False) {New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Onedrive\" -Name "AllowTenantList" -Force}

if ((Test-RegistryValue -Path $Path -Value $Name) -eq $False) {New-ItemProperty -Path $Path -Name $Name -PropertyType $Type -Value $Value -Force}