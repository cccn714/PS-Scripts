﻿#############################################################################
# Author  : Jonathan Lefebvre-Globensky
# Website : www.SystemCenterDudes.com
# Twitter : @jlefebvregloben, @SCDudes
#
# Version : 1.0
# Created : 2018/01/15
# Modified : 2018/03/03 - cnewell
#
# Purpose : This script create a structure of folders to classify collections based on the purpose and define a naming convention. Basic collections are also created at the same time
# Blog post related : https://www.systemcenterdudes.com/powershell-script-create-set-maintenance-collections
# Want more default operationnal collection? See Benoit Lecours powershell script --> https://gallery.technet.microsoft.com/Set-of-Operational-SCCM-19fa8178
#
#############################################################################

#Load Configuration Manager PowerShell Module
Import-module ($Env:SMS_ADMIN_UI_PATH.Substring(0,$Env:SMS_ADMIN_UI_PATH.Length-5) + '\ConfigurationManager.psd1')

#Get SiteCode
$SiteCode = Get-PSDrive -PSProvider CMSite
Set-location $SiteCode":"

#Create Default Folders
new-item -Name 'Master Collections' -Path $($SiteCode.Name+":\DeviceCollection")
new-item -Name 'MC - Client Settings' -Path $($SiteCode.Name+":\DeviceCollection\Master Collections")
new-item -Name 'MC - Endpoint Protection' -Path $($SiteCode.Name+":\DeviceCollection\Master Collections")
new-item -Name 'Kiosks' -Path $($SiteCode.Name+":\DeviceCollection")
new-item -Name 'KSK - Inventory' -Path $($SiteCode.Name+":\DeviceCollection\Kiosks")
new-item -Name 'KSK - Operating System' -Path $($SiteCode.Name+":\DeviceCollection\Kiosks\KSK - Inventory")
new-item -Name 'KSK - Software' -Path $($SiteCode.Name+":\DeviceCollection\Kiosks\KSK - Inventory")
new-item -Name 'KSK - Hardware' -Path $($SiteCode.Name+":\DeviceCollection\Kiosks\KSK - Inventory")
new-item -Name 'KSK - Software Update' -Path $($SiteCode.Name+":\DeviceCollection\Kiosks")
new-item -Name 'KSK - Software Distribution' -Path $($SiteCode.Name+":\DeviceCollection\Kiosks")
new-item -Name 'KSK - OS deployment' -Path $($SiteCode.Name+":\DeviceCollection\Kiosks")
new-item -Name 'Servers' -Path $($SiteCode.Name+":\DeviceCollection")
new-item -Name 'SRV - Inventory' -Path $($SiteCode.Name+":\DeviceCollection\Servers")
new-item -Name 'SRV - Operating System' -Path $($SiteCode.Name+":\DeviceCollection\Servers\SRV - Inventory")
new-item -Name 'SRV - Software' -Path $($SiteCode.Name+":\DeviceCollection\Servers\SRV - Inventory")
new-item -Name 'SRV - Hardware' -Path $($SiteCode.Name+":\DeviceCollection\Servers\SRV - Inventory")
new-item -Name 'SRV - Software Update' -Path $($SiteCode.Name+":\DeviceCollection\Servers")
new-item -Name 'SRV - Software Distribution' -Path $($SiteCode.Name+":\DeviceCollection\Servers")

