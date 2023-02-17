# mnsp-ver 0.0.0.0.19
Clear-Host

$sourcefile = Read-Host "UNC Path to source msi... e.g \\server1\share\install.msi"
$SourceMSI = $sourcefile.split("\")[-1]
$destinationFolder = "C:\Temp"

do { # loop until user selects 2 to quit - begin

	Write-Host "1. Remotely install msi"
	Write-host "2. Quit"
	$choice = Read-Host "Chose a number to continue"

		switch ($choice)
		{
			1 {
				$computername = Read-Host -Prompt 'Input target server name...'
				
				$destinationFolder = "\\$computername\C$\Temp"
				Write-Host " Checking for $destinationFolder"
				
				if (!(Test-Path -path $destinationFolder)) {
					New-Item $destinationFolder -Type Directory
				}

				Copy-Item -Path $sourcefile -Destination $destinationFolder -Verbose

				$session = New-PSSession -computername $computername
				$session

				
				#Invoke-Command -Session $session -ScriptBlock { Copy-Item -Path $using:sourcefile -Destination $using:destinationFolder -Verbose}
				#$installer = "$using:destinationFolder\$using:SourceMSI"
				#$log = "/l* $using:destinationFolder\$using:sourceMSI.log"

				$installer
				$log
				
				Invoke-Command -Session $session -ScriptBlock { $SN02=(Start-Process msiexec -ArgumentList '/x', $using:installer, '/q', $using:log -wait -PassThru)
				Write-Host "Exitcode:" $SN02.ExitCode
				}

				Remove-PSSession $session

				#Write-Host "invoking msiexec on remote computer $computername ..."
				#Invoke-Command -ComputerName $computername -ScriptBlock { Msiexec /i C:\Temp\$sourceMSI /qb }
				Write-Host "--------------------------------------------------------------------- `n"
				#>
			}		

		}

}until ($choice -eq 2) # loop until user selects 2 to quit - end
Write-Host "Bye...."