#Checks for presence of installed software using: if folder exists
#used in conjunction with emco package builder, to create necessary operating folder/path and distribute/execute this powershell script.
clear-host
$LogDir = "C:\Temp\MNSP"
$transcriptlog = "$LogDir\$(Get-date -Format yyyyMMdd-HHmmss)_FusionRemove_transcript.log"
$sleep = "20"
$AppPath = "C:\Program Files (x86)\SIMS\Sims .net"
$StartMenuContent = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SIMS Applications"
$software = "Sims .Net Client"
Start-Transcript -Path $transcriptlog
function DottedLine {
Write-Host "-----------------------------------------------------------------------------------------------`n"
} 
DottedLine
    If(Test-Path $AppPath {
        Write-Host "'$software' is installed, procedding with removal..."
        
        Remove-Item $AppPath -Recurse -Force -Verbose #force delete orphaned FS content
        Write-Host "Sleeping for $sleep seconds..."
        start-Sleep $sleep
        Remove-Item $StartMenuContent -Recurse -Force -Verbose #force delete orphaned FS content

        } else {
        Write-Host "$software' is not installed, exiting with no further actions..."
    }
DottedLine
Stop-Transcript

<#
start-Sleep $sleep
& $command $arguments # execute uninstaller

$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null #checks for uninstall string from registry
#>