#Unfinished

Connect-MsolService
Get-MsolAccountSku 
Connect-AzureAD
(Get-AzureADSubscribedSku | Where-Object {$_.SkuPartNumber -eq "PROJECTPROFESSIONAL"} | Select ServicePlans).ServicePlans

Disconnect-AzureAD -Confirm:$false