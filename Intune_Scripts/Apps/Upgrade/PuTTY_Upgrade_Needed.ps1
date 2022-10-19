# This contains the path to the 64-Bit installation.
$64BitPath = "$Env:ProgramFiles\PuTTY\putty.exe"

# This contains the path to the 32-Bit installation.
$32BitPath = "${Env:ProgramFiles(x86)}\PuTTY\putty.exe"

# The following code checks to make sure the application is installed
# at the assigned version.
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Update"
}
Else {
Write-Host "Not Installed"
}