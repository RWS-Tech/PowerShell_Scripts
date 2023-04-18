$TZone = "Pacific Standard Time"
$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation"
$CTZone = [String](Get-ItemPropertyValue -Path $RegPath -Name TimeZoneKeyName -ea SilentlyContinue)

If($CTZone -eq $TZone) {
Write-Host "Installed"
}