#Load Configuration Manager PowerShell Module
Import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')

#Get SiteCode
$SiteCode = Get-PSDrive -PSProvider TK1
Set-location $SiteCode":"

#Error Handling and output
Clear-Host
$ErrorActionPreference= 'SilentlyContinue'
$Error1 = 0

#Refresh Schedules
$ScheduleServers = New-CMSchedule –RecurInterval Days –RecurCount 7
$ScheduleKiosks = New-CMSchedule –RecurInterval Days –RecurCount 1

#Create Default limiting collections
$LimitingCollection = "All Systems"
$LimitingCollectionSCCM = "SRV - Software - SCCM"
$LimitingCollectionDC = "SRV - Software - ADFS"
$LimitingCollectionServers = "All Servers"
$LimitingCollectionkiosks = "All Kiosks"

#Create Folders and Structure
New-Item -Name 'Kiosks' -Path ".\DeviceCollection\"
New-Item -Name 'KSK - Inventory' -Path ".\DeviceCollection\Kiosks\"
New-Item -Name 'KSK - Hardware' -Path ".\DeviceCollection\Kiosks\KSK - Inventory\"
New-Item -Name 'KSK - Operating System' -Path ".\DeviceCollection\Kiosks\KSK - Inventory\"
New-Item -Name 'KSK - Software' -Path ".\DeviceCollection\Kiosks\KSK - Inventory\"
New-Item -Name 'KSK - OS Deployments' -Path ".\DeviceCollection\Kiosks\"
New-Item -Name 'KSK - Software Distribution' -Path ".\DeviceCollection\Kiosks\"
New-Item -Name 'KSK - Software Updates' -Path ".\DeviceCollection\Kiosks\"
New-Item -Name 'KSK - Windows Updates' -Path ".\DeviceCollection\Kiosks\"
New-Item -Name 'KSK - Windows 10 Updates' -Path ".\DeviceCollection\Kiosks\KSK - Windows Updates\"
New-Item -Name 'KSK - Windows 8.1 Updates' -Path ".\DeviceCollection\Kiosks\KSK - Windows Updates\"
New-Item -Name 'Master Collection' -Path ".\DeviceCollection\"
New-Item -Name 'MC - Client Settings' -Path ".\DeviceCollection\Master Collection\"
New-Item -Name 'MC - Endpoint Protection' -Path ".\DeviceCollection\Master Collection\"
New-Item -Name 'Servers' -Path ".\DeviceCollection\"
New-Item -Name 'SRV - Inventory' -Path ".\DeviceCollection\Servers\"
New-Item -Name 'SRV - Hardware' -Path ".\DeviceCollection\Servers\SRV - Inventory\"
New-Item -Name 'SRV - Operating System' -Path ".\DeviceCollection\Servers\SRV - Inventory\"
New-Item -Name 'SRV - Software' -Path ".\DeviceCollection\Servers\SRV - Inventory\"
New-Item -Name 'SRV - Software Distribution' -Path ".\DeviceCollection\Servers\"
New-Item -Name 'SRV - Software Update' -Path ".\DeviceCollection\Servers\"
New-Item -Name 'SRV - Windows Update' -Path ".\DeviceCollection\Servers\"
New-Item -Name 'SRV - Windows 2016 Updates' -Path ".\DeviceCollection\Servers\SRV - Windows Update\"

