#This script will disable the lockscreen motion on a device.

New-item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -ItemType Directory -Name "Personalization"
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "AnimateLockScreenBackground" -Value "00000001" -PropertyType DWORD -Force | Out-Null