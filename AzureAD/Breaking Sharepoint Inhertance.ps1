#What does this script do?
#This script will break the permission inheritance of a list in SharePoint Online.

#Config Variables
$SiteURL = ""
$ListName =""
 
#Get Credentials to connect

 
Try {
    #Connect to PnP Online
    Connect-PnPOnline -Url $SiteURL -Interactive
     
    #Try to Get the List
    $List = Get-PnPList -Identity $ListName
 
    If($List)
    {
        #Break Permission Inheritance of the List
        Set-PnPList -Identity $ListName -BreakRoleInheritance -CopyRoleAssignments
        Write-Host -f Green "Permission Inheritance Broken for List!"
    }
    Else
    {   
        Write-Host -f Yellow "Could not Find List '$ListName'"
    }   
}
catch {
    write-host "Error: $($_.Exception.Message)" -foregroundcolor Red
}
