If([String](Get-Item -Path "$Env:ProgramFiles\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe","${Env:ProgramFiles(x86)}\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe" -ErrorAction SilentlyContinue).VersionInfo.ProductVersion -ge "19.0.20200.0"){
    Write-Host "Installed"
}