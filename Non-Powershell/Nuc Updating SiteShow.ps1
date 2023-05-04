#This script will download the SiteShow HTML file from the server and save it to the C:\temp directory.

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

Start-Job -Name 'temp' -ScriptBlock {
    $testpath = Test-Path C:\temp 
    if ($testpath -eq $false) {
        New-Item -Path 'C:\temp' -ItemType Directory
    }else {
        Write-Output "File Already Exists"
    } 
} | Wait-Job

Start-Job -Name "DownloadingSiteShow" -Verbose -ScriptBlock {
      Invoke-WebRequest -Uri '###########' -OutFile 'C:\temp\SiteShow.html' -UseBasicParsing
} | Wait-Job

