$32BitPath = 'C:\Program Files (x86)\Notepad++\notepad++.exe'
If([String](Get-Item -Path $32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Update"
Exit 0
}
else {
Write-Host "Not Installed"
Exit 1
}
