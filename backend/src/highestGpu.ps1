$counterName = '\GPU Engine(*)\Utilization Percentage'
$processes = Get-Counter -Counter $counterName | Select-Object -ExpandProperty CounterSamples | Sort-Object -Property CookedValue -Descending

$highestProcess = $processes[0]
$highestInstanceName = $highestProcess.InstanceName

# Extract the process ID (PID) from the InstanceName using regular expression and remove "pid_" prefix
$processId = $highestInstanceName -replace 'pid_(\d+).*', '$1'

# Get the process with the highest GPU counter and kill it
$processToKill = Get-Process -Id $processId
if ($processToKill) {
    $processToKill | Stop-Process -Force
    Write-Host "Process with PID $processId has been killed."
} else {
    Write-Host "No process found with PID $processId."
}
