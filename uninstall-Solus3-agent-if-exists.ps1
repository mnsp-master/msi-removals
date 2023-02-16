#Checks for presence of installed software using uninstall string from registry
#Invokes program's uninstall.exe to remove application.
#used in conjunction with emco package builder, to create necessary operating folder/path and distribute/execute this powershell script.
clear-host
$LogDir = "C:\Temp\MNSP"
$transcriptlog = "$LogDir\$(Get-date -Format yyyyMMdd-HHmmss)_Solus3_Remove_transcript.log"
#$sleep = "60"
$AppPath = "C:\Windows\system32\msiexec.exe"
$Args = "/x {839FB6AD-0623-469E-BCC9-3249A8BF74C4} /qn /L*V $LogDir\Solus3AgentRemoveMSI.log"

Start-Transcript -Path $transcriptlog
function DottedLine {
Write-Host "-----------------------------------------------------------------------------------------------`n"
} 
DottedLine
$software = "SOLUS 3 Agent"
$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq $software }) -ne $null #checks for uninstall string from registry
    If($installed) {
        Write-Host "'$software' is installed, procedding with removal..."
        #& $command # execute uninstaller
        Start-Process $AppPath -ArgumentList $Args -Wait
        #Write-Host "Sleeping for $sleep seconds..."
        #start-Sleep $sleep
        #Remove-Item $AppPath -Recurse -Force -Verbose #force delete orphaned FS content
        } else {
        Write-Host "$software' is not installed, exiting with no further actions..."
    }
DottedLine
Stop-Transcript

#/x {839FB6AD-0623-469E-BCC9-3249A8BF74C4} /qn /L*V %WORK_DIR%\Solus3AgentRemoveMSI.log