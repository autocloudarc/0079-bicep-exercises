targetScope = 'resourceGroup'

param location string
@description('The name of the storage account.')
@minLength(3)
@maxLength(24)
param storageAccountName string
param storageAccountSku string
param storageAccountKind string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: storageAccountKind
  sku: {
    name: storageAccountSku
  }
}

output storageAccountId string = storageAccount.id
