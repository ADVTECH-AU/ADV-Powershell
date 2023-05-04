#This script will convert the Teams Library ID to ASCII.

param (
    [Parameter(Mandatory=$true)]
    [string]$TeamsLibraryID
)
$UpdatedID = [uri]::UnescapeDataString($TeamsLibraryID)
Write-Output $UpdatedID