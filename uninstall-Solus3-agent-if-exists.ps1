##Checks for presence of installed software using uninstall string from registry
#Invokes msiexec to remove application.
#used in conjunction with emco package builder, to create necessary operating folder/path and distribute/execute this powershell script.
clear-host
$mnspver = "1.0.0.2.1"
$LogDir = "C:\Temp\MNSP"
$transcriptlog = "$LogDir\$(Get-date -Format yyyyMMdd-HHmmss)_Solus3_Remove_transcript.log"
$sleep = "60"
$AppPath = "C:\Program Files\Solus3"

Start-Transcript -Path $transcriptlog
function DottedLine {
Write-Host "-----------------------------------------------------------------------------------------------`n"
} 
DottedLine
$software = "SOLUS 3 Agent"

$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null #checks for uninstall string from registry
    If($installed) {
        Write-Host "'$software' is installed, procedding with removal..."

        $product = Get-WmiObject win32_product | where-object {$_.name -eq "$software"}  
        $product.IdentifyingNumber
        Start-Process "C:\Windows\System32\msiexec.exe" `
        -ArgumentList "/x $($product.IdentifyingNumber) /quiet /noreboot /L*V $LogDir\Solus3AgentRemoveMSI.log" -Wait
        
        Write-Host "Sleeping for $sleep seconds..."
        start-Sleep $sleep
        Remove-Item $AppPath -Recurse -Force -Verbose #force delete orphaned FS content
        } else {
        Write-Host "$software' is not installed, exiting with no further actions..."
    }
DottedLine
Stop-Transcript



