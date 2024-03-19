#Checks for presence of running process and if exists will force terminate it wait for 60 seconds and repeat n times
#used in conjunction with emco package builder, to create necessary operating folder/path and distribute/execute this powershell script.
#
clear-host
$MNSPver = "1.0.3"
$LogDir = "C:\Temp\MNSP"
$transcriptlog = "$LogDir\$(Get-date -Format yyyyMMdd-HHmmss)_FusionRemove_RMMC_Prep_transcript.log"
$sleep = "60"
$ProcessToKIll = "fusioninventory-agent_windows-x64_2.6.exe"
$RetryCount = 2 #note attempt 1 will be counted as 0

Start-Transcript -Path $transcriptlog
Get-date
function DottedLine {
Write-Host "-----------------------------------------------------------------------------------------------`n"
} 
DottedLine
do { #loop for n times
    $attempt = $RetryCount - ($RetryCount -$_)
    $process = Get-Process "$ProcessToKill" -ErrorAction Ignore
        if ( $process ) {
        Write-host "Process running force killing..."
        Write-host "Loop number:" $attempt
        Stop-Process $Process -Force -Verbose
        Start-Sleep $sleep 
        }
    $_++ #Increment loop counter
    Write-Host "Starting failsafe sleep... $(Get-date)"
    Start-Sleep $sleep # additional sleep - just in case process has begun after script has started
} until ($attempt -gt $RetryCount)

DottedLine
Stop-Transcript
