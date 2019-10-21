Function Get-OperatingSystemVersion{
	(Get-WmiObject -Class win32_operatingSystem).Version
}