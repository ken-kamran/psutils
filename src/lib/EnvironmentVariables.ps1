function AddToPath([string]$newpath, [bool]$append){

	if ($env:Path -notcontains $(";" + $newPath + ";"))
	{
        write-host "`n`n"
        
        if($append){
            $envPath = $env:Path.TrimEnd(';') + ';' + $newPath
        }else{
            $envPath = "$newPath;$env:Path"
        }
        $envPath = $envPath.Replace(';;',';')
        write-host "`n"
        SetPath $envPath
	}
	else{
		write-host "path already exist"
	}
}

function SetPath($envPath){
	write-host $envPath
	$proceed = Read-host "Proceed (Y/N)?"
	if($proceed -eq "Y"){
		$env:Path = $envPath
		[Environment]::SetEnvironmentVariable("Path", $envPath , [System.EnvironmentVariableTarget]::Machine)
	}
}

function AddUniquePath($dict, $val){
    if([String]::IsNullOrEmpty($val) -eq $false){
        if($dict.ContainsKey -eq $false){
            $dict.Add($val,$val)
        }
        else{
            Write-Host "Duplicate path $val found"
        }
    }
}