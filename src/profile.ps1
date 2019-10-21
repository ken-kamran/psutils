
function newAlias($name, $val){
	if( $(test-path alias:$name) -eq $false){
		write-host "creating new alias $name $val"
		new-alias -name $name -value $val -scope "Global"
	}
}


newalias 'ghp' 'get-help'
newalias 'gcmd' 'get-command'
newalias "gmem" "get-member"
newalias "wh" "write-host"
