#This script will enable the OneDrive library mount feature on a device.

$Path = "HKCU:\SOFTWARE\Microsoft\OneDrive\Accounts\Business1"
$Name = "Timerautomount"
$Type = "QWORD"
$Value = 1

Try {
    $Registry = Get-ItemProperty -Path $Path -Name $Name -ErrorAction Stop | Select-Object -ExpandProperty $Name
    If ($Registry -eq $Value){
        Write-Output "Compliant"
        Exit 0
    } 
    Write-Warning "Not Compliant"
    Exit 1
} 
Catch {
    Write-Warning "Not Compliant"
    Exit 1
}