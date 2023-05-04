#For Downloading Compliance Searches and getting around the 500 error in GUI
$ComplianceSearchName = ""

Connect-ExchangeOnline
Connect-IPPSSession

New-ComplianceSearchAction -SearchName $ComplianceSearchName -ArchiveFormat SinglePst -Export

Disconnect-ExchangeOnline -confirm:$false
