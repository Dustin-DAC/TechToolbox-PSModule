
function Get-TeamsDiagnostics {
    [CmdletBinding()]
    Param ()
 
    $Var = Set-Var
    $Date = $Var.Date
    $Log = $Var.Log
    $Temp = $Var.Temp
    
    New-ITSFolders

    Start-Transcript -Append -Path "$Log\Teams_NetTest.log"
    #Static Vars
    $URL = "https://download.microsoft.com/download/D/D/6/DD65CA90-94CF-4B10-88A2-67432D8EB78F/MicrosoftSkypeForBusinessNetworkAssessmentTool.exe"
    $SBNAS_Tool = "C:\Program Files (x86)\Microsoft Skype for Business Network Assessment Tool"
    $SBNAS_Perf_Result = "%localappdata%\Microsoft Skype for Business Network Assessment Tool\performance_results.tsv"
    $SBNAS_Perf_Result2 = "C:\Windows\system32\config\systemprofile\AppData\Local\Microsoft Skype for Business Network Assessment Tool\connectivity_results.txt"
    #Test if tool is installed
    if ((Test-Path -Path "$SBNAS_Tool\NetworkAssessmentTool.exe") -eq $false) {
        Invoke-WebRequest -Uri $URL -OutFile "$Temp\SBNAS.exe"
        Start-Process -FilePath "$Temp\sbnas.exe"
        Write-Output "Starting software installation"
        Wait-Process -Name sbnas.exe
    }
    Set-Location $SBNAS_Tool
    ./NetworkAssessmentTool.exe
    ./NetworkAssessmentTool.exe /connectivitycheck /verbose
    IF (Test-Path -Path $SBNAS_Perf_Result -IsValid) {
        ./ResultsAnalyzer.exe $SBNAS_Perf_Result
    }
    ELSE {
        ./ResultsAnalyzer.exe "$SBNAS_Perf_Result2"
    }
}
