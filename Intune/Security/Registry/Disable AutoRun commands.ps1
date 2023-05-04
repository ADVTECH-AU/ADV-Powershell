$Path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$Name = "NoAutorun"
$Type = "DWORD"
$Value = 1

New-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value -force
