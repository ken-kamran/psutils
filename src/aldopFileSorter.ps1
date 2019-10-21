Function ExtractFromFile($_filePath, $_regex){
    $file=$null; $line=$null; $ret=$null;
    
    $file = [IO.File]::OpenText($_filePath)
    do{
		$line=$file.ReadLine()
		if($line -match $_regex){
			$ret = $matches["match"]
			break;
		}
	
	}until (!$file.EndOfStream)
	$file.Close()
	return $ret
}

function EnsureFolder($_destination, $_date){
	$yearDest=$null; $yearDest=$null;$destination1=$null

    $yearDest =  [IO.Path]::Combine($_destination, $_date.ToString("yyyy"))
	$destination1 = [IO.Path]::Combine($yearDest , $_date.ToSTring("MM (MMMM)") )
    if( (test-path -Path $destination1) -eq $false){ new-item -Path $destination1 -ItemType directory | Out-null}
    return $destination1
}

function SortFileByDate($_filePath, $_destFolder, $_regex, $_dateFormat){
	
    $dateText=$null; $date=$null; $destination=$null; $fileName=$null; $filePathDest=$null

    $dateText = ( ExtractFromFile $_filePath $_regex )

    if($dateText -eq $null){return}  # no date found n file
    $date = [DateTime]::ParseExact( $dateText, $_dateFormat, $null )

    $yyyyMMdd = $date.ToString("yyyyMMdd")
    $destination = ( EnsureFolder $_destFolder $date)
    $fileName = [IO.Path]::GetFileName($_filePath)

    $filePathDest = [IO.Path]::Combine($destination,  $yyyyMMdd + "_" + $fileName ) 
    move-item -path $_filePath -destination $filePathDest -Force | Out-null
}

function SortAldop($_source, $_destPath){
	
	$sourcePath = "$_source\DLY*.*"
	$regext = "(?<match>\d{1,2}[-\/\\]\d{1,2}[-\\\/]\d{2})"
	$dateFormat = "M/d/yy"
	get-childitem $sourcePath | %{ SortFileByDate $_.FullName $_destPath $regext $dateFormat} | Out-null
	
	$sourcePath = "$_source\ALD*"
	$regext = "FILHDR.{2}\d{6}\s{4}\d{8}\s{4}(?<match>\d{8})"
	$dateFormat = "yyyyMMdd"
	get-childitem $sourcePath | %{ SortFileByDate $_.FullName $_destPath $regext  $dateFormat} | Out-null
	
	$sourcePath = "$_source\ALI*"
	$regext = "FILHDR.{2}\d{6}\s{4}\d{8}\s{4}(?<match>\d{8})"
	$dateFormat = "yyyyMMdd"
	get-childitem $sourcePath | %{ SortFileByDate $_.FullName $_destPath $regext $dateFormat} | Out-null
}

$sPath ="\\wanlink\dfsroot\Apps\GCM Feeds\PreProd\Aldop"
$dPath =  "\\wanlink\dfsroot\Apps\GCM Feeds\PreProd\Aldop\Archive"

SortAldop $sPath $dPath
