$AppVersion = 'xxx.x.x'
$64BitPath = 'C:\Program Files\Mozilla Firefox\firefox.exe'
$32BitPath = 'C:\Program Files (x86)\Mozilla Firefox\firefox.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Update"
}
Else {
Write-Host "Not Installed"
}
