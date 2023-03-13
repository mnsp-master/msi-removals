#Checks for presence of installed software using: if folder exists
#used in conjunction with emco package builder, to create necessary operating folder/path and distribute/execute this powershell script.
clear-host
$LogDir = "C:\Temp\MNSP"
$transcriptlog = "$LogDir\$(Get-date -Format yyyyMMdd-HHmmss)_FusionRemove_transcript.log"
$sleep = "60"
$AppPath = "C:\Program Files (x86)\SIMS\Sims .net"

Start-Transcript -Path $transcriptlog
function DottedLine {
Write-Host "-----------------------------------------------------------------------------------------------`n"
} 
DottedLine
    If($installed) {
        Write-Host "'$software' is installed, procedding with removal..."
        & $command $arguments # execute uninstaller
        Write-Host "Sleeping for $sleep seconds..."
        start-Sleep $sleep
        Remove-Item $AppPath -Recurse -Force -Verbose #force delete orphaned FS content
        } else {
        Write-Host "$software' is not installed, exiting with no further actions..."
    }
DottedLine
Stop-Transcript

<#
$software = "FusionInventory Agent 2.6 (x64 edition)"
$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null #checks for uninstall string from registry
#>