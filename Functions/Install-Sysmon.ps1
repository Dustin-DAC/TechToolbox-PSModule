
Function Install-Sysmon {
    [CmdletBinding()]
Param (
    [switch]$Regedit
)
Set-Var
$Log = $Var.log
$Temp = $Var.Temp

Invoke-WebRequest "https://download.sysinternals.com/files/Sysmon.zip" -OutFile "$Temp\sysmon.zip"
Expand-Archive "$Temp\sysmon.zip" -DestinationPath "$Temp\sysmon\"
Set-Location "$Temp\sysmon\"
.\sysmon64.exe -accepteula -i

}