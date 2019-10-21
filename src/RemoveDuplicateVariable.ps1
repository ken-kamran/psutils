. "$PSScriptRoot\lib\EnvironmentVariables.ps1"

$array = $env:Path.Split(';')

$dict = new-object @{}
foreach($path in $paths){
    AddUniquePath $dict $path
}

$dict.Keys -join ";"