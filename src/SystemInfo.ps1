$credential = get-credential "wanlink\mkarab"
$remoteM = @("Nj1QaApp13", , "Nj1UatApp13", "Nj1QaSql04", "Nj1UatSql04")
foreach($m in $remoteM){
	$session = new-pssession -computername $m -credential $credential
	invoke-command -session $session -scriptblock {systeminfo.exe >> 'c:\temp\systeminfo.txt'}	
}
