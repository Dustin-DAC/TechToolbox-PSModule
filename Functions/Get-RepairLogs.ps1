function Get-RepairLogs {
    [CmdletBinding()]
    Param ()
    Set-Var
    $Log = $Var.log
    $Date = Get-Date -Format dd-MM-yy
    #Custom Var's
    $CBS_Data = Get-Content -Path C:\Windows\Logs\CBS\CBS.log -Tail 150
    $DISM_Data = Get-Content -Path C:\Windows\Logs\DISM\dism.log -Tail 150
    #Starting Transcription to combine logs into one file.
    Start-Transcript -Append -Path $Log+"\CHKDSK_SFC_DISM_log-"+$Date+".log"
    Get-WinEvent -FilterHashtable @{logname = "Application"; id = "1001" } | Where-Object { $_.providername -match "wininit" } | Format-List TimeCreated, Message
    Write-Output "Start SFC Log"
    $CBS_Data
    Write-Output "Start DISM Log"
    $DISM_Data
    Stop-Transcript
}