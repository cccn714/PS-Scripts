$name = $env:computername
Add-Computer -DomainName Tillsterkiosk.com -ComputerName $name -Passthru -Verbose -Restart -Force