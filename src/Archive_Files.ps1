$source= "\\nj1qaapp13\deploy\logs\Archive\*.log*"
$archive = "\\nj1qaapp13\deploy\Logs\Archive"

gci $source | ? {$_.Name -Match "\.log(?<date>\d{8})$"}|
%{
    $dateText = $matches["date"]
    $date = [DateTime]::ParseExact( $dateText, "yyyyMMdd", $null)
    $destination = [IO.Path]::Combine( $archive, $date.ToString("yyyy"), $date.ToString("MM (MMMM)"))


    if( (Test-Path $destination) -eq $false) { New-Item -path $destination -ItemType directory }
    $filePathDest = [IO.Path]::Combine( $destination, $_.Name)
    move-item $_.FullName $filePathDest -force
}





