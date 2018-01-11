New-GPO -Name "Domain - SREAdmin Folder"
New-GPO -Name "Domain - Windows Time"
New-GPO -Name "Security - IE Security-Defender Disable"
New-GPO -Name "Security - PS ExecutionPolicy"
New-GPO -Name "Security - Server Firewall Disabled"
New-GPO -Name "Security - Servers Local Admins"
New-GPO -Name "Security - Kiosks Local Admins"

$target="DC=qa,DC=tillsterkiosk,DC=com"
$target1="OU=Domain Controllers,DC=qa,DC=tillsterkiosk,DC=com"
$target2="OU=Servers,DC=qa,DC=tillsterkiosk,DC=com"
$target3="OU=Kiosks,DC=qa,DC=tillsterkiosk,DC=com"

New-GPLink -Name "Domain - SREAdmin Folder" -target $target -LinkEnabled Yes

New-GPLink -Name "Security - IE Security-Defender Disable" -target $target1 -LinkEnabled Yes
New-GPLink -Name "Security - IE Security-Defender Disable" -target $target2 -LinkEnabled Yes

New-GPLink -Name "Security - Server Firewall Disabled" -target $target1 -LinkEnabled Yes
New-GPLink -Name "Security - Server Firewall Disabled" -target $target2 -LinkEnabled Yes

New-GPLink -Name "Security - PS ExecutionPolicy" -target $target1 -LinkEnabled Yes
New-GPLink -Name "Security - PS ExecutionPolicy" -target $target2 -LinkEnabled Yes

New-GPLink -Name "Security - Servers Local Admins" -target $target2 -LinkEnabled Yes

New-GPLink -Name "Domain - Windows Time" -target $target2 -LinkEnabled Yes
New-GPLink -Name "Domain - Windows Time" -target $target3 -LinkEnabled Yes

New-GPLink -Name "Security - Kiosks Local Admins" -target $target3 -LinkEnabled Yes
