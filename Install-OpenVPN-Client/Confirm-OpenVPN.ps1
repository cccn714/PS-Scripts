#---Created 12-13-17---#
#---C Newell---#

#---Run Powershell as Admin---#
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#---Set Location of ROOT Folder---#
Set-Location -Path "C:\Install-Openvpn"

#---Confirm Trusted OPENVPN Cert---#
Write-Host Confirming certificate is installed -Foreground Yellow
$CertExists = Get-ChildItem -Path Cert:\LOCALMACHINE\TrustedPublisher\5E66E0CA2367757E800E65B770629026E131A7DC | Test-Path
If ($CertExists -eq "True"){Write-Host Certificate installed Successfully -Foreground Green}
ElseIf ($CertExists -eq "False") {Write-Host Certificate not installed Successfully -Foreground Red}
Else {Write-Host Bad Command lines 11-13 -Foreground Red}

#---Confirm Install---#
write-host "`n"
Write-Host Confirming OpenVPN folder structure -Foreground Yellow
$WantFile = "C:\Program Files\OpenVPN\bin\openvpn.exe"
$FileExists = Test-Path $WantFile
If ($FileExists -eq "True") {Write-Host Install Confirmed -Foreground Green}
ElseIf ($FileExists -eq "False") {Write-Host Install Failed -Foreground Red}
Else {Write-Host Bad Command lines 17-18 -Foreground Red}

#---Confirm Service is installed---#
write-host "`n"
Write-Host Confirming OpenVPNService is installed -Foreground Yellow
$service = "OpenVPNService"
$arrService = Get-Service -Name $service
If ($arrService.Name -eq "OpenVPNService"){Write-Host OpenVPNService is installed -Foreground Green}
Else {Write-Host OpenVPNService is not installed -Foreground Red}

#---Confirm TAP-Windows Nic and Firewall---#
write-host "`n"
Write-Host Confirming TAP-Windows nic installation and presenting firewall configuration -Foreground Yellow
If (Get-NetAdapter -InterfaceDescription "TAP-Windows*") {Write-Host Nic install confirmed -Foreground green}
Else {Write-Host TAP-Windows nic not installed -Foreground Red}
If (Get-NetAdapter -Name "OpenVPN Connection") {Write-Host Nic rename confirmed -Foreground Green}
Else {Write-Host Nic rename failed -Foreground Red}
$Firewall = Get-NetFirewallProfile | ft -Property Name,DisabledInterfaceAliases -AutoSize
$Firewall
write-host "`n"
Write-Host Confirm completed if there are no red items install was successful -Foreground Green
