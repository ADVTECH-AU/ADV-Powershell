$Path = "HKLM\SYSTEM\CurrentControlSet\Control\Lsa"
$Name = "RunAsPPL"
$Type = "DWORD"
$Value = 1

New-ItemProperty -Path $Path -Name $Name -Type $Type -Value $Value -force
