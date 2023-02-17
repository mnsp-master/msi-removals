$computername = 'pc-1', 'pc-2'
$sourcefile = "\\server\script\CrystalDiskInfo7.0.4.msi"

foreach ($computer in $computername) {
	$destinationFolder = "\\$computer\C$\Temp"
	
	if (!(Test-Path -path $destinationFolder -Credential $domaincredentials)) {
		New-Item $destinationFolder -Type Directory -Credential $domaincredentials
	}
	Copy-Item -Path $sourcefile -Destination $destinationFolder -Credential $domaincredentials
	Invoke-Command -ComputerName $computer -Credential $domaincredentials -ScriptBlock { Msiexec /i \\server\script\CrystalDiskInfo7.0.4.msi /log C:\MSIInstall.log }