$AppVersion = '23.001.20064'
$RegPath1 = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{AC76BA86-7AD7-1033-7B44-AC0F074E4100}'
$RegPath2 = 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{AC76BA86-7AD7-1033-7B44-AC0F074E4100}'
If([Version](Get-ItemPropertyValue -Path $RegPath1,$RegPath2 -Name DisplayVersion -ea SilentlyContinue) -ge $AppVersion) {
Write-Host "Installed"
}