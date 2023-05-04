#unfinished
Connect-ExchangeOnline
New-ProtectionAlert -Name "High Risk User" -Description "Alerts on a high risk user" -Template HighRiskUser -Enabled $true -Severity High -TriggerType UserRiskScore -TriggerOperator GreaterThan -TriggerThreshold 70
