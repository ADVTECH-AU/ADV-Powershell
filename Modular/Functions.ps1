#This script will contain all the functions that are used in the scripts.

function Remove-HTML {
    param (
        [object]$Field
    )
        if($Field -cne $null){
        ($Field -replace '<[^>]+?>','').Trim()
        }
        else {$Field = "No Information Supplied"}
    }



function Validate-Date {
param (
    [object]$Date
)
    if($Date -cne $null){
        Write-Output (Get-Date -Date $Date[0] -Format "yyyy-MM-dd")
    }
    else {Write-Error "Incoming date can not be null" -ErrorAction SilentlyContinue}
}