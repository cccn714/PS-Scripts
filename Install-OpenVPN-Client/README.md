# Install-OpenVPN_Full.ps1
PS script to install OpenVPN client on Kiosks and Test Connections. 

This script will: 
- checks if Powershell is running as Admin if not runs as Admin in a new windows
- set the working directory to C:\Install-OpenVpn
- import the openvpn trusted cert for TAP-Windows install
- install openvpn client in silent mode
- copy the client profile to C:\Program Files\OpenVPN\config\ to allow for "running as a Service"
- confirm install and file copy and report
- setup OPENVPNSERVICE to "auto" start
- start the OPENVPNSERVICE
- confirm service as started and report
- Renames the TAP-Windows nic to OpenVPN Connection and disables the Firewall on ONLY this Nic
- Removes OpenVPN icon from users desktop
- test vpn connectivity to AWS via ping and report

# Install-OpenVPN_Basic.ps1
PS script to ONLY install OpenVPN this should be used on base images getting prep'd for deployment. No profiles are setup at this time.

This script will: 
- checks if Powershell is running as Admin if not runs as Admin in a new windows
- set the working directory to C:\Install-OpenVpn
- import the openvpn trusted cert for TAP-Windows install
- install openvpn client in silent mode
- Renames the TAP-Windows nic to "OpenVPN Connection" and disables the Firewall on ONLY this Nic
- Removes OpenVPN icon from users desktop


# Config-OpenVPN.ps1
PS script to ONLY configure OpenVPN this should be used on systems that have been prep'd with the Install-OpenVPN_Basic previously.

This script will: 
- checks if Powershell is running as Admin if not runs as Admin in a new windows
- set the working directory to C:\Install-OpenVpn
- copy the client profile to C:\Program Files\OpenVPN\config\ to allow for "running as a Service"
- confirm install and file copy and report
- setup OPENVPNSERVICE to "auto"
- start the OPENVPNSERVICE
- confirm service as started and report
- test vpn connectivity to AWS via ping and report


All files must be put in a common ROOT folder of "C:\Install-OpenVPN" for script to function. Install-OpenVpn_Full.ps1, Install-OpenVPN_Basic.ps1 and Config-OpenVPN.ps1 must be run from this ROOT location. 

# File Notes
1. AwsServers.txt - Text file of AWS server IP's. These IP's will be checked via Test-Connection for a Successful/Failed PING. Could be changed to DNS names if preferred.

2. Powershell scripts must be run as Admin. Could be copied to a remote host and run through PSSESSION or Invoke-Command. This runs the openvpn install .exe in silent mode with the default options.
- Install-OpenVpn_Full.ps1
- Install-OpenVpn_Basic.ps1
- Config-OpenVpn.ps1
- Confirm-OpenVPN.ps1

3. computername.ovpn - Client Profile file. Every client needs unique file so the filename will reflect the computername. The Install-OpenVpn.ps1 fill looks for the file by grabbing the host name via $env:computername and appending .opvn. If doing testing this file name will need to be manually changed to reflect the computername before running Install-OpenVpn.ps1.

4. openvpn.pfx - OpenVPN Trusted Publishers Certificate. This is needed for the TAP-Windows drive install. This will be installed into the Cert:\LOCALMACHINE\TrustedPublisher Store during the install.

5. openvpn-install-2.4.4-I601.exe - Install file. The latest versions can be found here. https://openvpn.net/index.php/open-source/downloads.html. Install-OpenVpn.ps1 looks for the file under the ROOT folder, is latest version is used and naming of file is different than changes are need in the script - line 13

6. OpenVpn.reg - registry change to setup silent notification

7. Install-OpenVPN.zip - install package to be extracted to C:\ on a system