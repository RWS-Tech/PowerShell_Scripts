Function CPUUsage {
    cls

    $Processor = (Get-WmiObject -Class win32_processor -ErrorAction Stop | Measure-Object -Property LoadPercentage -Average | Select-Object Average).Average
    $CPU = [Math]::Round($Processor,0)
    Write-Output "Processor Usage: $($CPU)%"
    Exit 0
}
CPUUsage