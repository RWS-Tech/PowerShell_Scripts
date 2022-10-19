$AppVersion = 'x.xx'
$32BitPath = 'C:\Program Files (x86)\Notepad++\notepad++.exe'
If([String](Get-Item -Path $32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Up-to-date"
Exit 0
}
else {
Write-Host "Update"
Exit 1
}
