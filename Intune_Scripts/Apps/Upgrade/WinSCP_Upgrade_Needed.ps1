$64BitPath = 'C:\Program Files\WinSCP\WinSCP.exe'
$32BitPath = 'C:\Program Files (x86)\WinSCP\WinSCP.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Update"
}
else {
Write-Host "Not Installed"
}
