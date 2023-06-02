Function CPUUsage {
    $CpuMsg1 = "Processor Usage: "
    $CpuMsg2 = "%"

    $Processor = (Get-WmiObject -Class win32_processor -ErrorAction Stop | Measure-Object -Property LoadPercentage -Average | Select-Object Average).Average
    $CPU = [Math]::Round($Processor,0)
    Write-Output "$($CpuMsg1)$($CPU)$($CpuMsg2)"
    Exit 0
}
CPUUsage