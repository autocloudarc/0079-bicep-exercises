// Using Azure DevOps pipelines, create a storage account with a container nested resource defined
/*
az ts create --name ${{ parameters.templateSpecName }} \
  --description ${{ parameters.templateSpecDescription }} \
  --version $(TemplateSpecVersion) \
  --resource-group ${{ parameters.iacResourceGroup }} \
  --location ${{ parameters.location }} \
  --template-file ${{ parameters.templateSpecSourceFile }} \
  --parameters ${{ parameters.templateSpecParamsFile }} \
  --verbose
*/

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
