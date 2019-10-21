DirectoryListWithArguments.ps1
foreach($i in $args){
	get-childitem $i -recurse| where length -gt 1000 | sort name
}