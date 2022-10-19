$AppVersion = '22.8.31.3'
$64BitPath = 'C:\Program Files\Calabrio One\Desktop\active\bin\DCC.exe'
$32BitPath = 'C:\Program Files (x86)\Calabrio One\Desktop\active\bin\DCC.exe'
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Installed"
}
