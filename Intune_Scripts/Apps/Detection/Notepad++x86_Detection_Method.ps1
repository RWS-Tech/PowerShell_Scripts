$AppVersion = ''
$32BitPath = 'C:\Program Files (x86)\Notepad++\notepad++.exe'
If([String](Get-Item -Path $32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Installed"
Exit 0
}
else {
Exit 1
}
