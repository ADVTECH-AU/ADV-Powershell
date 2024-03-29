<#
.SYNOPSIS
 
A script used to create a Log Analytics workspace with enabled solutions in a management subscription.
 
.DESCRIPTION
 
A script used to create a Log Analytics workspace with enabled solutions in a management subscription.
The script will do all of the following:
 
Check if the PowerShell window is running as Administrator (when not running from Cloud Shell), otherwise the Azure PowerShell script will be exited.
Suppress breaking change warning messages.
Install Azure PowerShell module Az.MonitoringSolutions.
Register required resource provider (Microsoft.HybridCompute) if not already registered. Registration may take up to 10 minutes.
Change the current context to use a management subscription (a subscription with *management* in the subscription name will be automatically selected).
Store a specified set of tags in a hash table.
Create a resource group for Log Analytics if it does not exist. Add specified tags and lock with a CanNotDelete lock.
Create the Log Analytics workspace if it does not exist and add the specified tags.
Save the Log Analytics workspace in a variable.
Save the list of solutions to enable in a variable. 
Add the required solutions to the Log Analytics workspace.
Set the log and metrics settings for the Log Analytics workspace, if they don't exist.
 
.NOTES
 
Filename:       Create-Log-Analytics-workspace-management-subscription.ps1
Created:        14/10/2021
Last modified:  04/10/2022
Author:         Wim Matthyssen
Version:        2.2
PowerShell:     Azure PowerShell and Azure Cloud Shell
Requires:       PowerShell Az (v5.9.0)
Action:         Change variables were needed to fit your needs.
Disclaimer:     This script is provided "As Is" with no warranties.
 
.EXAMPLE
 
Connect-AzAccount
Get-AzTenant (if not using the default tenant)
Set-AzContext -tenantID "ad80fd62-60ab-481e-aa67-0c139a86e743" (if not using the default tenant)
.\Create-Log-Analytics-workspace-management-subscription.ps1
 
.LINK
 
https://wmatthyssen.com/2022/08/01/azure-powershell-script-create-a-log-analytics-workspace-in-your-management-subscription/
#>
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Variables
 
$spoke = "hub"
$abbraviationManagement = "management"
$region = "australiasoutheast"
$SubscriptionID = "6a33e49d-5a22-40de-940c-097b88b8bb09"
 
$rgNameLogAnalyticsWorkspace = "RG-AADLogs"
$LogAnalyticsWorkspaceName = "AAD-LogAnalytics"
$logAnalyticsWorkspaceSku = "pergb2018"
$logAnalyticsDiagnosticsName = "AADDiagnostics"
 
$tagSpokeName = "Env"
$tagSpokeValue = "$($spoke[0].ToString().ToUpper())$($spoke.SubString(1))"
$tagCostCenterName  = ""
$tagCostCenterValue = ""
$tagCriticalityName = ""
$tagCriticalityValue = ""
$tagPurposeName  = ""
$tagPurposeValue = "$($abbraviationManagement[0].ToString().ToUpper())$($abbraviationManagement.SubString(1))"
 
$global:currenttime= Set-PSBreakpoint -Variable currenttime -Mode Read -Action {$global:currenttime= Get-Date -UFormat "%A %m/%d/%Y %R"}
$foregroundColor1 = "Red"
$foregroundColor2 = "Yellow"
$writeEmptyLine = "`n"
$writeSeperatorSpaces = " - "
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Check if PowerShell runs as Administrator (when not running from Cloud Shell), otherwise exit the script
 
if ($PSVersionTable.Platform -eq "Unix") {
    Write-Host ($writeEmptyLine + "# Running in Cloud Shell" + $writeSeperatorSpaces + $currentTime)`
    -foregroundcolor $foregroundColor1 $writeEmptyLine
     
    ## Start script execution    
    Write-Host ($writeEmptyLine + "# Script started. Without any errors, it will need around 1 minute to complete" + $writeSeperatorSpaces + $currentTime)`
    -foregroundcolor $foregroundColor1 $writeEmptyLine
} else {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdministrator = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
 
        ## Check if running as Administrator, otherwise exit the script
        if ($isAdministrator -eq $false) {
        Write-Host ($writeEmptyLine + "# Please run PowerShell as Administrator" + $writeSeperatorSpaces + $currentTime)`
        -foregroundcolor $foregroundColor1 $writeEmptyLine
        Start-Sleep -s 3
        exit
        }
        else {
 
        ## If running as Administrator, start script execution    
        Write-Host ($writeEmptyLine + "# Script started. Without any errors, it will need around 1 minute to complete" + $writeSeperatorSpaces + $currentTime)`
        -foregroundcolor $foregroundColor1 $writeEmptyLine
        }
}
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Suppress breaking change warning messages
 
Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Install module Az.MonitoringSolutions
 
