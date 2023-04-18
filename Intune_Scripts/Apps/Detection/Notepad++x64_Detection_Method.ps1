$AppVersion = '8.5'
$64BitPath = 'C:\Program Files\Notepad++\notepad++.exe'
If([String](Get-Item -Path $64BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Installed"
Exit 0
}
else {
Exit 1
}
