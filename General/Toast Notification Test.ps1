Set-ExecutionPolicy Bypass Process -Force
if ((Get-Module BurntToast) -eq $false) {Install-Module -Name BurntToast -AllowClobber -Force }
New-BurntToastNotification -AppLogo '#############' -Text "Gotchu"
#if (Get-InstalledModule | Where-Object {$_.Name -eq "BurntToast"}) {} else {Install-Module -Name BurntToast -AllowClobber -Force -Verbose}