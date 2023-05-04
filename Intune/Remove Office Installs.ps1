#Removes Non-English Versions of office often installed on base image of devices.
$OfficeInstalls = ((Get-ItemProperty "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*")  + (Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*") | Where {($_.DisplayName -like "*Microsoft 365*") -and ($_.DisplayName -notlike "*en-us*")})
$OfficeInstalls
    ForEach ($Install in $OfficeInstalls) {
        Write-Host "Found Office Version" $Installs.DisplayName -ForegroundColor Green
        $UninstallEXE = ($Install.UninstallString -split '"')[1]
        $UninstallArg = ($Install.UninstallString -split '"')[2] + " DisplayLevel=False"
        Start-Process -FilePath $UninstallEXE -ArgumentList $UninstallArg -Wait
    }