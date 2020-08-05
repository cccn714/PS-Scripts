$AADComputer = "SERVERNAME"
$session = New-PSSession -ComputerName $AADComputer
Invoke-Command -Session $session -ScriptBlock {Import-Module -Name 'ADSync'}
Invoke-Command -Session $session -ScriptBlock {Start-ADSyncSyncCycle -PolicyType Delta}
Remove-PSSession $session