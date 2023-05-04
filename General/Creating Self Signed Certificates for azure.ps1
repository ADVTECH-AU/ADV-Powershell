#This script will create a self signed certificate for use with Azure AD DS

#Define your own DNS name used by your managed domain
$dnsName=""
$Password=""
$FileExportLocation="C:\export.pfx"

# Get the current date to set a one-year expiration
$lifetime=Get-Date

# Create a self-signed certificate for use with Azure AD DS
$Cert = New-SelfSignedCertificate -Subject *.$dnsName -NotAfter $lifetime.AddDays(365) -KeyUsage DigitalSignature, KeyEncipherment -Type SSLServerAuthentication -DnsName *.$dnsName, $dnsName -KeyExportPolicy Exportable
$Thumbprint = $Cert.Thumbprint
$mypwd = ConvertTo-SecureString -String $Password -Force -AsPlainText
Get-ChildItem -Path "cert:\LocalMachine\my\$Thumbprint"  | Export-PfxCertificate -FilePath $FileExportLocation -Password $mypwd -Verbose -Force -NoProperties