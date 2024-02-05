# Define the resource group and template parameters
$resourceGroupName = "arm-rgp-01"
$templateFile = ".\01.00.createSta.json"
$templateParametersFile = ".\01.00.createSta.parameters.json"

# Authenticate to Azure
Connect-AzAccount

# Select the subscription
Set-AzContext -SubscriptionId "e25024e7-c4a5-4883-80af-9e81b2f8f689"

# Create or update the resource group
New-AzResourceGroup -Name $resourceGroupName -Location "eastus2"

# Deploy the ARM template
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFile -TemplateParameterFile $templateParametersFile -Verbose
