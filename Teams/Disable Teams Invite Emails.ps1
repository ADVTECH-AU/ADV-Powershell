Connect-ExchangeOnline 

$Groups = Get-UnifiedGroup

foreach ($Group in $Groups) {
    Set-UnifiedGroup $group.displayname -UnifiedGroupWelcomeMessageEnabled:$false -Verbose
}
Disconnect-ExchangeOnline -Confirm:$false 