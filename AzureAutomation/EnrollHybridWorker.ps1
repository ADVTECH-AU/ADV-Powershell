#Enrolls Device into specified tenant AzureAutomation as a hybrid worker inside its own group.

#Azure Details
$AAResourceGroupName = ""
$SubscriptionID = ""
$TenantID = ""
$WorkspaceName = ""
$AutomationAccountName = ""
$HybridGroupName = $env:COMPUTERNAME


#Install Package Provider Nuget
Install-PackageProvider -Name NuGet
#If not working try setting tls 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Install-Script -Name New-OnPremiseHybridWorker -Force
Set-ExecutionPolicy Bypass Process
#Will need user login for user with high level permission of azure automation.
Set-AzContext -SubscriptionId $SubscriptionID -TenantId $TenantID
New-OnPremiseHybridWorker.ps1 -AAResourceGroupName $AAResourceGroupName -SubscriptionID $SubscriptionID -TenantID $TenantID -WorkspaceName $WorkspaceName -AutomationAccountName $AutomationAccountName -HybridGroupName $HybridGroupName