#This script exports the default apps from a Windows 10 device. This is useful if you want to import the default apps into a Windows 10 image.

Start-Job -Name 'temp' -ScriptBlock {
    $testpath = Test-Path C:\temp 
    if ($testpath -eq $false) {
        New-Item -Path 'C:\temp' -ItemType Directory
    }else {
        Write-Output "File Already Exists"
    } 
} | Wait-Job


Dism /Online /Export-DefaultAppAssociations:"C:\temp\defaultappsexport.xml" 