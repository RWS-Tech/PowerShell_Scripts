Function GetUp {
    $BootupTime = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
    $CurrentDate = Get-Date
    $Uptime = $CurrentDate - $BootupTime
    Write-Output $Uptime
}
GetUp