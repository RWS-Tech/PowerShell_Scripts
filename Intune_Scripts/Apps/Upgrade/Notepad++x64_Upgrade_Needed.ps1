$64BitPath = 'C:\Program Files\Notepad++\notepad++.exe'
If([String](Get-Item -Path $64BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Update"
Exit 0
}
else {
Write-Host "Not Installed"
Exit 1
}
