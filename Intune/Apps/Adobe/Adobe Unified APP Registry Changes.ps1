#This script will create the registry entries required to disable the Adobe Acrobat DC updater.

Set-ExecutionPolicy Bypass Process -Force

#Adding bIsSCReducedModeEnforcedEx
$Path = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockdown"
$Name = "bIsSCReducedModeEnforcedEx"
$Type = "DWORD"
$Value = 1

#Adding bUpdater
$Path1 = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockdown\cServices"
$Name1 = "bUpdater"

#Check for bIsSCReducedModeEnforced and remove if exists
if ((Get-ItemProperty -Path $Path -Name "bIsSCReducedModeEnforced" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty "bIsSCReducedModeEnforced") -eq $true) {Remove-ItemProperty -Path $Path -Name "bIsSCReducedModeEnforced" -Force}

#Create Path Required
if ((Test-Path "HKLM:\SOFTWARE\Policies") -eq $False) {New-Item -Path "HKLM:\SOFTWARE\" -Name "Policies" -Force}
if ((Test-Path "HKLM:\SOFTWARE\Policies\Adobe") -eq $False) {New-Item -Path "HKLM:\SOFTWARE\Policies\" -Name "Adobe" -Force}
if ((Test-Path "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat") -eq $False) {New-Item -Path "HKLM:\SOFTWARE\Policies\Adobe\" -Name "Adobe Acrobat" -Force}
if ((Test-Path "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC") -eq $False) {New-Item -Path "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\" -Name "DC" -Force}
if ((Test-Path "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockdown") -eq $False) {New-Item -Path "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\" -Name "FeatureLockdown" -Force}
if ((Test-Path "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockdown\cServices") -eq $False) {New-Item -Path "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockdown\" -Name "cServices" -Force}


    $Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $Name
    If ($Registry -eq $true){
        Write-Output "bIsSCReducedModeEnforcedEx Already Exists"
    } else {
        Write-Output "Adding bIsSCReducedModeEnforcedEx"
        New-ItemProperty -Path $Path -Name $Name -PropertyType $Type -Value $Value -Force
    }

    $Registry1 = Get-ItemProperty -Path $Path1 -Name $Name1 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $Name1
    If ($Registry1 -eq $true){
        Write-Output "bUpdater Already Exists"
    } else {
        Write-Output "Adding bUpdater"
        New-ItemProperty -Path $Path1 -Name $Name1 -PropertyType $Type -Value $Value -Force
    }
