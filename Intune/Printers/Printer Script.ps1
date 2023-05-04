#This script will install multiple printers on a device.

#Local Printer Script
#Create array for drivers .exe or .zip files
$Drivers = @()
$Drivers += New-Object PSObject -Property @{
    DriverOnlineStorage = "#####", "#####"
}
#Check & Create Temp Folder
Start-Job -Name 'DriverFolder' -ScriptBlock {
    $testpath = Test-Path C:\Drivers
    if ($testpath -eq $false) {
        New-Item -Path 'C:\Drivers' -ItemType Directory
    }else {
        Write-Output "File Already Exists"
    } 
} | Wait-Job
#Cycle through each property in $Drivers array
#Adding multiple entries to array
foreach ($Driver in $Drivers.DriverOnlineStorage){
    $DriverName = $Driver.Split("/")[-1]
        if ($DriverName -match ".exe") {
            $DriverName = $DriverName -replace ".exe", ".zip"
        }
        $Exists = Test-Path "C:\Drivers\$DriverName"
    if ($Exists -eq $true){
        Write-Host "Driver $DriverName already exists"
        }else {
            #Download driver from online storage to local storage
            Start-BitsTransfer -Source $Driver -Destination "C:\Drivers\$DriverName" -Verbose
            Get-BitsTransfer | Complete-BitsTransfer
            #Extract driver from downloaded zip file
            Expand-Archive -Path "C:\Drivers\$DriverName" -DestinationPath "C:\Drivers" -Verbose -erroraction SilentlyContinue
            #Remove downloaded zip file
            Remove-Item "C:\Drivers\$DriverName"
            #Add Driver to Driver Store
            pnputil /add-driver "C:\Drivers\*.inf" /subdirs
        }
}
#Remove extracted driver files
#Remove-Item -Path "C:\Drivers" -Recurse

#Need to go find the Actual Driver Names you need from inside the oemsetup.inf File in the Driver Folder

#create array to hold printer details
$printers = @()
$printers += New-Object PSObject -Property @{
    Name = "";
    IP = "";
    PrintDriver = "";
    Colour = $false;
    Duplex = "TwoSidedLongEdge";
    PaperSize = "A4"
}
$printers += New-Object PSObject -Property @{
    Name = "";
    IP = "";
    PrintDriver = "";
    Colour = $true;
    Duplex = "TwoSidedLongEdge";
    PaperSize = "A4"
}


#loop through $printers
foreach ($printer in $printers) {
    #check if printer exists
    if (Get-WmiObject -Class Win32_Printer -Filter "Name='$($printer.Name)'" -ErrorAction SilentlyContinue) {
        Write-Host "Printer $($printer.Name) already exists" -ForegroundColor Yellow
    } else {
        #Add Driver for that Printer Found in OEM.inf file
        Add-PrinterDriver -Name $printer.PrintDriver -Confirm:$false -Verbose
        #Adds Printer Port
        $PrinterPortName = "IP_$($printer.IP)"
        Add-PrinterPort -Name $PrinterPortName -PrinterHostAddress $printer.IP -Confirm:$false -ErrorAction SilentlyContinue -Verbose
        #Adds Printer
        Add-Printer -Name $printer.Name -DriverName $printer.PrintDriver -PortName $PrinterPortName -Confirm:$false -Verbose
        Write-Host "Printer $($printer.Name) added" -ForegroundColor Green
        #Set Printer Settings
        Set-PrintConfiguration -Color $printer.colour -PrinterName $printer.Name -DuplexingMode $printer.Duplex -PaperSize $printer.PaperSize -Confirm:$false -Verbose
    }
}
