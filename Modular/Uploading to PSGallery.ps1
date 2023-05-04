#This script will upload a script to the PowerShell Gallery.
<#PSScriptInfo#> 
  
>  <#  
>  .SYNOPSIS  
>  .DESCRIPTION  
>  .PARAMETER  
>  .EXAMPLE  
>  .LINK  
>  .NOTES  
>  .COMPONENT  
>  .ROLE  
>  .FUNCTIONALITY  
>  .FORWARDHELPTARGETNAME  
>  .FORWARDHELPCATEGORY  
>  .EXTERNALHELP  
>  #>  

New-PSScriptFileInfo -Path '.\Toast Notification Test.ps1' -Description 'Fun Toast Notification' -Version '1.0' -Author 'John Doe' -CompanyName '' -Copyright '' -CopyrightUrl 'http://www.contoso.com' -ProjectUrl 'http://www.contoso.com' -LicenseUrl 'http://www.contoso.com' -IconUrl 'http://www.contoso.com' -Tags 'Test','Contoso' -ReleaseNotes 'First Release' -Dependencies 'Module1','Module2' -PrivateData 'This is private data' -Verbose -force | Get-Content '.\Toast Notification Test.ps1'

Publish-Script -Path '.\Toast Notification Test.ps1' -Force -NuGetApiKey "" 
