





#Custom Logging Directory
if (!(Test-Path -Path "C:\log")) {
    New-Item -Path C:\log -ItemType Directory -Force
}




function Set-Var {
    #Sets Variable with common locations
    $Var = @{
        Log  = "C:\log\"
        Date = Get-Date -Format MM-dd-yy
    }
    Set-Variable -Name $ITS -Value $ITS -Scope Script -Force
    return $Var
}


#Loading all items in the functions folder
$Functions = (Get-ChildItem $PSScriptRoot\Functions\ -Recurse -Name)

foreach ($Func in $Functions) {
    . "$PSScriptRoot/Functions/$Func"
}
