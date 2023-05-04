$Path = "HKLM\SYSTEM\CurrentControlSet\Control\Lsa"
$Name = "RestrictAnonymous"
$Type = "DWORD"
$Value = 1

New-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value -force
