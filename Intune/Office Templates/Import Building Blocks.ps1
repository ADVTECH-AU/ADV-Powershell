#This script will import the Building Blocks into the Office Templates folder.
#Run as System
Set-ExecutionPolicy Bypass Process -Force
$BuildingBlockUrl = ""

Invoke-WebRequest -Uri $BuildingBlockUrl -OutFile "C:\Program Files\Microsoft Office\root\Office16\Document Parts\1033\16\Built-In Building Blocks.dotx"
