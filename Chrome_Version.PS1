$servers = Get-Content -Path C:\temp\servername.txt

Foreach ($server in $servers) {

    if (Test-Connection -ComputerName $server -Quiet) {

    Write-Host "Connection is Good" -ForegroundColor Green

    Get-ItemProperty "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome" | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate

    Export-Csv -Path C:\temp\chrome_Output.Csv | Select-Object -Property Name

    }

    Else {

        Write-Host "Unable to Connect to server" -ForegroundColor Red
    }

} 
