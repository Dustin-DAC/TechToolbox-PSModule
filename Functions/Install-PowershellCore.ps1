
function Install-PowerShellCore {
    [CmdletBinding()]
        Param ()
    <#
        .SYNOPSIS
        Will install or upgrade Powershell Core 
        .DESCRIPTION
        Checks for current version installed and compares to latest from Github. If its not installed or needs to be upgraded it will do so.
        .EXAMPLE
        Install-PowershellCore
        .NOTES
        There is another function in here that may be exported. (Install-PShell) which can be used just to install the software.
    #>
        
    ### This will install the latest version of PowershellCore for Windows x64 on the PC
    IF (!(Get-Command -Module psreleasetools)) {
        Write-Host "Hold on, we are installing some modules so you get the correct version." -ForegroundColor Yellow
        Install-Module -Name PSReleaseTools
        Import-module -name PSreleasetools
    }
    #You can edit the $NewPS variable here and configure it to download whatever version you want. You will most likely just need to edit the -Match "xxx" portion to fit your version.
    $NewPS = Get-PSReleaseAsset -Only64Bit | Where-Object -Property FileName -Match "win-x64.msi"
    $NewestVer = $NewPS.FileName.Split("-")[1]
    
    function Install-PShell {   
        Set-Location "C:\Temp"
        Invoke-WebRequest -uri $NewPS.URL -OutFile .\PowershellCore.msi
        Write-Host "Download Complete" -ForegroundColor Yellow
        Write-Host "#####################################"
        Write-Host "File Name : $($NewPS.Filename)"
        Write-Host "OS Family : $($NewPS.Family)"
        Write-Host "Last Updated : $($NewPS.Updated)"
        Write-Host "#####################################"
        Write-Host "Starting Installation" -ForegroundColor Green
        #Actual Installation - Adjust the flags as needed
        msiexec.exe /package PowerShellCore.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
        Start-Sleep 15
        Write-Host "Installation is Complete" -ForegroundColor Green
        Remove-Item -Path .\PowershellCore.msi
    }
    if ((Get-ChildItem -Path 'C:\Program Files\PowerShell' -Name pwsh.exe -Recurse) -eq $true) {
        $ExistingVersion = & 'C:\Program Files\PowerShell\7\pwsh.exe' -Command { $PSVersionTable }
        if ($ExistingVersion.GitCommitId -eq $NewestVer) { Write-Output "You have the latest version installed." } else {
            Write-Host "Updating your version of PowerShell"
            Install-PShell
        }
    }
    else {
        Write-Host "Installing PowerShell Core"
        Install-PShell
    }
    }