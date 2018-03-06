$DC03 = (nslookup Tillkiosk-dc03.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
$DC04 = (nslookup Tillkiosk-dc04.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
$SCCM02 = (nslookup Kiosk-sccm02.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
Write-Host Tillkiosk-dc03.tillsterkiosk.com $DC03 -Foreground White
Write-Host Tillkiosk-dc04.tillsterkiosk.com $DC04 -Foreground White
Write-Host Kiosk-sccm02.tillsterkiosk.com $SCCM02 -Foreground White
If ($DC03 -eq "Address:  10.99.2.119") {Write-Host Connection to Ireland was Successful -Foreground Green}
Else {Write-Host Connection to Ireland Failed -Foreground Red}