#---Extract Deploy and OpenVPN Client Folders---#
#Write-Host Extracting openvpn client.zip to C: drive -Foreground Yellow
Add-Type -AssemblyName System.IO.Compression.FileSystem
function unzip {
    param( [string]$ziparchive, [string]$extractpath )
    [System.IO.Compression.ZipFile]::ExtractToDirectory( $ziparchive, $extractpath )
}
$location = "SD-Colo"
unzip "C:\LMI_DistributedFiles\SCCM_DeployPackage.zip" "C:\"
unzip "C:\LMI_DistributedFiles\$location.zip" "C:\SCCM_DeployPackage\OpenVPN_Client"
cd "C:\SCCM_DeployPackage"

#---Call Install-OpenVpnClient.ps1---#
#Write-Host Install OpenVPN Client -Foreground Yellow
powershell "C:\SCCM_DeployPackage\OpenVPN_Client\Install-OpenVpnClient.ps1"
