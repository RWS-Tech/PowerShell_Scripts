# This contains the version to check for.
$AppVersion = ""

# This contains the path to the 32-Bit installation.
$32BitPath = "${Env:ProgramFiles(x86)}\"

# The following code checks to make sure the application is installed
# at the assigned version.
If([String](Get-Item -Path $32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
 Write-Host "Installed"
}