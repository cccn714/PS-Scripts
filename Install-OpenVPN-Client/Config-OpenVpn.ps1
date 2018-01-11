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

#---Confirm Service is running---#
$arrService = Get-Service -Name $service
 If ($arrService.Status -eq "Running"){LogWrite "OpenVPNService is Running"}
 ElseIf ($arrService.Status -eq "Stopped"){LogWrite "OpenVPNService is stopped"}
Start-Sleep -s 15

#---VPN connection test---#
Write-Host Testing VPN Connection to AWS... -Foreground Yellow
$vpntest = Test-Connection -ComputerName (Get-Content "AwsServers.txt") -AsJob
if ($vpntest.JobStateInfo.State -ne "Completed") {LogWrite "Successfull Ping to AWS Servers"}
if ($vpntest.JobStateInfo.State -ne "Running") {LogWrite "Unsuccessfull Ping to AWS Servers. Check VPN Install"}