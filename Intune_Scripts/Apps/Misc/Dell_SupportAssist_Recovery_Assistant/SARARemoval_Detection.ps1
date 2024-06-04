Function SARARemoval {
    $SARAssist = Get-Package -Name "SupportAssist Recovery Assistant" -ErrorAction SilentlyContinue
	If(-not ($SARAssist)){
		Write-Host "Installed"
	}
}
SARARemoval