
Import-Module "C:\Program Files\Microsoft Azure Active Directory Connect\AdSyncConfig\AdSyncConfig.psm1"

Set-ADSyncPasswordHashSyncPermissions -ADConnectorAccountName SA_ADConnect -ADConnectorAccountDomain CMKTS.COM
Set-ADSyncPasswordWritebackPermissions -ADConnectorAccountName SA_ADConnect -ADConnectorAccountDomain CMKTS.COM
Set-ADSyncUnifiedGroupWritebackPermissions -ADConnectorAccountName SA_ADConnect -ADConnectorAccountDomain CMKTS.COM