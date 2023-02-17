# mnsp-ver 0.0.0.0.13
Clear-Host

$sourcefile = Read-Host "UNC Path to source msi... e.g \\server1\share\install.msi"
$SourceMSI = $sourcefile.split("\")[-1]

do { # loop until user selects 2 to quit - begin

Write-Host "1. Remotely install msi"
Write-host "2. Quit"
$choice = Read-Host "Chose a number to continue"

switch ($choice)
{
 1 {
	$computername = Read-Host -Prompt 'Input target server name...'
	
	$session = New-PSSession -computername $computername
	$session

	#$destinationFolder = "\\$computername\C$\Temp"
	
	$destinationFolder = "C:\Temp"
	Write-Host " Checking for $destinationFolder"
	
	if (!(Test-Path -path $destinationFolder)) {
		New-Item $destinationFolder -Type Directory
	}

	Write-Host "Copy-Item -Path $using:sourcefile -Destination $destinationFolder -Verbose"

	$installer = "$destinationFolder\$using:SourceMSI"
	$log = "/l* $destinationFolder\$using:sourceMSI.log"
	
	#Invoke-Command -Session $session -ScriptBlock { $SN02=(Start-Process msiexec -ArgumentList '/x', $using:installer, '/q', $using:log -wait -PassThru)
	#Write-Host "Exitcode:" $SN02.ExitCode
}

	#Remove-PSSession

	#Write-Host "invoking msiexec on remote computer $computername ..."
	#Invoke-Command -ComputerName $computername -ScriptBlock { Msiexec /i C:\Temp\$sourceMSI /qb }
	Write-Host "--------------------------------------------------------------------- `n"
	#>
 }

 

}until ($choice -eq 2) # loop until user selects 2 to quit - end
Write-Host "Bye...."