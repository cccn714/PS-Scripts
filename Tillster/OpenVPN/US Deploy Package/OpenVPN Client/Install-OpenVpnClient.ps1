#---Created 12-13-17---#
#---C Newell---#
# Current openvpn client version is 2.4.4-I601 if client is updated change line 28 to reflect new version #

#---Run Powershell as Admin---#
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#---Set ExecutionPolicy---#
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

#---Copy CMTrace---#
Copy-Item "C:\US Deploy\cmtrace.exe" -Destination "C:\Windows\System32"

#---Set Location of ROOT Folder---#
Set-Location -Path "C:\Install-Openvpn"

#---Import Trusted OPENVPN Cert---#
$Certificate = "openvpn.pfx"
$CertLocation = "Cert:\LOCALMACHINE\TrustedPublisher"
Write-Host Importing OpenVpn Trusted Certificate... -Foreground Yellow
Import-Certificate -FilePath $Certificate -CertStoreLocation $CertLocation
$CertExists = Get-ChildItem -Path Cert:\LOCALMACHINE\TrustedPublisher\5E66E0CA2367757E800E65B770629026E131A7DC | Test-Path
If ($CertExists -eq "true"){Write-Host Certificate installed Successfully -Foreground Green}
ElseIf ($CertExists -eq "false") {Write-Host Certificate not installed Successfully -Foreground Red}
Else {Write-Host There was an issue with the certificate installation path -Foreground Red}

#---Install App---#
Write-Host Starting OpenVpn Install... -Foreground Yellow
Start-Process -Filepath openvpn-install-2.4.4-I601.exe /S
Write-Host Waiting 30s for OpenVpn Install to Complete... -Foreground Yellow
Start-Sleep -s 30
regedit.exe /S openvpn.reg
Get-Item -Path "C:\Users\Public\Desktop\OpenVPN GUI.lnk" | Remove-Item

#---Client Config---#
Write-Host Configuring Client Profile... -Foreground Yellow 
$COMPUTER = $env:computername
$OVPNFile = "kiosk-oregon.ovpn"
$WantFolder = "C:\Program Files\OpenVPN\config\"
$FolderExists = Test-Path $WantFolder
If ($FolderExists -eq "true") {Copy-Item $OVPNFile -Destination $WantFolder}
Else {Write-Host Config folder does not exist -Foreground Red }
$WantFile = "$wantFolder$File"
$FileExists = Test-Path $WantFile 
If ($FileExists -eq "true") {Write-Host OpenVpn Installed Successfully -Foreground Green}
Else {Write-Host OpenVPN Install Failed -Foreground Red}

#---Setup Service---#
Write-Host Setting up OpenVpn Service... -Foreground Yellow
$service = "OpenVPNService"
Set-Service -Name $service -StartupType Automatic
Write-Host Starting OpenVpn Service... -Foreground Yellow
Start-Service -Name $service

#---Confirm Service is running---#
$arrService = Get-Service -Name $service
 If ($arrService.Status -eq "Running"){Write-Host OpenVPNService is Running -Foreground Green}
 ElseIf ($arrService.Status -eq "Stopped"){Write-Host OpenVPNService is Stopped -Foreground Red}
Start-Sleep -s 15

#---Disable Firewall on OpenVpn Nic---#
Write-Host Disbaling Firewall on OpenVPN Connection Interface only -Foreground Yellow
Get-NetAdapter | Where-Object {$_.InterfaceDescription -like "TAP-Windows*"} | Rename-NetAdapter -NewName "OpenVPN Connection"
Set-NetFirewallProfile -Name Private,Domain,Public -DisabledInterfaceAliases "OpenVPN Connection"

#---VPN connection Info---#
Write-Host The following is the connected IP address. US IP range is 172.1.0.0-172.3.255.254 -Foreground Yellow
$ipaddress = Get-NetIPAddress -IPAddress 172.* | ft -Property InterfaceAlias,IpAddress -AutoSize
$ipaddress

#---Test Ireland Connection---#
Write-Host Testing Ireland Connection -Foreground Yellow
$DC01 = (nslookup Tillkiosk-dc01.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
$DC02 = (nslookup Tillkiosk-dc02.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
$SCCM01 = (nslookup Kiosk-sccm01.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
Write-Host Tillkiosk-dc01.tillsterkiosk.com $DC01
Write-Host Tillkiosk-dc01.tillsterkiosk.com $DC02
Write-Host Kiosk-sccm01.tillsterkiosk.com $SCCM01
If ($DC01 -eq "Address:  10.90.2.214") {Write-Host Connection to Oregon was Successful -Foreground Green}
Else {Write-Host Connection to Oregon Failed -Foreground Red}

