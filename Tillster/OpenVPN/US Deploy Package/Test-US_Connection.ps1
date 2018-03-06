$DC01 = (nslookup Tillkiosk-dc01.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
$DC02 = (nslookup Tillkiosk-dc02.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
$SCCM01 = (nslookup Kiosk-sccm01.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
Write-Host Tillkiosk-dc01.tillsterkiosk.com $DC01 -Foreground White
Write-Host Tillkiosk-dc02.tillsterkiosk.com $DC02 -Foreground White
Write-Host Kiosk-sccm01.tillsterkiosk.com $SCCM01 -Foreground White
If ($DC01 -eq "Address:  10.90.2.214") {Write-Host Connection to Ireland was Successful -Foreground Green}
Else {Write-Host Connection to Ireland Failed -Foreground Red}