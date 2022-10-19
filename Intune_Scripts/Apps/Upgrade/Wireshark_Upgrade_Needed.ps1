$AppVersion = 'x.x.x'
$64BitPath = 'C:\Program Files\Wireshark\Wireshark.exe'
$32BitPath = 'C:\Program Files (x86)\Wireshark\Wireshark.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Up-to-date"
}
Else {
Write-Host "Update"
}
