const { spawn } = require('child_process');

// PowerShell script code
const powershellScript = `
$counterName = '\\GPU Engine(*)\\Utilization Percentage'
$processes = Get-Counter -Counter $counterName | Select-Object -ExpandProperty CounterSamples | Sort-Object -Property CookedValue -Descending

$highestProcess = $processes[0]
$highestInstanceName = $highestProcess.InstanceName

# Extract the process ID (PID) from the InstanceName using regular expression and remove "pid_" prefix
$processId = $highestInstanceName -replace 'pid_(\\d+).*', '$1'

# Get the process with the highest GPU counter and kill it
$processToKill = Get-Process -Id $processId
if ($processToKill) {
    $processToKill | Stop-Process -Force
    return "Process with PID $processId has been killed."
} else {
    return "No process found with PID $processId."
}
`;

// Spawn PowerShell process
const powershell = spawn('powershell.exe', ['-ExecutionPolicy', 'Bypass', '-Command', powershellScript]);

// Capture output from PowerShell
let powershellOutput = '';
powershell.stdout.on('data', (data) => {
    powershellOutput += data.toString();
});

// Handle error events
powershell.stderr.on('data', (data) => {
    console.error(`PowerShell error: ${data}`);
});

// Handle PowerShell process exit
powershell.on('exit', (code) => {
    if (code === 0) {
        console.log('PowerShell script execution completed successfully.');
        console.log('Output:', powershellOutput);
    } else {
        console.error(`PowerShell process exited with code ${code}`);
    }
});
