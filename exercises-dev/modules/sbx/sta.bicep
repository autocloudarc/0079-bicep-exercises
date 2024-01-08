// Create a storage account with a container nested resource defined
// az bicep publish --file './modules/sbx/sta.bicep' --target "br:autocloudarc.azurecr.io/bicep-training/modules/storage:1.0.0"

param primaryLocation string 
param storageAccountNamePrefix string
param storageAccountType string
param storageAccountKind string
param staAccessTier string
param guidString string = newGuid()

var randomSuffix = substring(guidString, 0, 8)
var storageAccountName = '${storageAccountNamePrefix}${randomSuffix}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: primaryLocation
  kind: storageAccountKind
  sku: {
    name: storageAccountType
  }
  properties: {
    accessTier: staAccessTier
  }
}

output storageAccountName string = storageAccount.name
output storageAccountResourceId string = storageAccount.id
output storageAccountAccessTier string = storageAccount.properties.accessTier
