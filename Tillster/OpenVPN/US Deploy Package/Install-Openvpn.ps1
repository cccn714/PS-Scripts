#--Created on 02-28-18--#
#--by C Newell--#
#---Extract OpenVPN Client Folder---#
Write-Host Extracting openvpn client.zip to C: drive -Foreground Yellow
Add-Type -AssemblyName System.IO.Compression.FileSystem
function unzip {
    param( [string]$ziparchive, [string]$extractpath )
    [System.IO.Compression.ZipFile]::ExtractToDirectory( $ziparchive, $extractpath )
}
unzip "C:\Uploads\US Deploy\OpenVPN Client.zip" "C:\OpenVPN Client"
cd "C:\openvpn client"

#---Call Install-OpenVpnClient.ps1---#
Write-Host Install OpenVPN Client -Foreground Yellow
./Install-OpenVpnClient.ps1
