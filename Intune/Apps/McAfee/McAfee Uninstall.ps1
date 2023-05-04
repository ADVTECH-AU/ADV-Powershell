#This script will uninstall McAfee from a device.

$DetectPath = "C:\Program Files (x86)\WatchGuard\WatchGuard Mobile VPN with SSL"
$FilePath = ".\MCPR.exe"

$Arguments = "-p StopServices,MFSY,PEF,MXD,CSP,Sustainability,MOCP,MFP,APPSTATS,Auth,EMproxy,FWdiver,HW,MAS,MAT,MBK,MCPR,McProxy,McSvcHost,VUL,MHN,MNA,MOBK,MPFP,MPFPCU,MPS,SHRED,MPSCU,MQC,MQCCU,MSAD,MSHR,MSK,MSKCU,MWL,NMC,RedirSvc,VS,REMEDIATION,MSC,YAP,TRUEKEY,LAM,PCB,Symlink,SafeConnect,MGS,WMIRemover,RESIDUE -v -s"

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
            Write-Output  $using:AppName"Installed"
            } | Wait-Job | Receive-Job
    }