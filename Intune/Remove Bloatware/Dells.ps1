

Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Get-AppxPackage -name "E046963F.LenovoCompanion" | Remove-AppxPackage
Get-AppxPackage -name "E0469640.SmartAppearance" | Remove-AppxPackage
Get-AppxPackage -name "E04693F.AIMeetingManager" | Remove-AppxPackage
Get-AppxPackage -name "MirametixInc.GlancebyMirametix" | Remove-AppxPackage
Get-AppxPackage -name "NcsiUwpApp" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.BingNews" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.XboxIdentityProvider" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.ZuneMusic" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.ZuneVideo" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.Advertising.Xaml" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.SkypeApp" | Remove-AppxPackage
Get-AppxPackage -name "E0469640.LenovoUtility" | Remove-AppxPackage
Get-AppxPackage -name "Microsoft.GamingApp" | Remove-AppxPackage