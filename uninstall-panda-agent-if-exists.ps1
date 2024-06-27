$mnspver = "0.0.20"
$LogDir = "C:\Temp\MNSP"
$transcriptlog = "$LogDir\$(Get-date -Format yyyyMMdd-HHmmss)_Panda_removal_transcript.log"

function DottedLine {
Write-Host "-----------------------------------------------------------------------------------------------`n"
} 

Clear-host
Start-Transcript -Path $transcriptlog
DottedLine
Write-Host "Script Version: $mnspver"
DottedLine

Write-Host "Checking for Panda Security - Panda Endpoint Agent..."
$software = "Panda Endpoint Protection"
$Isinstalled = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null #checks for uninstall string from registry

if($IsInstalled) {
    Write-host "$software installed, procedding with uninstall..."
    $installed = (Get-ItemProperty 'HKLM:\SOFTWARE\WOW6432Node\Panda Security\SetupEx\Aether Agent' ) #| Where { $_.DisplayName -eq $software }) -ne $null #checks for uninstall string from registry
    $msiGuid = $($installed.ProductCodeMSI)
    Write-Host "Software: $software GUID:" $msiGuid
    Write-Host "Procedding with msiexec uninstall..."
    $msiGuid = $($installed.ProductCodeMSI)
    Write-Host "Uninstall MSI GUID:" $msiGuid
    Start-Process "C:\Windows\System32\msiexec.exe" -ArgumentList "/x $msiGuid /quiet /noreboot /L* $LogDir\$msiguid.log" -Wait
    } else {
    Write-Host "$software is not installed, exiting with no further actions..."
}

DottedLine

    Write-Host "Checking for Panda Software - Panda Endpoint Protection (AV/Antimalware)..."
    $software = "Panda Endpoint Protection"
    $Isinstalled = (Get-ItemProperty 'HKLM:\SOFTWARE\WOW6432Node\Panda Software\Setup\'* | Where { $_.LProductName -eq $software }) -ne $null #checks for string from registry

if($IsInstalled) {
    Write-host "$software installed, procedding with uninstall..."
    $installed = (Get-ItemProperty 'HKLM:\SOFTWARE\WOW6432Node\Panda Software\Setup' )
    $msiGuid = $($installed.ProductCodeMSI)
    $msiGuid
    Start-Process "C:\Windows\System32\msiexec.exe" -ArgumentList "/x $msiGuid /quiet /noreboot /L* $LogDir\$msiguid.log" -Wait
    } else {
    Write-Host "$software is not installed, exiting with no further actions..."
}

Stop-Transcript
