







if (!(Test-Path -Path "C:\log")) {
    New-Item -Path C:\log -ItemType Directory -Force
}
if (!(Test-Path -Path "C:\temp")) {
    New-Item -Path C:\temp -ItemType Directory -Force
}

function Set-Var {
    
    #Custom Logging Directory
    
    #Sets Variable with common locations
    $Var = @{
        Log  = "C:\log\"
        Date = Get-Date -Format MM-dd-yy
        Temp = "C:\Temp"
    }
    Set-Variable -Name $Var -Value Set-Var -Scope Script -Force
    return $Var
}


#Loading all items in the functions folder
$Functions = (Get-ChildItem $PSScriptRoot\Functions\ -Recurse -Name)

foreach ($Func in $Functions) {
    . "$PSScriptRoot/Functions/$Func"
}
