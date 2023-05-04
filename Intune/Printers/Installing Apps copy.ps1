$Url = "https://download.brother.com/welcome/dlf006645/BrotherPrinterDriver.msi"
$AppName1 = $Url.Split("/")[-1]
$AppName = "BrotherPrinterDriver.msi"
$DetectPath = "C:\tes2312312.txt"
$FilePath = "C:\Drivers\BrotherPrinter\$AppName"

$Arguments = @(
    "/i .\BrotherPrinterDriver.msi"
    "/q"
    'DRIVERNAME="Brother MFC-L2710DW series"'
    'PRINTERNAME=""'
    'IPADDRESS=""'
    'ISDEFAULTPRINTER="1"'
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
        
        Start-Job -Name 'InstallingApp' -Scriptblock {      
            #Expand-Archive -Path 'C:\temp\'$AppName -DestinationPath 'C:\temp' -Force 
            #Start-Sleep -Seconds 5
            Start-Process -FilePath $using:FilePath -ArgumentList $using:Arguments -Wait 
            Write-Output  $using:AppName" Installed"
            } | Wait-Job | Receive-Job
    }

    Start-Process msiexec.exe -ArgumentList "/i .\BrotherPrinterDriver.msi", "/q" DRIVERNAME="Brother MFC-L2710DW series", PRINTERNAME="Warehouse Computer", IPADDRESS="192.168.1.124"