$scripts = @(
	"Google_chrome.reg",
	"UserControlConsent.reg"
)

foreach($script in $scripts){
	reg import .\$script
}

set-timezone -Id "Eastern Standard Time"