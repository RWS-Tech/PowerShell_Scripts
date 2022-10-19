$AppVersion = "4.6.0.1"
$32BitPath = "$Env:ProgramFiles\Dell\CommandUpdate\dcu-cli.exe"
$64BitPath = "${Env:ProgramFiles(x86)}\Dell\CommandUpdate\dcu-cli.exe"

If([String](Get-Item -Path $32BitPath,$64BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
Write-Host "Installed"
Exit 0
}
else {
Exit 1
}