$AppVersion = '5.21.5.12858'
$64BitPath = 'C:\Program Files\WinSCP\WinSCP.exe'
$32BitPath = 'C:\Program Files (x86)\WinSCP\WinSCP.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Installed"
Exit 0
}
else {
Exit 1
}
