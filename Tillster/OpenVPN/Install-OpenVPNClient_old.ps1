#---Created 12-13-17---#
#---C Newell---#
# Current openvpn client version is 2.4.4-I601 if client is updated change line 28 to reflect new version #

#---Run Powershell as Admin---#
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#---Copy CMTrace---#
Copy-Item "C:\SCCM_DeployPackage\Tools\cmtrace.exe" -Destination "C:\Windows\System32"
$CMTraceFile = Test-Path "C:\Windows\System32\cmtrace.exe"
If ($CMTraceFile -eq "true"){Write-Host CMtrace.exe is in the System32 folder}
If ($CMTraceFile -eq "false"){Write-Host CMtrace.exe is not in the System32 folder. Manually copy the file}
#---Set Location of Install Folder---#
Set-Location -Path "C:\SCCM_DeployPackage\OpenVPN_Client"

#---Import Trusted OPENVPN Cert---#
$Certificate = "openvpn.pfx"
$CertLocation = "Cert:\LOCALMACHINE\TrustedPublisher"
Write-Host Importing OpenVpn Trusted Certificate
Import-Certificate -FilePath $Certificate -CertStoreLocation $CertLocation

#---Confirm Certificate Import---#
$CertExists = Get-ChildItem -Path Cert:\LOCALMACHINE\TrustedPublisher\5E66E0CA2367757E800E65B770629026E131A7DC | Test-Path
If ($CertExists -eq "true"){Write-Host Certificate installed successfully}
If ($CertExists -eq "false"){Write-Host Certificate not installed successfully. Manually install the cert}

#---Install Application---#
Write-Host Starting OpenVpn Install
Start-Process -Filepath openvpn-install-2.4.4-I601.exe /S
Start-Sleep -s 30
regedit.exe /S openvpn.reg

#---Private Key Install---#
Write-Host Installing OpenVPN Private Key
$location = "SD-Colo"
$OVPNFile = "C:\SCCM_DeployPackage\OpenVPN_Client\$location\*.ovpn"
$WantFolder = "C:\Program Files\OpenVPN\config\"
$FolderExists = Test-Path $WantFolder
If ($FolderExists -eq "true") {Copy-Item $OVPNFile -Destination $WantFolder}
Else {Write-Host Error C:\Program Files\OpenVPN\config\ folder does not exist. Reinstall client}
$WantFile = "$WantFolder$OVPNFile"
$FileExists = Test-Path $WantFile 
If ($FileExists -eq "true"){Write-Host OpenVpn installed successfully}
If ($FileExists -eq "false"){Write-Host OpenVPN install failed}
Get-Item -Path "C:\Users\Public\Desktop\OpenVPN GUI.lnk" | Remove-Item

#---Setup Service---#
Write-Host Setting up OpenVpn Service
$service = "OpenVPNService"
Set-Service -Name $service -StartupType Automatic
Write-Host Starting OpenVpn Service
Start-Service -Name $service

#---Confirm Service is running---#
$arrService = Get-Service -Name $service
If ($arrService.Status -eq "Running"){Write-Host OpenVPNService is Running}
If ($arrService.Status -eq "Stopped"){Write-Host OpenVPNService did not Start. Manually Start or troubleshoot the service}
Start-Sleep -s 15

#---Disable Firewall on OpenVpn Nic---#
Write-Host Disabling Firewall on OpenVPN Connection Interface only
Get-NetAdapter | Where-Object {$_.InterfaceDescription -like "TAP-Windows*"} | Rename-NetAdapter -NewName "OpenVPN Connection"
Set-NetFirewallProfile -Name Private,Domain,Public -DisabledInterfaceAliases "OpenVPN Connection"

#---Call VPN Connection Test Scripts---#
$ipaddress = Get-NetIPAddress -IPAddress 172.* | ft -Property InterfaceAlias,IpAddress -AutoSize
$ipaddress
If ($ipaddress -contains "172.1" -or $ipaddress -contains "172.2" -or $ipaddress -contains "172.3") 
{Write-Host Testing Oregon Connection
$DC01 = (nslookup Tillkiosk-dc01.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
$DC02 = (nslookup Tillkiosk-dc02.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
$SCCM01 = (nslookup Kiosk-sccm01.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
Write-Host Tillkiosk-dc01.tillsterkiosk.com $DC01
Write-Host Tillkiosk-dc01.tillsterkiosk.com $DC02
Write-Host Kiosk-sccm01.tillsterkiosk.com $SCCM01
If ($DC01 -eq "Address:  10.90.2.214") {Write-Host Connection to Oregon was successful}
IF ($DC01 -ne "Address:  10.90.2.214") {Write-Host Connection to Oregon failed}
}
If ($ipaddress -contains "172.11" -or $ipaddress -contains "172.12" -or $ipaddress -contains "172.13") 
{Write-Host Testing Ireland Connection
$DC03 = (nslookup Tillkiosk-dc03.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
$DC04 = (nslookup Tillkiosk-dc04.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
$SCCM02 = (nslookup Kiosk-sccm02.tillsterkiosk.com | Select-String Address | Where-Object LineNumber -eq 5).ToString()
Write-Host Tillkiosk-dc03.tillsterkiosk.com $DC03
Write-Host Tillkiosk-dc04.tillsterkiosk.com $DC04
Write-Host Kiosk-sccm02.tillsterkiosk.com $SCCM02
If ($DC03 -eq "Address:  10.99.2.119") {Write-Host Connection to Ireland was successful}
IF ($DC03 -ne "Address:  10.99.2.119") {Write-Host Connection to Ireland failed}
}
Else {Write-Host No valid VPN IP configured}