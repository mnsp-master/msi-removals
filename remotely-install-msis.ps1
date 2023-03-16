# mnsp-ver 0.0.0.0.23
Clear-Host

$sourcefile = Read-Host "UNC Path to source msi... e.g \\server1\share\install.msi"
$SourceMSI = $sourcefile.split("\")[-1]
$destinationFolder = "C:\Temp"
$installer = "$destinationFolder\$SourceMSI"
$log = "$destinationFolder\$SourceMSI.log"

do { # loop until user selects 2 to quit - begin

	Write-Host "1. Remotely execute msiexec"
	Write-host "2. Quit"
	$choice = Read-Host "Chose a number to continue"

		switch ($choice)
		{
			1 {
				$computername = Read-Host -Prompt 'Input target server name...'
				
				$destinationFolder = "\\$computername\C$\Temp"
				Write-Host " Checking for folder: $destinationFolder ..."
				
				if (!(Test-Path -path $destinationFolder)) {
					Write-Host "Creating folder: $destinationFolder ..."
					New-Item $destinationFolder -Type Directory
				}

				Write-Host "Copying file: $sourcefile to $destinationFolder ..."
				Copy-Item -Path $sourcefile -Destination $destinationFolder -Verbose

				Write-Host "Starting remote session on: $computername ..."
				$session = New-PSSession -computername $computername
				$session				

				Write-Host "Invoking msiexec on target machine $computername..."
				Invoke-Command -Session $session -ScriptBlock { $SN02=(Start-Process msiexec -ArgumentList '/i', $using:installer, '/q', '/l*', $using:log -wait -PassThru)
				Write-Host "MsiExec Exitcode:" $SN02.ExitCode
				}

				Write-host "Closing remote session on $computername ..."
				Remove-PSSession $session

				Write-Host "--------------------------------------------------------------------- `n"
				#>
			}		

		}

}until ($choice -eq 2) # loop until user selects 2 to quit - end
Write-Host "Bye...."

#Invoke-Command -Session $session -ScriptBlock { Copy-Item -Path $using:sourcefile -Destination $using:destinationFolder -Verbose}
#$installer = "$using:destinationFolder\$using:SourceMSI"
#$log = "/l* $using:destinationFolder\$using:sourceMSI.log"

#$installer
#$log

#Write-Host "invoking msiexec on remote computer $computername ..."
#Invoke-Command -ComputerName $computername -ScriptBlock { Msiexec /i C:\Temp\$sourceMSI /qb }


