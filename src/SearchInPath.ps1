Param($searchFor )
function SearchInPath($searchFor){
	write-host $searchfor
	$env::Path.Split(';')| %{
	if($_ -like "*$searchFor*"){
		return $true
		}
		else{
			return $false
		}
	}
}