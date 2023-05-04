#This script will set the custom colour template for a site collection.

#SharePoint admin site url
$adminSiteUrl = ""
$themeName = ""
#ask user for credentials. User needs SharePoint Admin rights
#connect to SPO
Connect-SPOService $adminSiteUrl
#Replace the variable value with the generated code
$theme = @{
    "themePrimary" = "#006bdd";
    "themeLighterAlt" = "#f4f8fe";
    "themeLighter" = "#d2e5fa";
    "themeLight" = "#accff5";
    "themeTertiary" = "#5ea2eb";
    "themeSecondary" = "#ffa300";
    "themeDarkAlt" = "#0061c8";
    "themeDark" = "#0051a9";
    "themeDarker" = "#003c7c";
    "neutralLighterAlt" = "#f8f8f8";
    "neutralLighter" = "#f4f4f4";
    "neutralLight" = "#eaeaea";
    "neutralQuaternaryAlt" = "#dadada";
    "neutralQuaternary" = "#d0d0d0";
    "neutralTertiaryAlt" = "#c8c8c8";
    "neutralTertiary" = "#595959";
    "neutralSecondary" = "#373737";
    "neutralPrimaryAlt" = "#2f2f2f";
    "neutralPrimary" = "#000000";
    "neutralDark" = "#151515";
    "black" = "#0b0b0b";
    "white" = "#ffffff";
    }
#I ran into a few issues with theme updating using the -overwrite
#command so removing it and re-adding it
#Remove-SPOTheme -name $themeName
Add-SPOTheme -Name $themeName -Palette $theme -IsInverted:$false
    