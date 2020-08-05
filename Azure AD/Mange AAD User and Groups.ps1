# Delete AAD User	
Get-MsolUser -UserPrincipalName 'sync_cm-adconnect_54b7d88e4eaf@cmkts.onmicrosoft.com'

Remove-MsolUser -UserPrincipalName 'sync_cm-adconnect_54b7d88e4eaf@cmkts.onmicrosoft.com'

Set-AzureADUserPassword -ObjectId  "df19e8e6-2ad7-453e-87f5-037f6529ae16" -Password $password








Remove-MsolUser -UserPrincipalName 'OpUser2@Twenty7Twenty.com'
Remove-MsolUser -UserPrincipalName 'JoinUser01@Twenty7Twenty.com'
Remove-MsolUser -UserPrincipalName 'HybridUser01@Twenty7Twenty.com'
Remove-MsolUser -UserPrincipalName 'cnewelladmin@Twenty7Twenty.com'
Remove-MsolUser -UserPrincipalName 'Sync_DC1_c450e900fa95@twenty7twenty.onmicrosoft.com'
Remove-MsolUser -UserPrincipalName 'Sync_2720-DC01_cc5601388cdd@twenty7twenty.onmicrosoft.com'

# Delete AAD Group
Get-MsolRole -RoleName "cloud device administrator"

Get-MsolGroup -SearchString "WIN10 Pro" | Remove-MsolGroup
Get-MsolGroup -SearchString "WIN10 Ent" | Remove-MsolGroup