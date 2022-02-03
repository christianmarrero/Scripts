$Computers = Get-Content -Path C:\temp\servername.txt

foreach ($Computer in $Computers) {
    $PC = $computer
    $online = $false
    $ver = ''

    if (Test-Connection $pc -Count 1 -Quiet -BufferSize 1) {
        $online = $true
        $exe = "\\$pc\c$\Program Files*\Google\Chrome\Application\chrome.exe"

        if (Test-Path $exe) {
            $path = (Resolve-Path $exe).ProviderPath
            $ver = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($path).FileVersion
        }
    }

    [pscustomobject]@{
        ComputerName = $PC.split('.', 2)[0]
        Online = $online
        ChromeVersion = $ver
    } | epcsv C:\temp\test.csv -Append -NoTypeInformation
}