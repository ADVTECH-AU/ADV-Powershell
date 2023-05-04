#This script will remove or add teams channels in bulk.

$TeamName = "Projects"

#Install-Module MicrosoftTeams
Connect-MicrosoftTeams

if (!(Get-InstalledModule MicrosoftTeams)) {
    Install-Module MicrosoftTeams -Force
}

$TeamID = Get-Team -DisplayName $TeamName | Select GroupId

#Create teams channels in bulk
$ChannelNames = @(
    "", 
    "", 
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
    )

$ChannelNames | ForEach-Object {
    #Remove-TeamChannel -GroupId $TeamID.GroupId -DisplayName $_ 
    New-TeamChannel -GroupId $TeamID.GroupId -DisplayName $_ 
}

Disconnect-MicrosoftTeams

