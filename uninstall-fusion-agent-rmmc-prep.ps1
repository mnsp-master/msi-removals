#Checks for presence of running process if exists will force terminate it wait for 60 seconds and repeat n times
#used in conjunction with emco package builder, to create necessary operating folder/path and distribute/execute this powershell script.
clear-host
$LogDir = "C:\Temp\MNSP"
$transcriptlog = "$LogDir\$(Get-date -Format yyyyMMdd-HHmmss)_FusionRemove_transcript.log"
$sleep = "60"
$ProcessToKIll = "fusioninventory-agent_windows-x64_2.6"

Start-Transcript -Path $transcriptlog
function DottedLine {
Write-Host "-----------------------------------------------------------------------------------------------`n"
} 
DottedLine

#retry 3 time loop required

        $process = Get-Process "$ProcessToKill"
        if ( $process ) {

        Write-host "Process running force killing..."
        Stop-Process $Process -Force
        sleep 60

        }

DottedLine
Stop-Transcript

<#

$ProcessToKIll = "fusioninventory-agent_windows-x64_2.6"
$process = Get-Process "$ProcessToKill"

if ( $process ) {

Write-host "Process running force killing..."
Stop-Process $Process -Force
sleep 60

}


$software = "FusionInventory Agent 2.6 (x64 edition)"
$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null #checks for uninstall string from registry
    If($installed) {
        Write-Host "'$software' is installed, procedding with removal..."
        & $command $arguments # execute uninstaller
        Write-Host "Sleeping for $sleep seconds..."
        start-Sleep $sleep
        Remove-Item $AppPath -Recurse -Force -Verbose #force delete orphaned FS content
        } else {
        Write-Host "$software' is not installed, exiting with no further actions..."
    }

#>