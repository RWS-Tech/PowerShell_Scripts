If(Test-Path -Path "$Env:ProgramFiles\TeamViewer\TeamViewer.exe","${Env:ProgramFiles(x86)}\TeamViewer\TeamViewer.exe"){
Exit 1
}
Else{
Write-Host "Installed"
Exit 0
}