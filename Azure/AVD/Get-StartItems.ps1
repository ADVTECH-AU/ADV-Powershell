Set-AZContext -SubscriptionID "1d9a022e-4226-4512-9498-051e45d34fb4"
Get-AzWvdStartMenuItem -ApplicationGroupName "Test" -ResourceGroupName "AVD-Pooled" | Format-List