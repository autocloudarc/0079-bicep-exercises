targetScope = 'subscription'
// Create a storage account resource with a type of Standard_LRS and a kind of StorageV2 
// We assume that we've arleady authenticated to Azure and selected the lab subscription id or name

@description('This is a Bicep file that deploys a lab environment')
param primaryLocation string = 'centralus'

param labResourceGroup string = 'rgp-lab'
@secure()
param kvtPw string
param iacResourceGroup string = 'rgp-iac'
param kvtName string = 'iac-kvt-01'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: labResourceGroup
  location: primaryLocation
}


resource iacRgp 'Microsoft.Resources/resourceGroups@2023-07-01' existing = {
  name: iacResourceGroup
}

// Add a resource for an existing kev vault to retrieve its secret from the iac resouce group  
resource kvt 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: kvtName
  scope: iacRgp
}

// This is just an example of how you would retrieve a secret from the existing key vault referenced above (kvt)
// module sql './sql.bicep' = {
//   name: 'deploySQL'
//   params: {
//     sqlServerName: sqlServerName
//     adminLogin: 'sqladmin'
//     adminPassword: kvt.getSecret(kvtPw)
//   }
// }

var randomString = toLower(uniqueString(subscription().subscriptionId, labResourceGroup))
var randomSuffix = substring(randomString, 0, 8)
var storageAccountPrefix = 'sta'
var storageAccountName = '${storageAccountPrefix}${randomSuffix}'
var storageAccountSku = 'Standard_LRS'
var storageAccountKind = 'StorageV2'

module lab './modules/labs/labs-dev.bicep' = {
  scope: resourceGroup
  name: 'lab-deployment'
  params: {
    location: primaryLocation
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
    storageAccountKind: storageAccountKind
    storageAccountPrefix: storageAccountPrefix
  } 
}

output location string = primaryLocation
output labRg string = labResourceGroup
output staAccountId1 string = lab.outputs.staAccountId1
output staAccountId2 string = lab.outputs.staAccountId2
output staAccountId3 string = lab.outputs.staAccountId3
output staAccountId string = lab.outputs.storageAccountId
output logAnalyticsId string = lab.outputs.lawId
output keyVaultId string = kvt.id
output keVaultSecret string = kvtPw
output labStaAccountIds array = lab.outputs.staAccountIds
output labStorageAccountInfo array = lab.outputs.storageInfo
output labExtraStorageAccountId string = lab.outputs.additionalStaId
