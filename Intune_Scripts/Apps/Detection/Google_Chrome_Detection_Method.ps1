$AppVersion = '108.0.5359.125'
$64BitPath = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
$32BitPath = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Installed"
Exit 0
}
else {
Exit 1
}