#QUERIES
#Servers
$Collection1 = @{Name = "Physical"; Query = "select SMS_R_System.ResourceId, SMS_R_System.ResourceType, SMS_R_System.Name, SMS_R_System.SMSUniqueIdentifier, SMS_R_System.ResourceDomainORWorkgroup, SMS_R_System.Client from  SMS_R_System where SMS_R_System.IsVirtualMachine = "False""}
$Collection2 = @{Name = "Virtual"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.VirtualMachineType = 0"}
#SRV - OS
$Collection3 = @{Name = "Windows 2016"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where OperatingSystemNameandVersion like '%Server 10%'"}
#SRV - Software
$Collection4 = @{Name = "SCCM"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.SystemOUName = "DEV.TILLSTERKIOSK.COM/SERVERS/SCCM""}
$Collection5 = @{Name = "ADFS - DEV"; Query = "select *  from  SMS_R_System where SMS_R_System.SystemOUName = "DEV.TILLSTERKIOSK.COM/DOMAIN CONTROLLERS""}
$Collection6 = @{Name = "ADFS - QA"; Query = "select *  from  SMS_R_System where SMS_R_System.SystemOUName = "DOMAIN CONTROLLERS""}
$Collection7 = @{Name = "SQL"; Query = "select *  from  SMS_R_System inner join SMS_G_System_ADD_REMOVE_PROGRAMS on SMS_G_System_ADD_REMOVE_PROGRAMS.ResourceId = SMS_R_System.ResourceId where SMS_G_System_ADD_REMOVE_PROGRAMS.DisplayName like "%Microsoft SQL Server%""}
#SRV - Windows 2016 Updates
$Collection8 = @{Name = " Server 2016"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.OperatingSystemNameandVersion = "Microsoft Windows NT Server 10.0""}
$Collection9 = @{Name = "Server 2016"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.OperatingSystemNameandVersion = "Microsoft Windows NT Server 10.0""}
#Master Collections
$Collection10 = @{Name = "All Kiosks"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where OperatingSystemNameandVersion like '%Workstation%'"}
$Collection11 = @{Name = "All Servers"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where OperatingSystemNameandVersion like '%Server%'"}
#Master Collections | MC - Client Versions
$Collection12 = @{Name = "MC - INV - Clients Version | Current"; Query = "select SMS_R_System.ResourceId, SMS_R_System.ResourceType, SMS_R_System.Name, SMS_R_System.SMSUniqueIdentifier, SMS_R_System.ResourceDomainORWorkgroup, SMS_R_System.Client from  SMS_R_System where SMS_R_System.ClientVersion = "5.00.8634.1010""}
$Collection13= @{Name = "MC - INV - Clients Version | Outdated"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.ClientVersion != "5.00.8634.1010""}

#CREATE COLLECTIONS
New-CMDeviceCollection -Name "SRV - INV - Physical" -Comment "Filtered by: Virtual Machine - False" -LimitingCollectionName $LimitingCollectionServers -RefreshSchedule $ScheduleServers -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "SRV - INV - Physical" -QueryExpression $Collection1.Query -RuleName $Collection1.Name
Write-host *** Collection "SRV - INV - Physical" created ***

New-CMDeviceCollection -Name "SRV - INV - Virtual" -Comment "Filered by: Virtual Machine Type = 0" -LimitingCollectionName $LimitingCollectionServers -RefreshSchedule $ScheduleServers -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "SRV - INV - Virtual" -QueryExpression $Collection2.Query -RuleName $Collection2.Name
Write-host *** Collection "SRV - INV - Virtual" created ***

New-CMDeviceCollection -Name "SRV - INV - Windows 2016" -Comment "All servers with Windows 2016" -LimitingCollectionName $LimitingCollectionServers -RefreshSchedule $ScheduleServers -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "SRV - INV - Windows 2016" -QueryExpression $Collection3.Query -RuleName $Collection3.Name
Write-host *** Collection "SRV - INV - Windows 2016" created ***

New-CMDeviceCollection -Name "SRV - Software - SCCM" -Comment "Filtered by: SCCM OU" -LimitingCollectionName $LimitingCollectionServers -RefreshSchedule $ScheduleServers -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "SRV - Software - SCCM" -QueryExpression $Collection4.Query -RuleName $Collection4.Name
Write-host *** Collection "SRV - Software - SCCM" created ***

New-CMDeviceCollection -Name "SRV - Software - ADFS" -Comment "Filtered by: Domain Controllers OU" -LimitingCollectionName $LimitingCollectionServers -RefreshSchedule $ScheduleServers -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "SRV - Software - ADFS" -QueryExpression $Collection5.Query -RuleName $Collection5.Name
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "SRV - Software - ADFS" -QueryExpression $Collection6.Query -RuleName $Collection6.Name
Write-host *** Collection "SRV - Software - ADFS" created ***

New-CMDeviceCollection -Name "SRV - Software - SQL" -Comment "Filtered by: Installed Software - SQL" -LimitingCollectionName $LimitingCollectionServers -RefreshSchedule $ScheduleServers -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "SRV - Software - SQL" -QueryExpression $Collection7.Query -RuleName $Collection7.Name
Write-host *** Collection "SRV - Software - SQL" created ***

New-CMDeviceCollection -Name "Windows Updates - DC Server 2016" -Comment "Filteredby: Windows NT Server 10.0" -LimitingCollectionName $LimitingCollectionDC -RefreshSchedule $ScheduleServers -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Windows Updates - DC Server 2016" -QueryExpression $Collection8.Query -RuleName $Collection8.Name
Write-host *** Collection "Windows Updates - DC Server 2016" created ***

New-CMDeviceCollection -Name "Windows Updates - Server 2016" -Comment "Filtered by: Windows NT Server 10.0" -LimitingCollectionName $LimitingCollectionServers -RefreshSchedule $ScheduleServers -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Windows Updates - Server 2016" -QueryExpression $Collection9.Query -RuleName $Collection9.Name
Add-CMDeviceCollectionQueryMembershipRule -CollectionName "Windows Updates - Server 2016" -ExcludeCollectionName "SRV - Software - SCCM"
Write-host *** Collection "Windows Updates - Server 2016" created ***

New-CMDeviceCollection -Name $Collection10.Name -Comment "All Kiosks" -LimitingCollectionName $LimitingCollection -RefreshSchedule $ScheduleKiosks -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection10.Name -QueryExpression $Collection10.Query -RuleName $Collection10.Name
Write-host *** Collection $Collection10.Name created ***

New-CMDeviceCollection -Name $Collection11.Name -Comment "All Servers" -LimitingCollectionName $LimitingCollection -RefreshSchedule $ScheduleServers -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection11.Name -QueryExpression $Collection11.Query -RuleName $Collection11.Name
Write-host *** Collection $Collection11.Name created ***

New-CMDeviceCollection -Name $Collection12.Name -Comment "SCCM client version 5.00.8634.1010" -LimitingCollectionName $LimitingCollection -RefreshSchedule $ScheduleKiosks -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection12.Name -QueryExpression $Collection12.Query -RuleName $Collection12.Name
Write-host *** Collection $Collection12.Name created ***

New-CMDeviceCollection -Name $Collection13.Name -Comment "Older SCCM client versions" -LimitingCollectionName $LimitingCollection -RefreshSchedule $ScheduleKiosks -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection13.Name -QueryExpression $Collection13.Query -RuleName $Collection13.Name
Write-host *** Collection $Collection13.Name created ***