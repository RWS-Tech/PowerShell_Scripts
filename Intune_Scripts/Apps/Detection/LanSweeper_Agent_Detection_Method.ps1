# This contains the path to the 64-Bit installation.
$64BitPath = "$Env:ProgramFiles\LansweeperAgent\LansweeperAgentService.exe"

# This contains the path to the 32-Bit installation.
$32BitPath = "${Env:ProgramFiles(x86)}\LansweeperAgent\LansweeperAgentService.exe"

# The following code checks to make sure the application is installed
# at the assigned version.
If([String](Get-Item -Path $64BitPath,$32BitPath -ErrorAction SilentlyContinue).VersionInfo.FileVersion){
Write-Host "Installed"
}