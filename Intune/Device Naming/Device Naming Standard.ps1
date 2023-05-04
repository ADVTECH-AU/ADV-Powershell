#This script will rename a device to the standard naming convention.

###########################
$HostnameInitial = "NKH"
###########################
#Set-ExecutionPolicy Bypass Process
$Hostname = Hostname
$Serial = Get-WmiObject win32_bios | select Serialnumber 
$ComputerName = $HostnameInitial+"-"+$Serial.Serialnumber
if (($Hostname -like $ComputerName) ) 
{
    Write-Host "Does not need Renaming"
}
else 
{
    Rename-Computer $Computername
}
