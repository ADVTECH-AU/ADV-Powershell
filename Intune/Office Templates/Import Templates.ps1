#This script will import the Office Templates into the user's OneDrive for Business.

#Run as User
Set-executionpolicy -ExecutionPolicy Bypass -Scope Process -Force
$TemplateUrl = "" #Zip File URL
$Template1 = [uri]::UnescapeDataString($TemplateUrl)
$TemplateFolder = $Template1.Split("/")[-1]
$TemplateFolder1 = $TemplateFolder.substring(0, $TemplateFolder.length - 4)
#Downloading Templates.zip
Invoke-WebRequest -Uri $TemplateUrl -OutFile "$env:USERPROFILE\AppData\Roaming\Microsoft\Templates\Knight Templates.zip"
#Downloading Building Blocks.dotx
Expand-Archive -Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Templates\$TemplateFolder" -DestinationPath "$env:USERPROFILE\AppData\Roaming\Microsoft\Templates" -Force
#Moving Templates to correct folder
Get-ChildItem -Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Templates\$TemplateFolder1" | Move-Item -Destination "$env:USERPROFILE\AppData\Roaming\Microsoft\Templates"
#Removing Templates Folder
Remove-Item -Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Templates\$TemplateFolder1" -Force
#Removing Templates.zip
Remove-Item -Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Templates\$TemplateFolder" -Force