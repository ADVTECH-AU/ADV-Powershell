#This script will stop syncing a shared folder in OneDrive.

function Start-LibrarySync {
    param ($ProjectNumber)

    $Context = Get-ClientContextByProjectNumber($ProjectNumber)
    
    $Web = $Context.Web
    $Site = $Context.Site
    $List = $Context.Web.Lists.GetByTitle("Documents")

    $Context.Load($Web)
    $Context.Load($Site)
    $Context.Load($List)
    $Context.ExecuteQuery()
    
    $SiteId = $Context.Site.Id
    $WebId = $Context.Web.Id
    $ListId = $List.Id
    $UserEmail = $Context.Credentials.UserName
    $WebUrl = $Context.Web.Url
    $Webtitle = $ProjectNumber
    $ListTitle = "D"

    Start-Process "odopen://sync/?siteId={$siteid}&webId={$webid}&listId={$listid}&userEmail=$userEmail&webUrl=$webUrl&webTitle=$webtitle&listTitle=$listtitle"
}





function Stop-AllLibrarySync {

    # stop OneDrive
    Start-Process "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe" /shutdown
    Start-Sleep -Milliseconds 500

    # remove sync configuration file
    foreach ($IniFile in (Get-Item "$env:USERPROFILE\AppData\Local\Microsoft\OneDrive\settings\Business1\ClientPolicy_*.ini")) {
        #$IniFileContent = Get-Content -Path $IniFile -Encoding Unicode
        #$ContainsProjectNumber = $IniFileContent | Select-String -Pattern $ProjectNumber
        #if ($null -ne $ContainsProjectNumber) {
        #    Remove-Item $IniFile
        #    break
        #}
        Remove-Item $IniFile
        break
    }

    # remove sync registry value
    $Key = Get-Item HKCU:\Software\Microsoft\OneDrive\Accounts\Business1\ScopeIdToMountPointPathCache
    $keys = @()

    foreach ($Property in $Key.Property) {
        if ($Key.GetValue($Property) -ne "$env:USERPROFILE\OneDrive - ADV Technical Consulting") {
            Write-Output "Matched: "($Key.GetValue($Property))
            #Remove-ItemProperty -Path $Key.PSPath -Name $Property
            $keys += ($Key.GetValue($Property))
        }
    }

    # remove the lines referring to this sync from the ini file
    $f = Get-Item "$env:USERPROFILE\AppData\Local\Microsoft\OneDrive\settings\Business1\????????-????-????-????-????????????*.ini"
    foreach($line in Get-Content $f -Encoding Unicode) {
        if($line -match " = \d+ ([a-f0-9+]+) .*"){
            $SyncId = $Matches[1].Replace("+", "\+")
            break
        }
    }
    Get-Content $f -Encoding Unicode | Where-Object {$_ -notmatch "$SyncId"} | Set-Content ($f.FullName + '2') -Encoding Unicode
    Remove-Item $f
    Rename-Item ($f.FullName + '2') $f.FullName

    # remove the folder
    foreach ($key1 in $keys){
        Write-Output "Matched: "$key1
        #Remove-Item $key1 -Recurse -Force
    }

    # restart OneDrive
    Start-Process "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe" /background
}






$host.Runspace.ThreadOptions = "ReuseThread" 
 
#Definition of the function that allows to enable/disable syncrhonization option in a SharePoint Document Library 
function EnableDisable-SyncSPODocLibrary 
{ 
    param ($sSiteUrl,$sUserName,$sPassword,$sCSOMPath,$sDocLibraryName,$sOperationType) 
    try 
    {  
        #Adding the Client OM Assemblies         
        $sCSOMRuntimePath=$sCSOMPath +  "\Microsoft.SharePoint.Client.Runtime.dll"         
        $sCSOMPath=$sCSOMPath +  "\Microsoft.SharePoint.Client.dll" 
                      
        Add-Type -Path $sCSOMPath          
        Add-Type -Path $sCSOMRuntimePath         
 
        #SPO Client Object Model Context 
        $spoCtx = New-Object Microsoft.SharePoint.Client.ClientContext($sSiteUrl)  
        $spoCredentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($sUserName, $sPassword)   
        $spoCtx.Credentials = $spoCredentials  
   
        $spoList = $spoCtx.Web.Lists.GetByTitle($sDocLibraryName) 
        $spoCtx.Load($spoList) 
        $spoCtx.ExecuteQuery() 
 
        #Operation Type 
        switch ($sOperationType)  
        {  
        "Enable" { 
            Write-Host "Enabling syncrhonization for document library $sDocLibraryName" -ForegroundColor Green 
            $spoList.ExcludeFromOfflineClient=$false 
            } 
        "Disable"{ 
            Write-Host "Disabling syncrhonization for document library $sDocLibraryName" -ForegroundColor Green 
            $spoList.ExcludeFromOfflineClient=$true 
            } 
        default{ 
            Write-Host "Requested operation is not valid" -ForegroundColor Red 
            }            
        }         
        $spoList.Update() 
        $spoCtx.ExecuteQuery() 
        $spoCtx.Dispose() 
    } 
    catch [System.Exception] 
    { 
        Write-Host -ForegroundColor Red $_.Exception.ToString()    
    }     
} 
 
#Required Parameters 
$sSiteUrl = "https://<O365_Domain>.sharepoint.com/sites/<SPOSite>/"  
$sUserName = "<O365User>@<O365_Domain>.onmicrosoft.com"  
$sPassword = Read-Host -Prompt "Enter your password: " -AsSecureString   
#$sPassword= ConvertTo-SecureString "<User_Password>" -AsPlainText -Force 
$sCSOMPath="<CSOM_Path>" 
$sDocLibraryName="<Doc_Library_Name>" 
$sOperationType="Enable" 
EnableDisable-SyncSPODocLibrary -sSiteUrl $sSiteUrl -sUserName $sUserName -sPassword $sPassword -sCSOMPath $sCSOMPath -sDocLibraryName $sDocLibraryName -sOperationType $sOperationType