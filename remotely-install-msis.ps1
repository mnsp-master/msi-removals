# mnsp-ver 0.0.0.0.3
Clear-Host
#$sourcefile = "\\server\script\CrystalDiskInfo7.0.4.msi" #update UNC path as necessary
$sourcefile = Read-Host "Path to source msi..."

Read-Host "Please supply credentials when prompted, press any key to continue..."
#domaincredentials = Get-Credential


do {

Write-Host "1. Remotely install msi"
Write-host "2. Quit"
$choice = Read-Host "Chose a number to continue"

switch ($choice)
{
 1 {
	$computername = Read-Host -Prompt 'Input target server name...'
	#$computername = 'pc-1', 'pc-2'

	$destinationFolder = "\\$computer\C$\Temp"
	Write-Host " Checking for $destinationFolder"
	
	if (!(Test-Path -path $destinationFolder)) {
		New-Item $destinationFolder -Type Directory
	}

	<#
	Copy-Item -Path $sourcefile -Destination $destinationFolder -Credential $domaincredentials
	Invoke-Command -ComputerName $computer -Credential $domaincredentials -ScriptBlock { Msiexec /i C:\Temp\$sourcefile /qb }
	#>
 }

} 

}until ($choice -eq 2)
Write-Host "Bye...."