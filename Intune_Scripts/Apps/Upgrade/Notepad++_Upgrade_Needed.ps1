$64BitPath = 'C:\Program Files\Notepad++\notepad++.exe'
$32BitPath = 'C:\Program Files (x86)\Notepad++\notepad++.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Update"
Exit 0
}
else {
Write-Host "Not Installed"
Exit 1
}
