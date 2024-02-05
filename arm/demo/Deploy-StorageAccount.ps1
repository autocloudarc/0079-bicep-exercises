# Define the path to the template file
$templatePath = ".\templateSta.json"
$templateParametersFile = ".\templateSta.parameters.json"
$resourceGroupName = "arm-rgp-01"
$location = "eastus2"
# Authenticate to Azure
Connect-AzAccount
# Select the subscription
Set-AzContext -SubscriptionId "e25024e7-c4a5-4883-80af-9e81b2f8f689"
# Create or update the resource group
New-AzResourceGroup -Name $resourceGroupName -Location $location -Verbose
# Deploy the ARM template
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templatePath -TemplateParameterFile $templateParametersFile -Verbose

