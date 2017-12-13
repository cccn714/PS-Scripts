#---Import Trusted Cert---#
Write-Host Importing OpenVpn certificate... -Foreground Yellow
Import-Certificate -FilePath openvpn.pfx -CertStoreLocation Cert:\LOCALMACHINE\TrustedPublisher

#---Install App---#
Write-Host Starting OpenVpn Insatll... -Foreground Yellow
Start-Process -Filepath openvpn-install-2.4.4-I601.exe /S
Write-Host Waiting for OpenVpn Insatll to Complete... -Foreground Yellow
Start-Sleep -s 30

#---Client Config---#
$WantFolder = "C:\Program Files\OpenVPN\config"
$FolderExists = Test-Path $WantFolder
If ($FolderExists -eq "true") {Copy-Item "kiosk-openvpn-test2.ovpn" -Destination "C:\Program Files\OpenVPN\config"}
Else {write-host Config folder does not exist -Foreground Red}
$WantFile = "C:\Program Files\OpenVPN\config\kiosk-openvpn-test2.ovpn" 
$FileExists = Test-Path $WantFile 
If ($FileExists -eq "true") {Write-Host OpenVpn Install Complete... -Foreground Green}
Else {write-host OpenVPN Install Failed -Foreground Red}

#---Setup Service---#
Write-Host Setting up OpenVpn Service... -Foreground Yellow
$service = "OpenVPNService"
Set-Service -Name $service -StartupType Automatic
Write-Host Starting OpenVpn Service... -Foreground Yellow
Start-Service -Name $service
$arrService = Get-Service -Name $service

#---Check Service---#
 If ($arrService.Status -eq "Running"){ 
 Write-Host OpenVPNService is Running -ForegroundColor Green
 }
 ElseIf ($arrService.Status -eq "Stopped"){ 
 Write-Host OpenVPNService is stopped -ForegroundColor Red
 }
Start-Sleep -s 15

#---VPN connection test---#
Write-Host Testing VPN Connection to AWS... -Foreground Yellow
$vpntest = Test-Connection -ComputerName (Get-Content "AwsServers.txt") -AsJob
if ($vpntest.JobStateInfo.State -ne "Completed") 
{$Results = Write-Host Successfull Ping to (Get-Content "AwsServers.txt") -Foreground Green}
if ($vpntest.JobStateInfo.State -ne "Running") {$Results = Write-Host Successfull Ping Check VPN Install -ForegroundColor Red}
$Results
