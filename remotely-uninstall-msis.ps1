# mnsp-ver 1.0.3
# remotely uninstall an msi using determined msi guid

Clear-Host

$SourceMsiGUID = Read-Host "MSI Guid to remove, include opening and closing braces... e.g: {2DD38941-E21A-49BE-9B7A-D61AC29D86BB}"
#$SourceMSI = $SourceMsiGUID.split("\")[-1]
$destinationFolder = "C:\Temp"
#$installer = "$destinationFolder\$SourceMSI"
$log = "$destinationFolder\$SourceMsiGUID.log"

do { # loop until user selects 2 to quit - begin

	Write-Host "1. Remotely execute msiexec remove/uninstall"
	Write-host "2. Quit"
	$choice = Read-Host "Choose a number to continue"

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

				#Write-Host "Copying file: $SourceMsiGUID to $destinationFolder ..."
				#Copy-Item -Path $SourceMsiGUID -Destination $destinationFolder -Verbose

				Write-Host "Starting remote session on: $computername ..."
				$session = New-PSSession -computername $computername
				$session				

				Write-Host "Invoking msiexec on target machine $computername..."
				Invoke-Command -Session $session -ScriptBlock { $SN02=(Start-Process msiexec -ArgumentList '/x', $using:SourceMsiGUID, '/q', '/l*', $using:log -wait -PassThru)
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
