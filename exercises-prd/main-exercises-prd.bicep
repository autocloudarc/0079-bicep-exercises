targetScope = 'subscription'
// Create a storage account resource with a type of Standard_LRS and a kind of StorageV2 
// We assume that we've arleady authenticated to Azure and selected the lab subscription id or name

@description('The location of the resource. This value is ignored when deploying to a resource group.')
@allowed([
  'eastus'
  'eastus2'
  'westus'
  'westus2'
  'centralus'
])
param primaryLocation string = 'centralus'
@description('The name of the resource group in which to create the resource.')
param labResourceGroup string = 'rgp-lab'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: labResourceGroup
  location: primaryLocation
}

var randomString = toLower(uniqueString(subscription().subscriptionId, labResourceGroup))
var randomSuffix = substring(randomString, 0, 8)
var storageAccountPrefix = 'sta'
var storageAccountName = '${storageAccountPrefix}${randomSuffix}'
var storageAccountSku = 'Standard_LRS'
var storageAccountKind = 'StorageV2'

module lab './modules/labs/labs-prd.bicep' = {
  scope: resourceGroup
  name: 'lab-deployment'
  params: {
    location: primaryLocation
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
    storageAccountKind: storageAccountKind
  } 
}

output storageAccountName string = lab.outputs.storageAccountId

