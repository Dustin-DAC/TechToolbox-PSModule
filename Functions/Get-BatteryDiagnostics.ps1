
function Get-BatteryDiagnostics {
[CmdletBinding()]
Param ()
Set-Var
$Log = $Var.log

#Report Gen/Copy
powercfg.exe /Systemsleepdiagnostics   
Copy-Item -Path "C:\WINDOWS\system32\system-sleep-diagnostics.html" -Destination "$Log\system-sleep-diagnostics.html"
powercfg.exe /Systempowerreport
Copy-Item -Path "C:\WINDOWS\system32\sleepstudy-report.html" -Destination "$Log\SystemPower-report.html"
powercfg.exe /Batteryreport
Copy-Item -Path "C:\Windows\System32\battery-report.html" -Destination "$Log\battery-report.html"
powercfg.exe /sleepstudy
Copy-Item -Path "C:\WINDOWS\system32\sleepstudy-report.html" -Destination "$Log\sleepstudy-report.html"
}