Install-Module Az.MonitoringSolutions -Force
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Register required resource provider if not already registered. Registration may take up to 10 minutes
 
# Register Microsoft.HybridCompute resource provider
Register-AzResourceProvider -ProviderNamespace Microsoft.OperationsManagement  | Out-Null
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Change the current context to use a management subscription
 
#$subNameManagement = Get-AzSubscription #| Where-Object {$_.Name -like "*management*"}
 
Set-AzContext -SubscriptionId $SubscriptionID | Out-Null
 
Write-Host ($writeEmptyLine + "# Management subscription in current tenant selected" + $writeSeperatorSpaces + $currentTime)`
-foregroundcolor $foregroundColor2 $writeEmptyLine
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Store the specified set of tags in a hash table
 
#$tags = @{$tagSpokeName=$tagSpokeValue;$tagCostCenterName=$tagCostCenterValue;$tagCriticalityName=$tagCriticalityValue}
 
#Write-Host ($writeEmptyLine + "# Specified set of tags available to add" + $writeSeperatorSpaces + $currentTime) -foregroundcolor $foregroundColor2 $writeEmptyLine
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Create a resource group for Log Analytics if it does not exist. Add specified tags and lock with a CanNotDelete lock
 
try {
    Get-AzResourceGroup -Name $rgNameLogAnalyticsWorkspace -ErrorAction Stop | Out-Null
} catch {
    New-AzResourceGroup -Name $rgNameLogAnalyticsWorkspace -Location $region -Force | Out-Null
}
 
# Set tags Log Analytics resource group
#Set-AzResourceGroup -Name $rgNameLogAnalyticsWorkspace -Tag $tags | Out-Null
 
# Add purpose tag to the Log Analytics resource group
#$storeTags = (Get-AzResourceGroup -Name $rgNameLogAnalyticsWorkspace).Tags
#$storeTags += @{$tagPurposeName = $tagPurposeValue}
#Set-AzResourceGroup -Name $rgNameLogAnalyticsWorkspace -Tag $storeTags | Out-Null
 
# Lock Log Analytics resource group with a CanNotDelete lock
$lock = Get-AzResourceLock -ResourceGroupName $rgNameLogAnalyticsWorkspace
 
if ($null -eq $lock){
    New-AzResourceLock -LockName DoNotDeleteLock -LockLevel CanNotDelete -ResourceGroupName $rgNameLogAnalyticsWorkspace -LockNotes "Prevent $rgNameLogAnalyticsWorkspace from deletion" -Force | Out-Null
    }
 
Write-Host ($writeEmptyLine + "# Resource group $rgNameLogAnalyticsWorkspace available with tags and CanNotDelete lock" + $writeSeperatorSpaces + $currentTime)`
-foregroundcolor $foregroundColor2 $writeEmptyLine
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Create the Log Analytics workspace if it does not exist and add the specified tags
 
try {
    Get-AzOperationalInsightsWorkspace -Name $LogAnalyticsWorkspaceName -ResourceGroupName $rgNameLogAnalyticsWorkspace -ErrorAction Stop | Out-Null
} catch {
    New-AzOperationalInsightsWorkspace -ResourceGroupName $rgNameLogAnalyticsWorkspace -Name $LogAnalyticsWorkspaceName -Location $region -Sku $logAnalyticsWorkspaceSku -Force | Out-Null
}
 
# Set tags Log Analytics workspace
#Set-AzOperationalInsightsWorkspace -ResourceGroupName $rgNameLogAnalyticsWorkspace -Name $LogAnalyticsWorkspaceName -Tag $tags | Out-Null
 
# Add purpose tag Log Analytics workspace
#$storeTags = (Get-AzOperationalInsightsWorkspace -Name $LogAnalyticsWorkspaceName -ResourceGroupName $rgNameLogAnalyticsWorkspace).Tags
#$storeTags += @{$tagPurposeName = $tagPurposeValue}
#Set-AzOperationalInsightsWorkspace -ResourceGroupName $rgNameLogAnalyticsWorkspace -Name $LogAnalyticsWorkspaceName -Tag $storeTags | Out-Null
 
