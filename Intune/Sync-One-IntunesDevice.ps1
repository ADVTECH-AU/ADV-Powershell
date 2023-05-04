#This script will sync a single Intune device.

Param(
    [string]$Hostname
)

Connect-MSGraph 

$DeviceID = Get-IntuneManagedDevice -Filter "StartsWith(DeviceName, '$Hostname') & EndsWith (DeviceName, '$Hostname')" | Select managedDeviceID
Invoke-IntuneManagedDeviceSyncDevice -managedDeviceId $DeviceID.managedDeviceID