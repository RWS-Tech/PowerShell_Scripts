$AppVersion = 'x.xx'
$64BitPath = 'C:\Program Files\Notepad++\notepad++.exe'
$32BitPath = 'C:\Program Files (x86)\Notepad++\notepad++.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Installed"
Exit 0
}
else {
Exit 1
}
