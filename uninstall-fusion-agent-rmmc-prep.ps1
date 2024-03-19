#Checks for presence of running process if exists will force terminate it wait for 60 seconds and repeat n times
#used in conjunction with emco package builder, to create necessary operating folder/path and distribute/execute this powershell script.
#
clear-host
$MNSPver = "0.0.1"
$LogDir = "C:\Temp\MNSP"
$transcriptlog = "$LogDir\$(Get-date -Format yyyyMMdd-HHmmss)_FusionRemove_transcript.log"
$sleep = "60"
$ProcessToKIll = "fusioninventory-agent_windows-x64_2.6"
$RetryCount = 3

Start-Transcript -Path $transcriptlog
function DottedLine {
Write-Host "-----------------------------------------------------------------------------------------------`n"
} 

DottedLine

do { #loop for n times
    $attempt = $RetryCount - ($RetryCount -$_)

        $process = Get-Process "$ProcessToKill"
        if ( $process ) {

        Write-host "Process running force killing..."
        Write-host "Loop number:" $attempt
        Stop-Process $Process -Force -Verbose
        sleep 60

        }
    $_++ #Increment loop counter
} until ($attempt -gt $RetryCount)

DottedLine
Stop-Transcript
