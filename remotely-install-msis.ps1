# mnsp-ver 0.0.0.0.7
Clear-Host

$sourcefile = Read-Host "Path to source msi..."
$SourceMSI = $sourcefile.split("\")[-1]

do { # loop until user selects 2 to quit - begin

Write-Host "1. Remotely install msi"
Write-host "2. Quit"
$choice = Read-Host "Chose a number to continue"

switch ($choice)
{
 1 {
	$computername = Read-Host -Prompt 'Input target server name...'
	#$computername = 'pc-1', 'pc-2'

	$destinationFolder = "\\$computername\C$\Temp"
	Write-Host " Checking for $destinationFolder"
	
	if (!(Test-Path -path $destinationFolder)) {
		New-Item $destinationFolder -Type Directory
	}

	Copy-Item -Path $sourcefile -Destination $destinationFolder -Verbose
	Write-Host "invoking msiexec on remote computer $computername ..."
	Invoke-Command -ComputerName $computername -ScriptBlock { Msiexec /i C:\Temp\$sourceMSI /qb }
	Write-Host "--------------------------------------------------------------------- `n"
	#>
 }

} 

}until ($choice -eq 2) # loop until user selects 2 to quit - end
Write-Host "Bye...."