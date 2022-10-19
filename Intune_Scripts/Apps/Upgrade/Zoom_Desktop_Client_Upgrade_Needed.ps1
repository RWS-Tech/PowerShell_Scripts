$64BitPath = 'C:\Program Files\Zoom\bin\Zoom.exe'
$32BitPath = 'C:\Program Files (x86)\Zoom\bin\Zoom.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Update"
}
else {
Write-Host "Not Installed"
}