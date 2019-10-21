. "$PSScriptRoot\lib\EnvironmentVariables.ps1"

$paths = $env:Path -isplit ';'

for($i=0 ; $i -lt $paths.length ;$i++){
    write-host "[$i] = $($paths[$i])"
}
$toRemove = Read-host "Enter comma separated list of entries to remove"
$entries = $toRemove -split ","


$final = new-object System.Text.StringBuilder($paths.Length)

for($i=0 ; $i -lt $paths.length ;$i++){

    if($entries -notcontains [string]"$i" -and $paths[$i].Trim() -ne ""){
		Write-host "i = $i, entires=$entries"
        [void]$final.append($paths[$i] + ";")
    }
}

Read-host "Hit Enter to continue"
write-host $final.ToString()
SetPath $final.ToString()


<#
for($i=0 ; $i -lt $paths.length ;$i++){
    if($entries -notcontains [String]"$i"){
        $final.Append($paths[$i] + ";")
    }
}
#>

<#
for($i=0 ; $i -lt $final.length ;$i++){
    write-host "[$i] = $($final[$i])"
}
#>