#Create Collections
#List of Collections Query
$Collection1 = @{Name = "All Servers"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where OperatingSystemNameandVersion like '%Server%'"}
$Collection2 = @{Name = "All Kiosks"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where OperatingSystemNameandVersion like '%Workstation%'"}
$Collection3 = @{Name = "All Kiosks - Admin"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where OperatingSystemNameandVersion like '%Workstation%'"}
#$Collection4 = @{Name = "MC - CS - Workstation Prod"; Query = ""}
#$Collection5 = @{Name = "MC - CS - Workstation Test"; Query = ""}
#$Collection6 = @{Name = "MC - CS - Server Prod"; Query = ""}
#$Collection7 = @{Name = "MC - CS - Server Test"; Query = ""}
#$Collection8 = @{Name = "MC - EP - Workstation Prod"; Query = ""}
#$Collection9 = @{Name = "MC - EP - Workstation Test"; Query = ""}
#$Collection10 = @{Name = "MC - EP - Server Prod"; Query = ""}
#$Collection11 = @{Name = "MC - EP - Server Test"; Query = ""}
$Collection12 = @{Name = "SRV - INV - Physical"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.ResourceId not in (select SMS_R_SYSTEM.ResourceID from SMS_R_System inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceId = SMS_R_System.ResourceId where SMS_R_System.IsVirtualMachine = 'True') and SMS_R_System.OperatingSystemNameandVersion like 'Microsoft Windows NT%Server%'"}
$Collection13 = @{Name = "SRV - INV - Virtual"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.IsVirtualMachine = 'True' and SMS_R_System.OperatingSystemNameandVersion like 'Microsoft Windows NT%Server%'"}
#$Collection14 = @{Name = "SRV - INV - Windows 2008 and 2008 R2"; Query = "select SMS_R_System.ResourceID,SMS_R_System.ResourceType,SMS_R_System.Name,SMS_R_System.SMSUniqueIdentifier,SMS_R_System.ResourceDomainORWorkgroup,SMS_R_System.Client from SMS_R_System where OperatingSystemNameandVersion like '%Server 6.0%' or OperatingSystemNameandVersion like '%Server 6.1%'"}
#$Collection15 = @{Name = "SRV - INV - Windows 2012 and 2012 R2"; Query = "select SMS_R_System.ResourceID,SMS_R_System.ResourceType,SMS_R_System.Name,SMS_R_System.SMSUniqueIdentifier,SMS_R_System.ResourceDomainORWorkgroup,SMS_R_System.Client from SMS_R_System where OperatingSystemNameandVersion like '%Server 6.2%' or OperatingSystemNameandVersion like '%Server 6.3%'"}
#$Collection16 = @{Name = "SRV - INV - Windows 2003 and 2003 R2"; Query = "select SMS_R_System.ResourceID,SMS_R_System.ResourceType,SMS_R_System.Name,SMS_R_System.SMSUniqueIdentifier,SMS_R_System.ResourceDomainORWorkgroup,SMS_R_System.Client from SMS_R_System where OperatingSystemNameandVersion like '%Server 5.2%'"}
$Collection17 = @{Name = "SRV - INV - Windows 2016"; Query = "select SMS_R_System.ResourceID,SMS_R_System.ResourceType,SMS_R_System.Name,SMS_R_System.SMSUniqueIdentifier,SMS_R_System.ResourceDomainORWorkgroup,SMS_R_System.Client from SMS_R_System where OperatingSystemNameandVersion like '%Server 10%'"}
#$Collection18 = @{Name = "KSK - INV - Windows 7"; Query = "select SMS_R_System.ResourceID,SMS_R_System.ResourceType,SMS_R_System.Name,SMS_R_System.SMSUniqueIdentifier,SMS_R_System.ResourceDomainORWorkgroup,SMS_R_System.Client from SMS_R_System where OperatingSystemNameandVersion like '%Workstation 6.1%'"}
$Collection19 = @{Name = "KSK - INV - Windows 8"; Query = "select SMS_R_System.ResourceID,SMS_R_System.ResourceType,SMS_R_System.Name,SMS_R_System.SMSUniqueIdentifier,SMS_R_System.ResourceDomainORWorkgroup,SMS_R_System.Client from SMS_R_System where OperatingSystemNameandVersion like '%Workstation 6.2%'"}
$Collection20 = @{Name = "KSK - INV - Windows 8.1"; Query = "select SMS_R_System.ResourceID,SMS_R_System.ResourceType,SMS_R_System.Name,SMS_R_System.SMSUniqueIdentifier,SMS_R_System.ResourceDomainORWorkgroup,SMS_R_System.Client from SMS_R_System where OperatingSystemNameandVersion like '%Workstation 6.3%'"}
#$Collection21 = @{Name = "KSK - INV - Windows XP"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System   where OperatingSystemNameandVersion like '%Workstation 5.1%' or OperatingSystemNameandVersion like '%Workstation 5.2%'"}
$Collection22 = @{Name = "KSK - INV - SCCM Console"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System inner join SMS_G_System_ADD_REMOVE_PROGRAMS on SMS_G_System_ADD_REMOVE_PROGRAMS.ResourceID = SMS_R_System.ResourceId where SMS_G_System_ADD_REMOVE_PROGRAMS.DisplayName like '%Configuration Manager Console%'"}
$Collection23 = @{Name = "MC - INV - Clients Version | 1115"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.ClientVersion = '5.00.8577.1115'"}
#$Collection24 = @{Name = "KSK - INV - Laptops | Dell"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceId = SMS_R_System.ResourceId where SMS_G_System_COMPUTER_SYSTEM.Manufacturer like '%Dell%'"}
#$Collection25 = @{Name = "KSK - INV - Laptops | Lenovo"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceId = SMS_R_System.ResourceId where SMS_G_System_COMPUTER_SYSTEM.Manufacturer like '%Lenovo%'"}
#$Collection26 = @{Name = "KSK - INV - Laptops | HP"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceId = SMS_R_System.ResourceId where SMS_G_System_COMPUTER_SYSTEM.Manufacturer like '%HP%' or SMS_G_System_COMPUTER_SYSTEM.Manufacturer like '%Hewlett-Packard%'"}
#$Collection27 = @{Name = "KSK - INV - Microsoft Surface 4"; Query = "select SMS_R_System.ResourceId, SMS_R_System.ResourceType, SMS_R_System.Name, SMS_R_System.SMSUniqueIdentifier, SMS_R_System.ResourceDomainORWorkgroup, SMS_R_System.Client from SMS_R_System inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceId = SMS_R_System.ResourceId where SMS_G_System_COMPUTER_SYSTEM.Model = 'Surface Pro 4'"}
$Collection28 = @{Name = "KSK - INV - Windows 10"; Query = "select SMS_R_System.ResourceID,SMS_R_System.ResourceType,SMS_R_System.Name,SMS_R_System.SMSUniqueIdentifier,SMS_R_System.ResourceDomainORWorkgroup,SMS_R_System.Client from SMS_R_System where OperatingSystemNameandVersion like '%Workstation 10.%'"}
#$Collection29 = @{Name = "KSK - OSD - Windows 10 - PROD";Query=""}
#$Collection30 = @{Name = "KSK - OSD - Windows 10 - TEST";Query=""}
#$Collection31 = @{Name = "KSK - SU - Exclusion";Query=""}
#$Collection32 = @{Name = "KSK - SU - Pilote";Query=""}
#$Collection33 = @{Name = "KSK - SU - TEST";Query=""}
#$Collection34 = @{Name = "KSK - SU - PROD";Query=""}
#$Collection35 = @{Name = "KSK - SD - Office 365 - PROD";Query=""}
#$Collection36 = @{Name = "KSK - SD - Office 365 - TEST";Query=""}
$Collection37 = @{Name = "KSK - INV - Physical"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.ResourceId not in (select SMS_R_SYSTEM.ResourceID from SMS_R_System inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceId = SMS_R_System.ResourceId where SMS_R_System.IsVirtualMachine = 'True') and SMS_R_System.OperatingSystemNameandVersion like '%Workstation%'"}
$Collection38 = @{Name = "KSK - INV - Virtual"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.IsVirtualMachine = 'True' and SMS_R_System.OperatingSystemNameandVersion like '%Workstation%'"}
$Collection39 = @{Name = "MC - INV - Clients Version | Outdated"; Query = "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System where SMS_R_System.ClientVersion != '5.00.8577.1115'"}

#Define possible limiting collections
$LimitingCollectionAll = "All Systems"
$LimitingCollectionAllWork = "All Kiosks"
$LimitingCollectionAllWorkAdmin = "All Kiosks - Admin"
$LimitingCollectionAllServer = "All Servers"

#Refresh Schedule
$Schedule = New-CMSchedule –RecurInterval Days –RecurCount 1

#Create Collection
#try{
New-CMDeviceCollection -Name $Collection1.Name -Comment "All Servers" -LimitingCollectionName $LimitingCollectionAll -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection1.Name -QueryExpression $Collection1.Query -RuleName $Collection1.Name
Write-host *** Collection $Collection1.Name created ***

New-CMDeviceCollection -Name $Collection2.Name -Comment "All Kiosks" -LimitingCollectionName $LimitingCollectionAll -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection2.Name -QueryExpression $Collection2.Query -RuleName $Collection2.Name
Write-host *** Collection $Collection2.Name created ***

New-CMDeviceCollection -Name $Collection3.Name -Comment "All Kiosks Admin, to hide from technician" -LimitingCollectionName $LimitingCollectionAll -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection3.Name -QueryExpression $Collection3.Query -RuleName $Collection3.Name
Write-host *** Collection $Collection3.Name created ***

#New-CMDeviceCollection -Name $Collection4.Name -Comment "Prod client settings for Kiosks" -LimitingCollectionName $LimitingCollectionAllWorkAdmin -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionIncludeMembershipRule -Name $Collection4.Name -IncludeCollectionName $collection2.Name
#Write-host *** Collection $Collection4.Name created ***

#New-CMDeviceCollection -Name $Collection5.Name -Comment "Test client settings for Kiosks" -LimitingCollectionName $LimitingCollectionAllWorkAdmin -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Write-host *** Collection $Collection5.Name created ***

#New-CMDeviceCollection -Name $Collection6.Name -Comment "Prod client settings for servers" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionIncludeMembershipRule -Name $Collection6.Name -IncludeCollectionName $collection1.Name
#Write-host *** Collection $Collection6.Name created ***

#New-CMDeviceCollection -Name $Collection7.Name -Comment "Test client settings for servers" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Write-host *** Collection $Collection7.Name created ***

#New-CMDeviceCollection -Name $Collection8.Name -Comment "Endpoint Protection Policy for Prod Kiosks" -LimitingCollectionName $LimitingCollectionAllWorkAdmin -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionIncludeMembershipRule -Name $Collection8.Name -IncludeCollectionName $collection2.Name
#Write-host *** Collection $Collection8.Name created ***

#New-CMDeviceCollection -Name $Collection9.Name -Comment "Endpoint Protection Policy for Kiosks" -LimitingCollectionName $LimitingCollectionAllWorkAdmin -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Write-host *** Collection $Collection9.Name created ***

#New-CMDeviceCollection -Name $Collection10.Name -Comment "Endpoint Protection Policy for Servers" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionIncludeMembershipRule -Name $Collection10.Name -IncludeCollectionName $collection1.Name
#Write-host *** Collection $Collection10.Name created ***

#New-CMDeviceCollection -Name $Collection11.Name -Comment "Endpoint Protection Policy for Test Servers" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Write-host *** Collection $Collection11.Name created ***

New-CMDeviceCollection -Name $Collection12.Name -Comment "All physical servers" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection12.Name -QueryExpression $Collection12.Query -RuleName $Collection12.Name
Write-host *** Collection $Collection12.Name created ***

New-CMDeviceCollection -Name $Collection13.Name -Comment "All virtual servers" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection13.Name -QueryExpression $Collection13.Query -RuleName $Collection13.Name
Write-host *** Collection $Collection13.Name created ***

#New-CMDeviceCollection -Name $Collection14.Name -Comment "All servers with Windows 2008 or 2008 R2 operating system" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection14.Name -QueryExpression $Collection14.Query -RuleName $Collection14.Name
#Write-host *** Collection $Collection14.Name created ***

#New-CMDeviceCollection -Name $Collection15.Name -Comment "All servers with Windows 2012 or 2012 R2 operating system" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection15.Name -QueryExpression $Collection15.Query -RuleName $Collection15.Name
#Write-host *** Collection $Collection15.Name created ***

#New-CMDeviceCollection -Name $Collection16.Name -Comment "All servers with Windows 2003 or 2003 R2 operating system" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection16.Name -QueryExpression $Collection16.Query -RuleName $Collection16.Name
#Write-host *** Collection $Collection16.Name created ***

New-CMDeviceCollection -Name $Collection17.Name -Comment "All servers with Windows 2016" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection17.Name -QueryExpression $Collection17.Query -RuleName $Collection17.Name
Write-host *** Collection $Collection17.Name created ***

#New-CMDeviceCollection -Name $Collection18.Name -Comment "All Kiosks with Windows 7 operating system" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection18.Name -QueryExpression $Collection18.Query -RuleName $Collection18.Name
#Write-host *** Collection $Collection18.Name created ***

New-CMDeviceCollection -Name $Collection19.Name -Comment "All Kiosks with Windows 8 operating system" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection19.Name -QueryExpression $Collection19.Query -RuleName $Collection19.Name
Write-host *** Collection $Collection19.Name created ***

New-CMDeviceCollection -Name $Collection20.Name -Comment "All Kiosks with Windows 8.1 operating system" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection20.Name -QueryExpression $Collection20.Query -RuleName $Collection20.Name
Write-host *** Collection $Collection20.Name created ***

#New-CMDeviceCollection -Name $Collection21.Name -Comment "All Kiosks with Windows XP operating system" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection21.Name -QueryExpression $Collection21.Query -RuleName $Collection21.Name
#Write-host *** Collection $Collection21.Name created ***

New-CMDeviceCollection -Name $Collection22.Name -Comment "All systems with SCCM console installed" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection22.Name -QueryExpression $Collection22.Query -RuleName $Collection22.Name
Write-host *** Collection $Collection22.Name created ***

New-CMDeviceCollection -Name $Collection23.Name -Comment "SCCM client version 1115" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection23.Name -QueryExpression $Collection23.Query -RuleName $Collection23.Name
Write-host *** Collection $Collection23.Name created ***

#New-CMDeviceCollection -Name $Collection24.Name -Comment "All Dell Laptops" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection24.Name -QueryExpression $Collection24.Query -RuleName $Collection24.Name
#Write-host *** Collection $Collection24.Name created ***

#New-CMDeviceCollection -Name $Collection25.Name -Comment "All Lenovo laptops" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection25.Name -QueryExpression $Collection25.Query -RuleName $Collection25.Name
#Write-host *** Collection $Collection25.Name created ***

#New-CMDeviceCollection -Name $Collection26.Name -Comment "All HP Laptops" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection26.Name -QueryExpression $Collection26.Query -RuleName $Collection26.Name
#Write-host *** Collection $Collection26.Name created ***

#New-CMDeviceCollection -Name $Collection27.Name -Comment "All Microsoft Surface 4" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection27.Name -QueryExpression $Collection27.Query -RuleName $Collection27.Name
#Write-host *** Collection $Collection27.Name created ***

New-CMDeviceCollection -Name $Collection28.Name -Comment "All Kiosks with Windows 10 operating system" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection28.Name -QueryExpression $Collection28.Query -RuleName $Collection28.Name
Write-host *** Collection $Collection28.Name created ***

#New-CMDeviceCollection -Name $Collection29.Name -Comment "OSD Collection for Windows 10 deployment in production" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Write-host *** Collection $Collection29.Name created ***

#New-CMDeviceCollection -Name $Collection30.Name -Comment "OSD collection to test deployment of Windows 10. Limited to admins only" -LimitingCollectionName $LimitingCollectionAllWorkAdmin -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Write-host *** Collection $Collection30.Name created ***

#New-CMDeviceCollection -Name $Collection31.Name -Comment "Software Update collection to exclude computers from all Software Update collections. Manual Membership" -LimitingCollectionName $LimitingCollectionAllWorkAdmin -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Write-host *** Collection $Collection31.Name created ***

#New-CMDeviceCollection -Name $Collection32.Name -Comment "Software Update collection for Pilot group. Manual membership" -LimitingCollectionName $LimitingCollectionAllWorkAdmin -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionExcludeMembershipRule -Name $Collection32.Name -ExcludeCollectionName $collection31.Name
#Write-host *** Collection $Collection32.Name created ***

#New-CMDeviceCollection -Name $Collection33.Name -Comment "Software Update collection for test group. Manual membership" -LimitingCollectionName $LimitingCollectionAllWorkAdmin -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionExcludeMembershipRule -Name $Collection33.Name -ExcludeCollectionName $collection31.Name
#Write-host *** Collection $Collection33.Name created ***

#New-CMDeviceCollection -Name $Collection34.Name -Comment "Software Update collection for Production. All Kiosks" -LimitingCollectionName $LimitingCollectionAllWorkAdmin -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Add-CMDeviceCollectionIncludeMembershipRule -Name $Collection34.Name -IncludeCollectionName $collection2.Name
#Add-CMDeviceCollectionExcludeMembershipRule -Name $Collection34.Name -ExcludeCollectionName $collection31.Name
#Write-host *** Collection $Collection34.Name created ***

#New-CMDeviceCollection -Name $Collection35.Name -Comment "Collection for deployment of Office 365 production" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Write-host *** Collection $Collection35.Name created ***

#New-CMDeviceCollection -Name $Collection36.Name -Comment "Test Collection for deployment of Office 365. Limited to admins only." -LimitingCollectionName $LimitingCollectionAllWorkAdmin -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
#Write-host *** Collection $Collection36.Name created ***

New-CMDeviceCollection -Name $Collection37.Name -Comment "All physical kiosks" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection37.Name -QueryExpression $Collection37.Query -RuleName $Collection37.Name
Write-host *** Collection $Collection37.Name created ***

New-CMDeviceCollection -Name $Collection38.Name -Comment "All virtual kiosks" -LimitingCollectionName $LimitingCollectionAllServer -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection38.Name -QueryExpression $Collection38.Query -RuleName $Collection38.Name
Write-host *** Collection $Collection38.Name created ***

New-CMDeviceCollection -Name $Collection39.Name -Comment "SCCM client version not 1115" -LimitingCollectionName $LimitingCollectionAllWork -RefreshSchedule $Schedule -RefreshType 2 | Out-Null
Add-CMDeviceCollectionQueryMembershipRule -CollectionName $Collection39.Name -QueryExpression $Collection39.Query -RuleName $Collection39.Name
Write-host *** Collection $Collection39.Name created ***

#Move the collection to the right folder
#Master Collections
$FolderPath = $SiteCode.Name+":\DeviceCollection\Master Collections"
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection1.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection2.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection3.Name)

#MC - Clients Settings
$FolderPath = $SiteCode.Name+":\DeviceCollection\Master Collections\MC - Client Settings"
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection4.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection5.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection6.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection7.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection23.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection39.Name)
#MC - Endpoint Protection
$FolderPath = $SiteCode.Name+":\DeviceCollection\Master Collections\MC - Endpoint Protection"

#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection8.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection9.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection10.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection11.Name)

#Servers\SRV - Inventory\SRV - Hardware
$FolderPath = $SiteCode.Name+":\DeviceCollection\Servers\SRV - Inventory\SRV - Hardware"
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection12.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection13.Name)

#Servers\SRV - Inventory\SRV - Operating System
$FolderPath = $SiteCode.Name+":\DeviceCollection\Servers\SRV - Inventory\SRV - Operating System"
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection14.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection15.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection16.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection17.Name)

#Kiosks\KSK - Inventory\KSK - Operating System
$FolderPath = $SiteCode.Name+":\DeviceCollection\Kiosks\KSK - Inventory\KSK - Operating System"
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection18.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection19.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection20.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection21.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection28.Name)

#Kiosks\KSK - Inventory\KSK - Software
$FolderPath = $SiteCode.Name+":\DeviceCollection\Kiosks\KSK - Inventory\KSK - Software"
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection22.Name)

#Kiosks\KSK - Inventory\KSK - Hardware
$FolderPath = $SiteCode.Name+":\DeviceCollection\Kiosks\KSK - Inventory\KSK - Hardware"
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection24.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection25.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection26.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection27.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection37.Name)
Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection38.Name)

#Kiosks\OS Deployment
$FolderPath = $SiteCode.Name+":\DeviceCollection\Kiosks\KSK - OS Deployment"
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection29.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection30.Name)

#Kiosks\Software Update
$FolderPath = $SiteCode.Name+":\DeviceCollection\Kiosks\KSK - Software Update"
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection31.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection32.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection33.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection34.Name)

#Kiosks\Software Distribution
$FolderPath = $SiteCode.Name+":\DeviceCollection\Kiosks\KSK - Software Distribution"
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection35.Name)
#Move-CMObject -FolderPath $FolderPath -InputObject (Get-CMDeviceCollection -Name $Collection36.Name)





