#Checks for presence of installed software using: if folder exists
#used in conjunction with emco package builder, to create necessary operating folder/path and distribute/execute this powershell script.
clear-host
$mnspver = "1.0.0.0.6"
$LogDir = "C:\Temp\MNSP"
$transcriptlog = "$LogDir\$(Get-date -Format yyyyMMdd-HHmmss)_Sims.netClient_Remove_transcript.log"
$sleep = "20"
$AppPathSIMS = "C:\Program Files (x86)\SIMS\Sims .net"
$AppPathOpenVPN = "C:\Program Files\OpenVPN"
$AppPathScomisHosted = "C:\Program Files (x86)\Scomis\Hosted Applications"
$StartMenuContent = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\SIMS Applications"

$software = "Sims .Net Client"
Start-Transcript -Path $transcriptlog
function DottedLine {
Write-Host "-----------------------------------------------------------------------------------------------`n"
} 
DottedLine

if(!((Test-Path $AppPathScomisHosted ) -and (Test-Path $AppPathOpenVPN))) { #if neither of the other app paths exist proceed with removal...

    if(Test-Path $AppPathSIMS ) {
        Write-Host "'$software' is installed, procedding with removal..."

            # get pulsar process - force kill off if currently running...
            $pulsar = Get-Process pulsar -ErrorAction SilentlyContinue
            if ($pulsar) {
                Write-Host "sims.net client running..."
                $pulsar
                DottedLine
                Write-Host "Force killing process..."
                $pulsar | Stop-Process -Force
            }
            Remove-Variable pulsar
            start-sleep $sleep

        Remove-Item $AppPathSIMS -Recurse -Force -Verbose #force delete orphaned FS content
        Write-Host "Sleeping for $sleep seconds..."
        start-Sleep $sleep
        Remove-Item $StartMenuContent -Recurse -Force -Verbose #force delete orphaned FS content

        } else {
        Write-Host "$software' is not installed, exiting with no further actions..."
    }
DottedLine
}
Stop-Transcript

<#
Question
Sign in to vote
4
Sign in to vote
if( !( ( test-path c:\install\foo.bar ) -and ( test-path c:\install\test.txt ) ) ){
"one of the files not found!"; break

start-Sleep $sleep
& $command $arguments # execute uninstaller
$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null #checks for uninstall string from registry

#>
