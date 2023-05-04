#This script will install Adobe Acrobat DC on a device.

$Url = ""
$AppName = $Url.Split("/")[-1]
$DetectPath = "C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe"
$FilePath = "C:\temp\$AppName"

$Arguments1 = 'TRANSFORMS="C:\temp\AdobeAcrobat\*.mst" PATCH="C:\temp\Adobe Acrobat\*.msp" /sAll'
$Arguments = @(
    "/sAll"
    "/re"
    "/msi"
)

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

Start-Job -Name 'temp' -ScriptBlock {
    $testpath = Test-Path C:\temp 
    if ($testpath -eq $false) {
        New-Item -Path 'C:\temp' -ItemType Directory
    }else {
        Write-Output "File Already Exists"
    } 
}  | Wait-Job | Receive-Job

$Detect_App = Test-Path $DetectPath
    if ($Detect_App -eq $false){
        Start-Job -Name "DownloadingApp" -ScriptBlock {
            Invoke-WebRequest -Uri $using:Url -OutFile $using:FilePath
        } | Wait-Job | Receive-Job
        
        Start-Job -Name "ExtractingApp" -ScriptBlock {
            Expand-Archive -Path 'C:\temp\'$using:AppName -DestinationPath 'C:\temp' -Force 
        } | Wait-Job | Receive-Job

        Start-Job -Name 'InstallingApp' -Scriptblock {      
            Start-Process "C:\temp\Adobe Acrobat\setup.exe" -ArgumentList $using:Arguments -Wait -NoNewWindow -PassThru
            Write-Output  $using:AppName" Installed"
            } | Wait-Job | Receive-Job
    }