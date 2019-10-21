$remoteM = @("Nj1QaApp13", , "Nj1UatApp13")

foreach($m in $remoteM){
	write-host $m
	 get-service -computername $m -include Guggenheim*|? Status -eq Running| stop-service
}

foreach($m in $remoteM){
	write-host $m
	 get-service -computername $m -include Guggenheim*|? Status -eq Stopped|? StartType -ne Disabled| start-service
}



<#


Status (Running, Stopped) , StartType (Disabled, Automatic)


#>