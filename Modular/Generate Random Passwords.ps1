#This script will generate a random password.

$CreatePassword = [System.Web.Security.Membership]::GeneratePassword($PasswordLength,$NonAlphaNumeric)
$PasswordLength = '15'
$NonAlphaNumeric = '0'