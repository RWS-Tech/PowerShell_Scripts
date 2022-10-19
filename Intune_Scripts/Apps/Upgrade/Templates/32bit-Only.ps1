# This contains the path to the 32-Bit installation.
$32BitPath = "${Env:ProgramFiles(x86)}\"

# The following code checks to make sure the application is installed
# at the assigned version.
If([String](Get-Item -Path $32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Update"
}
Else {
Write-Host "Not Installed"
}