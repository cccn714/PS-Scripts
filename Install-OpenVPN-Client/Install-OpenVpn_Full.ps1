#---Created 12-13-17---#
#---C Newell---#

#---Run Powershell as Admin---#
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }
#---Log File---#
$Logfile = "C:\Install-openvpn\$(gc env:computername).log"
Function LogWrite
{
   Param ([string]$logstring)
   Add-content $Logfile -value $logstring
}

#---Set Location of ROOT Folder---#
Set-Location -Path "C:\Install-Openvpn"

#---Import Trusted OPENVPN Cert---#
$Certificate = "openvpn.pfx"
$CertLocation = "Cert:\LOCALMACHINE\TrustedPublisher"
Write-Host Importing OpenVpn Trusted Certificate... -Foreground Yellow
Import-Certificate -FilePath $Certificate -CertStoreLocation $CertLocation
$CertExists = Get-ChildItem -Path Cert:\LOCALMACHINE\TrustedPublisher\5E66E0CA2367757E800E65B770629026E131A7DC | Test-Path
If ($CertExists -eq "true"){LogWrite "Certificate installed Successfully"}
ElseIf ($CertExists -eq "false") {LogWrite "Certificate not installed Successfully"}
Else {LogWrite "There was an issue with the certificate installation path"}

#---Install App---#
Write-Host Starting OpenVpn Install... -Foreground Yellow
Start-Process -Filepath openvpn-install-2.4.4-I601.exe /S
Write-Host Waiting 30s for OpenVpn Install to Complete... -Foreground Yellow
Start-Sleep -s 30
regedit.exe /S openvpn.reg
Get-Item -Path C:\Users\Public\Desktop\"OpenVPN GUI.lnk" | Remove-Item

#---Client Config---#
Write-Host Configuring Client Profile... -Foreground Yellow 
$COMPUTER = $env:computername
$OVPNFile = "$COMPUTER.ovpn"
$WantFolder = "C:\Program Files\OpenVPN\config\"
$FolderExists = Test-Path $WantFolder
If ($FolderExists -eq "true") {Copy-Item $OVPNFile -Destination $WantFolder}
Else {LogWrite "Config folder does not exist" }
$WantFile = "$wantFolder$File"
$FileExists = Test-Path $WantFile 
If ($FileExists -eq "true") {LogWrite "OpenVpn Install Successful..."}
Else {LogWrite "OpenVPN Install Failed." -Foreground Red}

#---Setup Service---#
Write-Host Setting up OpenVpn Service... -Foreground Yellow
$service = "OpenVPNService"
Set-Service -Name $service -StartupType Automatic
Write-Host Starting OpenVpn Service... -Foreground Yellow
Start-Service -Name $service

#---Confirm Service is running---#
$arrService = Get-Service -Name $service
 If ($arrService.Status -eq "Running"){LogWrite "OpenVPNService is Running"}
 ElseIf ($arrService.Status -eq "Stopped"){LogWrite "OpenVPNService is stopped"}
Start-Sleep -s 15

#---Disable Firewall on OpenVpn Nic---#
Get-NetAdapter | Where-Object {$_.InterfaceDescription -like "TAP-Windows*"} | Rename-NetAdapter -NewName "OpenVPN Connection"
Set-NetFirewallProfile -Name Private,Domain,Public -DisabledInterfaceAliases "OpenVPN Connection"

#---VPN connection test---#
Write-Host Testing VPN Connection to AWS... -Foreground Yellow
$vpntest = Test-Connection -ComputerName (Get-Content "AwsServers.txt") -AsJob
if ($vpntest.JobStateInfo.State -ne "Completed") {LogWrite "Successfull Ping to AWS Servers"}
if ($vpntest.JobStateInfo.State -ne "Running") {LogWrite "Unsuccessfull Ping to AWS Servers. Check VPN Install"}