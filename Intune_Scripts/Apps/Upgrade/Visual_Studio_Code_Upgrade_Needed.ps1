$64BitPath = 'C:\Program Files\Microsoft VS Code\Code.exe'
$32BitPath = 'C:\Program Files (x86)\Microsoft VS Code\Code.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Update"
}
Else {
Write-Host "Not Installed"
}