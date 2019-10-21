. "$PSScriptRoot\lib\EnvironmentVariables.ps1"

[string]$prepost = Read-host "Prepend? Y/N ...(Append otherwise)"
[string]$newPath = Read-host "Add the new path"
$append = $true

if($prepost -eq "Y"){ 
    $append= $false
}

AddToPath $newPath.Trim() $append




