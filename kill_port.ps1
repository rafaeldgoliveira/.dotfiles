param ($port)

if(!$port)
{
	$port = "5037"
}

$foundProcesses = netstat -ano | findstr :$port
$activePortPattern = ":$port\s.+LISTENING\s+\d+$"
$pidNumberPattern = "\d+$"

IF ($foundProcesses | Select-String -Pattern $activePortPattern -Quiet)
{
	$processMatches = $foundProcesses | Select-String -Pattern $activePortPattern
	$firstMatch = $processMatches.Matches.Get(0).Value

	$pidNumber = [regex]::match($firstMatch, $pidNumberPattern).Value

	taskkill /pid $pidNumber /f
}
