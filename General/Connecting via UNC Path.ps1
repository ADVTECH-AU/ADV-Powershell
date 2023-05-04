#This script will connect to a UNC path using a username and password.

$username = ""
$pass = "" | ConvertTo-SecureString -AsPlainText -Force
$Path = "\\server\share"
$creds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $pass
New-PSDrive -Name Adobe -PSProvider FileSystem -Root "$Path" -Credential $creds
