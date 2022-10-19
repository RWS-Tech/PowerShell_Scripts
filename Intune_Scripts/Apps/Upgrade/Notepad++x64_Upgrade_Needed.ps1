$AppVersion = 'x.xx'
$64BitPath = 'C:\Program Files\Notepad++\notepad++.exe'
If([String](Get-Item -Path $64BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Up-to-date"
Exit 0
}
else {
Write-Host "Update"
Exit 1
}