Write-Host ($writeEmptyLine + "# Log Analytics workspace $LogAnalyticsWorkspaceName created" + $writeSeperatorSpaces + $currentTime)`
-foregroundcolor $foregroundColor2 $writeEmptyLine
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Save the Log Analytics workspace in a variable 
 
$workSpace = Get-AzOperationalInsightsWorkspace -Name $LogAnalyticsWorkspaceName -ResourceGroupName $rgNameLogAnalyticsWorkspace
 
Write-Host ($writeEmptyLine + "# Log Analytics workspace variable created" + $writeSeperatorSpaces + $currentTime)`
-foregroundcolor $foregroundColor2 $writeEmptyLine
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## List all solutions and their installation status
 
# Get-AzOperationalInsightsIntelligencePack -ResourceGroupName $rgNameLogAnalyticsWorkspace -Name $LogAnalyticsWorkspaceName
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Save the list of solutions to enable in a variable 
 
# Optional solution -> ChangeTracking (also automatically installed by Azure Automation)
# Optional solution -> Updates (also automatically installed by Azure Automation Updating Solution)
# Optional solution -> VMInsights (also automatically installed by linking the Log Analytics workspace with VM Insights)
 
# Deprecated solution -> KeyVault
# Deprecated solution -> AzureNetworking
# Deprecated solution -> Backup
 
$lawSolutions = "Security", "SecurityInsights", "AgentHealthAssessment", "AzureActivity", "SecurityCenterFree", "DnsAnalytics", "ADAssessment", "AntiMalware", "ServiceMap", `
"SQLAssessment", "SQLVulnerabilityAssessment", "SQLAdvancedThreatProtection", "AzureAutomation", "Containers", "ChangeTracking", "Updates", "VMInsights"
 
Write-Host ($writeEmptyLine + "# Solutions variable created" + $writeSeperatorSpaces + $currentTime)`
-foregroundcolor $foregroundColor2 $writeEmptyLine
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Add the required solutions to the Log Analytics workspace
 
foreach ($solution in $lawSolutions) {
    New-AzMonitorLogAnalyticsSolution -Type $solution -ResourceGroupName $rgNameLogAnalyticsWorkspace -Location $workSpace.Location -WorkspaceResourceId $workSpace.ResourceId | Out-Null
}
 
Write-Host ($writeEmptyLine + "# Solutions added to Log Analytics workspace $LogAnalyticsWorkspaceName" + $writeSeperatorSpaces + $currentTime)`
-foregroundcolor $foregroundColor2 $writeEmptyLine
 
## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## List all monitor log analytics solutions under the Log Analytics workspace resource group
 
# Get-AzMonitorLogAnalyticsSolution -ResourceGroupName $rgNameLogAnalyticsWorkspace
 
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#Get All Available Metrics
$subscriptionId = (Get-AzContext).Subscription.Id
$metric = @()
$log = @()
$categories = Get-AzDiagnosticSettingCategory -ResourceId $workSpace.ResourceId
$categories | ForEach-Object {if($_.CategoryType -eq "Metrics"){$metric+=New-AzDiagnosticSettingMetricSettingsObject -Enabled $true -Category $_.Name -RetentionPolicyDay 7 -RetentionPolicyEnabled $true} else{$log+=New-AzDiagnosticSettingLogSettingsObject -Enabled $true -Category $_.Name -RetentionPolicyDay 7 -RetentionPolicyEnabled $true}}
New-AzDiagnosticSetting -Name test-setting -ResourceId $workSpace.ResourceId -WorkspaceId /subscriptions/$subscriptionId/resourcegroups/test-rg-name/providers/microsoft.operationalinsights/workspaces/test-workspace -Log $log -Metric $metric


## Set the log and metrics settings for the Log Analytics workspace if they don't exist
 
try {
    Get-AzDiagnosticSetting -Name $logAnalyticsDiagnosticsName -ResourceId $workSpace.ResourceId -ErrorAction Stop | Out-Null
     
} catch {
    Set-AzDiagnosticSetting -Name $logAnalyticsDiagnosticsName -ResourceId $workSpace.ResourceID -Category Audit -MetricCategory AllMetrics -Enabled $true -WorkspaceId ($workSpace.ResourceId) | Out-Null
}
 
Write-Host ($writeEmptyLine + "# Log Analytics workspace $LogAnalyticsWorkspaceName diagnostic settings set" + $writeSeperatorSpaces + $currentTime)`
-foregroundcolor $foregroundColor2 $writeEmptyLine
 
## ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
## Write script completed
 
Write-Host ($writeEmptyLine + "# Script completed" + $writeSeperatorSpaces + $currentTime)`
-foregroundcolor $foregroundColor1 $writeEmptyLine
 
## --------------------------------------------------------------------