# This contains the path to the 64-Bit installation.
$64BitPath = "$Env:ProgramFiles\"

# The following code checks to make sure the application is installed
# at the assigned version.
If([String](Get-Item -Path $64BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Update"
}
Else {
Write-Host "Not Installed"
}