function UpgradeFramework($filePath){

	$content = (get-content $filePath)

	if($content -ne $null){
		$newContent = $content.Replace('"net40"', '"net45"').Replace('"net35"', '"net45"')
		set-content -path $filePath -value $newcontent
	}
}

gci -path . -filter packages.config -recurse | %{UpgradeFramework($_.fullname)}