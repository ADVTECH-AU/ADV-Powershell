#This script will install Adobe Acrobat DC from a UNC path.

$DetectPath = "C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe"

$Arguments = @(
    "/sAll"
    "/re"
    "/msi"
)

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
$Detect_App = Test-Path $DetectPath
    if ($Detect_App -eq $false){
    $username = ""
    $pass = "" | ConvertTo-SecureString -AsPlainText -Force
    $creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $pass
    New-PSDrive -Name Adobe -PSProvider FileSystem -Root "\\nkh-fs\Software\Adobe\Adobe Acrobat\AdobePackage\Adobe Acrobat" -Credential $creds

    Start-Job -Name 'InstallingApp' -Scriptblock {      
    Start-Process "\\nkh-fs\Software\Adobe\Adobe Acrobat\AdobePackage\Adobe Acrobat\setup.exe" -ArgumentList $using:Arguments -Wait -NoNewWindow -PassThru
    Write-Output  "Adobe Installed"
    } | Wait-Job | Receive-Job
}