targetScope = 'resourceGroup'

param location string
@minLength(3)
@maxLength(24)
@description('The name of the storage account. Must be unique within the storage service the account is created. Storage account names must be between 3 and 24 characters in length and use numbers and lower-case letters only.')
param storageAccountName string
param storageAccountSku string
param storageAccountKind string
param storageAccountPrefix string 
param guidString1 string = newGuid()
param guidString2 string = newGuid()
param guidString3 string = newGuid()
param guidString4 string = newGuid()

// law exercise
param lawName string = 'orgid-la'
param mgtSubId string = '019181ad-6356-46c6-b584-444846096085'
param mgtResourceGroup string = 'orgid-mgt'
param containerNames array = ['container1','container2','container3']

var nics = loadJsonContent('variables-dev.json')
var deployAdditionalStorageAcct = true
var guidStringShort = substring(guidString4,0,8)
var extraStorageAcctName = '${storageAccountPrefix}guidString4}'

// Conditional deployment for a storage account based on the value of the deployAdditionalStorageAcct variable
// ref: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/conditional-resource-deployment#define-condition-for-deployment
resource staAdditional 'Microsoft.Storage/storageAccounts@2023-01-01' = if (deployAdditionalStorageAcct) {
  name: extraStorageAcctName
  location: location
  kind: storageAccountKind
  sku: {
    name: storageAccountSku
  }
} 

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: storageAccountKind
  sku: {
    name: storageAccountSku
  }
}

var staName1 = '${storageAccountPrefix}${substring(guidString1,0,8)}'
var staName2 = '${storageAccountPrefix}${substring(guidString2,0,8)}'
var staName3 = '${storageAccountPrefix}${substring(guidString3,0,8)}'

var staNames = [staName1,staName2,staName3]

// Create storage accounts
resource staAccounts 'Microsoft.Storage/storageAccounts@2023-01-01' = [for (staName,i) in staNames: {
  name: staName
  location: location
  kind: storageAccountKind
  sku: {
    name: storageAccountSku
  }
}]


// Create blob service
resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = [for j in range(0, length(staNames)): {
  name: 'default'
  parent: staAccounts[j]
}]


// Create container
resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [for k in range(0, length(containerNames)): {
  name: containerNames[k]
  parent: blobServices[k]
  properties: {
    publicAccess: 'None'
    metadata: {}
  }
}]

resource law 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: lawName
  scope: resourceGroup(mgtSubId, mgtResourceGroup)
}

// Output loop construction with arrays
var staAccountIds = [staAccounts[0].id, staAccounts[1].id, staAccounts[2].id]
var storageCount = 3
var noAdditionalStorageAccount = 'An additional storage account was not deployed.'

output storageAccountId string = storageAccount.id
output lawId string = law.id
output staAccountId1 string = staAccounts[0].id
output staAccountId2 string = staAccounts[1].id
output staAccountId3 string = staAccounts[2].id
output lawResourceId string = law.id
output staAccountIds array = staAccountIds
output storageInfo array = [for m in range(0, storageCount): {
  id: staAccounts[m].id
  blobEndpoint: staAccounts[m].properties.primaryEndpoints.blob
  status: staAccounts[m].properties.statusOfPrimary
}]
// ternerary operator
output additionalStaId string = (deployAdditionalStorageAcct) ? staAdditional.id : noAdditionalStorageAccount

// varible = (condition) ? true : false
