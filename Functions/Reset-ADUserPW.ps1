
function Reset-ADUserPW {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]
        $ADUserID,
        [bool]
        $RequireReset
    )
    $password = New-Password
    #Verify Require Reset Flag
    if (Get-ADUser -Identity $ADUserID) {
        $PasswordExpCheck = (Get-ADUser -Identity $ADUserID -Property PasswordNeverExpires)
        if ($PasswordExpCheck.PasswordNeverExpires -eq $true) {
            Write-Host "The user $ADUser has their password set to never expire."
            $IsExpOk = Read-Host -Prompt "Is this correct? (y/n)"
            if ($IsExpOk.ToLower() -eq "y" -And $RequireReset -eq $true) {
                Write-Host "This will conflict with requiring a password reset. Would you like to change the user settings now?"
                $ConfirmChange = Read-Host "Change Setting? (y/n)"
                if ($ConfirmChange.ToLower() -eq "y") {
                    Set-ADUser -Identity $ADUser PasswordNeverExpires $false
                }
                else {
                    Write-Host "Changing your selection for reset request to false."
                    $RequireReset = $false
                }
            }
        } 
        Set-ADAccountPassword -Identity $ADUserID -Reset -NewPassword (ConvertTo-SecureString $Password -AsPlainText -Force)
        Write-Host "##########################"
        Write-Host $password
        Write-Host "##########################"
    }
    Else { Write-Host "This user can not be found. Please verify the username." }
    #Actual Password Reset
    if ($RequireReset -eq $true) { Set-ADUser -Identity $ADUserID -ChangePasswordAtLogon $true } else { Set-ADUser -Identity $ADUserID -ChangePasswordAtLogon $false }
    #Unlock them for good measure
    Unlock-ADAccount -Identity $ADUserID
    if (!(Get-InstalledModule -name ADSync)) { 
        Write-Host "ADSync not installed/configured "
        Write-Host "Please run manually or wait 10 minutes if its already configured on this server." 
    }
    else {
        Import-module -Name ADSync
        Write-host "AdSync Module Loaded"
        Write-Host "##########################"
        Start-ADSyncSyncCycle -PolicyType Delta
        Write-Host "##########################"
    }
}
