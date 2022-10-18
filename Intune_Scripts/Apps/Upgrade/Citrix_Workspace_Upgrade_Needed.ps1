$AppVersion = 'xx.x.x.xx'
$64BitPath = 'C:\Program Files\Citrix\Citrix WorkSpace*\TrolleyExpress.exe'
$32BitPath = 'C:\Program Files (x86)\Citrix\Citrix WorkSpace*\TrolleyExpress.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -lt $AppVersion){
Write-Host "Installed"
}
