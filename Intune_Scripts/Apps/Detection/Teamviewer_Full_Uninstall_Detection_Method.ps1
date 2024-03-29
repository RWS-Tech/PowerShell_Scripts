#Registry location containing the key
$RegKey1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$RegKey2 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"

#Application Display Name
$AppName = 'TeamViewer'

If( -not (Get-ChildItem -Path $RegKey1,$RegKey2 | Get-ItemProperty | Where-Object {$_.DisplayName -eq $AppName })) {
Write-Host "Installed"
}