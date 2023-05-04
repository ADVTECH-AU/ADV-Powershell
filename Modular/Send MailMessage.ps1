#This script will send an email using the Office 365 SMTP server.

$Password = ''
$name = ''
$Subject = ''
$To = ''
$pass = $Password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($name,$pass)
Send-MailMessage -To $To -SmtpServer smtp.office365.com -Credential $cred -From $name -Subject $Subject -UseSsl -Body $Body