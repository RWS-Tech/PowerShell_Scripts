$AppVersion = 'xx.xx.xx.xx'
$RegPath1 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{19C8F1A9-2F50-49A6-9B81-2C4CE9845521}'
$RegPath2 = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{19C8F1A9-2F50-49A6-9B81-2C4CE9845521}'
If([Version](Get-ItemPropertyValue -Path $RegPath1,$RegPath2 -Name DisplayVersion -ea SilentlyContinue) -ge $AppVersion) {
Write-Host "Up-to-date"
}
Else {
Write-Host "Update"
}
