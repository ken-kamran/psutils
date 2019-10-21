function EnsureFolder($folder){
	if( !(test-path -Path $folder)){ 
		new-item -Path $folder -ItemType directory | Out-null
		Write-host "Created new folder $folder"
	}
}

function CreateArchiveFolder($folder, $date){

    $yearDest =  [IO.Path]::Combine($folder, $date.ToString("yyyy"))
	$destination = [IO.Path]::Combine($yearDest , $date.ToSTring("MM (MMMM)") )
	EnsureFolder $destination
	return $destination
}

function RunEtl($root){
	Write-host "Exeuctinng Etl for $root"
	$archive = [IO.Path]::Combine($root, "Archive")
	$Inprogress = [IO.Path]::Combine($root, "In Progress")

	EnsureFolder $archive
	EnsureFolder $InProgress

	get-childitem $root -filter $filter |move-item -destination $InProgress
	Write-host "Moved files (if any) to $InProgress"
	
	write-host "Executing etl executable at: $executable"
	cmd /c $executable
	
	$dest = CreateArchiveFolder $Archive $date

	get-childItem $InProgress | %{
		$Name =  ($_.Name -Replace $_.extension, "") + "_" + $date.ToString("yyyyMMddHHmmss") + $_.extension
		$filePath = [IO.Path]::Combine($dest, $Name)
		write-host "Moving file '$Name' to '$filePath'"
		move-item -path $_.FullName -destination $filePath
	}
}

#Global
	$filter = "*.xlsx"
	$executable = "E:\Services\Guggenheim.Services.HoldingsMaster.Etl\HoldingsMaster.Etl.Console.exe"
	$date = [DateTime]::Now
	
	
#Main	

	$log=Join-Path (Get-ChildItem $MyInvocation.MyCommand.Definition).Directory (Get-ChildItem $MyInvocation.MyCommand.Definition).Basename
	Start-Transcript "$log.log"

	$roots = @("\\wanlink\dfsroot\Apps\Corporate Conflicts\System Files\QA\GPIM Holdings - CR Analytics")
	foreach($root in $roots){
		RunEtl($root)
	}
	
	stop-transcript
	
	