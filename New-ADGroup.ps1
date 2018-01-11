$Path= "OU=Security Groups,DC=qa,DC=tillsterkiosk,DC=com"
New-ADGroup -Name "LSG-Kiosk Local Admins" -GroupCategory Security -GroupScope Global -DisplayName "LSG-Kiosk Local Admins" -Path $Path
New-ADGroup -Name "LSG-Kiosk Users" -GroupCategory Security -GroupScope Global -DisplayName "LSG-Kiosk Users" -Path $Path
New-ADGroup -Name "LSG-SCCM Local Admins" -GroupCategory Security -GroupScope Global -DisplayName "LSG-SCCM Local Admins" -Path $Path
New-ADGroup -Name "LSG-Server Local Admins" -GroupCategory Security -GroupScope Global -DisplayName "LSG-Server Local Admins" -Path $Path
