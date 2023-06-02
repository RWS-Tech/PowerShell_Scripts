Function RAMUsage {
    $RamMsg1 = "RAM Usage: "
    $RamMsg2 = "%"

    $ComputerMemory = Get-WmiObject -Class win32_operatingsystem -ErrorAction Stop
    $Memory = ((($ComputerMemory.TotalVisibleMemorySize - $ComputerMemory.FreePhysicalMemory) * 100) / $ComputerMemory.TotalVisibleMemorySize)
    $RoundMemory = [Math]::Round($Memory, 2)
    Write-Output "RAM Usage: $($RoundMemory)%"
    Exit 0
}
RAMUsage