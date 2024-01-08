// Using Azure DevOps pipelines, create a storage account with a container nested resource defined
/*
az ts create --name ${{ parameters.templateSpecName }} \
  --description ${{ parameters.templateSpecDescription }} \
  --version $(TemplateSpecVersion) \
  --resource-group ${{ parameters.iacResourceGroup }} \
  --location ${{ parameters.location }} \
  --template-file ${{ parameters.templateSpecSourceFile }} \
  --verbose
*/

/*
1. navigate to ./exercises-dev/modules/sbx
2. run the following command to create a template spec
   az ts create --name tsp0823 --description "template-spec-demo" --version 1.1.1 --resource-group rgp-iac --location centralus --template-file sta-tsp.bicep --verbose
3. run the following command to list template specs
   az ts list --resource-group rgp-iac
4. run the following command to create a deployment using the template spec
   az deployment group create --resource-group rgp-iac --template-spec "/subscriptions/e25024e7-c4a5-4883-80af-9e81b2f8f689/resourceGroups/rgp-iac/providers/Microsoft.Resources/templateSpecs/tsp0823/versions/1.1.1" --parameters sta-tsp.parameters.json --verbose
5. run the following command to delete the template spec
   az ts delete --name tsp0823 --resource-group rgp-iac --verbose
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
