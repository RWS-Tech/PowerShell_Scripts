#Registry location containing the key
$RegKey1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$RegKey2 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
$RegVer = "15.39.5.0"

#Application Display Name
$AppName = 'TeamViewer'

If(Get-ChildItem -Path $RegKey1,$RegKey2 | Get-ItemProperty | Where-Object {($_.DisplayName -eq $AppName) -and ($_.DisplayVersion -ge $RegVer)})
{
Write-Host "Installed"
}