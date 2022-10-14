# This contains the version to check for.
$AppVersion = ""

# This contains the path to the 64-Bit installation.
$64BitPath = ""


# The following code checks to make sure the application is installed
# at the assigned version.
If([String](Get-Item -Path $64BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion -ge $AppVersion){
 Write-Host "Installed"
}