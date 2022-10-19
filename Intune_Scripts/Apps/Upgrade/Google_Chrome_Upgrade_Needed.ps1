$AppVersion = 'xxx.x.xxxx.xxx'
$64BitPath = 'C:\Program Files\Google\Chrome\Application\chrome.exe'
$32BitPath = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Up-to-date"
Exit 0
}
else {
Write-Host "Update"
Exit 1
}
