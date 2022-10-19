# This contains the version to check for.
$AppVersion = "x.x.x.x"

# This contains the path to the 64-Bit installation.
$64BitPath = "$Env:ProgramFiles\Dell\CommandUpdate\dcu-cli.exe"

# This contains the path to the 32-Bit installation.
$32BitPath = "${Env:ProgramFiles(x86)}\Dell\CommandUpdate\dcu-cli.exe"

# The following code checks to make sure the application is installed
# at the assigned version.
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
 Write-Host "Installed"
}