$AppVersion = '2.112.603.0'
$64BitPath = 'C:\Program Files\Microsoft Power BI Desktop\bin\PBIDesktop.exe'
$32BitPath = 'C:\Program Files (x86)\Microsoft Power BI Desktop\bin\PBIDesktop.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Installed"
}