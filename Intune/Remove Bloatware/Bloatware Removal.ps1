#This script removes bloatware from Windows 10. This script is intended to be used with Intune and Autopilot.

Get-AppxPackage -AllUsers *WindowsFeedbackHub* | Remove-AppxPackage -Confirm:$false -ErrorAction Continue
Get-AppxPackage -AllUsers *ZuneVideo* | Remove-AppxPackage -Confirm:$false -ErrorAction Continue
Get-AppxPackage -AllUsers *ZuneMusic* | Remove-AppxPackage -Confirm:$false -ErrorAction Continue
Get-AppxPackage -AllUsers *BingNews* | Remove-AppxPackage -Confirm:$false -ErrorAction Continue
Get-AppxPackage -AllUsers *BingWeather* | Remove-AppxPackage -Confirm:$false -ErrorAction Continue
Get-AppxPackage -AllUsers *SkypeApp* | Remove-AppxPackage -Confirm:$false -ErrorAction Continue
Get-AppxPackage -AllUsers MicrosoftTeams | Remove-AppxPackage -Confirm:$false -ErrorAction Continue
Get-AppxPackage -AllUsers *BingWeather* | Remove-AppxPackage -Confirm:$false -ErrorAction Continue
Get-AppxPackage -AllUsers *YourPhone* | Remove-AppxPackage -Confirm:$false -ErrorAction Continue
Get-AppxPackage -AllUsers *GamingApp* | Remove-AppxPackage -Confirm:$false -ErrorAction Continue
Get-AppxPackage -AllUsers *MixedReality.Portal* | Remove-AppxPackage -Confirm:$false -ErrorAction Continue

Get-AppxPackage "E046963F.AIMeetingManager" | Remove-AppxPackage
Get-AppxPackage "MicrosoftTeams" | Remove-AppxPackage
Get-AppxPackage "Microsoft.BingWeather" | Remove-AppxPackage
Get-AppxPackage "NcsiUwpApp" | Remove-AppxPackage
Get-AppxPackage "Microsoft.SkypeApp" | Remove-AppxPackage
Get-AppxPackage "E046963F.LenovoCompanion" | Remove-AppxPackage
Get-AppxPackage "E0469640.SmartAppearance" | Remove-AppxPackage
Get-AppxPackage "E0469640.LenovoUtility" | Remove-AppxPackage
Get-AppxPackage "MirametrixInc.GlancebyMirametrix" | Remove-AppxPackage
Get-AppxPackage "ElevocTechnologyCo.Ltd.SmartMicrophoneSettings" | Remove-AppxPackage
