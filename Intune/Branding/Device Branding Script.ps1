#This script will set the lock screen and desktop background images on a Windows 10 device.

########################################
#Only section to Edit add accessible urls for Background & Screensaver images 1920x1080 .png & .jpg supported
$ScreenSaver = ""
$Background = ""
########################################

#Create Branding Folder to Store in
If ((Test-Path -Path C:\Branding) -eq $false)
{
	New-Item -Path C:\Branding -ItemType directory
}

#Get file name from url
$LockScreenImageValue = "C:\Branding\"+$ScreenSaver.Substring($Screensaver.LastIndexOf("/")+1)
$DesktopImageValue = "C:\Branding\"+$Background.Substring($Background.LastIndexOf("/")+1)

#Downloads Images
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($ScreenSaver, $LockScreenImageValue)
$wc1 = New-Object System.Net.WebClient
$wc1.DownloadFile($Background, $DesktopImageValue)

#Checks if Registry Path exists
$RegKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
if (!(Test-Path $RegKeyPath))
{
	Write-Host "Creating registry path $($RegKeyPath)."
	New-Item -Path $RegKeyPath -Force | Out-Null
}

#Adds to Registry
New-ItemProperty -Path $RegKeyPath -Name LockScreenStatus -Value 1 -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name LockScreenPath -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name LockScreenUrl -Value $LockScreenImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name DesktopStatus -Value 1 -PropertyType DWORD -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name DesktopPath -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null
New-ItemProperty -Path $RegKeyPath -Name DesktopUrl -Value $DesktopImageValue -PropertyType STRING -Force | Out-Null

RUNDLL32.EXE USER32.DLL, UpdatePerUserSystemParameters 1, True
