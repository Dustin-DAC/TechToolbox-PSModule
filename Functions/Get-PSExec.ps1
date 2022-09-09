Function Get-PSExec {
    [CmdletBinding()]
Param (
    [switch]$Regedit
)
Set-Var
$Log = $Var.log
$Temp = $Var.Temp

    
#Grab PSExec
Invoke-WebRequest -Uri https://download.sysinternals.com/files/PSTools.zip -OutFile $Temp\PST.zip

Expand-Archive PST.zip

if ($Regedit -eq $True){
#Pop Regedit as System
cd "$Temp\PST"
.\psexec -i -d -s "c:\windows\regedit.exe"
}
}