#---Created 12-13-17---#
#---C Newell---#

#---Run Powershell as Admin---#
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#---Import Trusted OPENVPN Cert---#
$Certificate = "openvpn.pfx"
$CertLocation = "Cert:\LOCALMACHINE\TrustedPublisher"
Write-Host Importing OpenVpn Trusted Certificate... -Foreground Yellow
Import-Certificate -FilePath $Certificate -CertStoreLocation $CertLocation

#---Install App---#
write-host "`n"
Write-Host Starting OpenVpn Install... -Foreground Yellow
Start-Process -Filepath openvpn-install-2.4.4-I601.exe /S
write-host "`n"
Write-Host Waiting 30s... -Foreground Yellow
Start-Sleep -s 30
regedit.exe /S openvpn.reg
Get-Item -Path C:\Users\Public\Desktop\"OpenVPN GUI.lnk" | Remove-Item

#---Disable Firewall on OpenVpn Nic---#
write-host "`n"
Write-Host Renaming nic and setting firewall rule -Foreground Yellow
Get-NetAdapter | Where-Object {$_.InterfaceDescription -like "TAP-Windows*"} | Rename-NetAdapter -NewName "OpenVPN Connection"
Set-NetFirewallProfile -Name Private,Domain,Public -DisabledInterfaceAliases "OpenVPN Connection"
write-host "`n"
Write-Host Installation Completed -Foreground Green
write-host "`n"
write-host "`n"
Write-Host Running Confirm-OpenVPN script...
& .\Confirm-OpenVPN.ps1
