/*
Exercises

Instructions: Please complete each task below in order and place an 'x' in the checkbox when complete, i.e. [x] = complete [s] = skipped. 

Command reference: (Note: In the commands below, replace stack-preston.parsard with your own stack name, i.e. stack-milla.yovovich)
cr1: az stack sub create --name stack-preston.parsard --location centralus --template-file ./exercises-<env>/main-exercises-<env>.bicep [--parameters <main-exercises-<env>.bicepparam|main-exercises-<env>.parameters.json] --deny-settings-mode none --delete-all --yes --verbose
cr2: az stack sub delete --name stack-preston.parsard --delete-all --yes --verbose

Pre-requisites
0.a [x] Clone the Azure DevOps project repo bicep-exercises to your local machine with your favorite IDE (VSCode ;-))
0.b [x] Change directory to the local folder of the cloned repo (.../bicep-exercises)
0.c [x] Authenticate to Azure and select the target subscription for this set of exercises; Example: az login; az account set -s <mcap-azr-dev-sub-01>
0.d [x] Verify that the account was selected properly; Example: az account show --query name -o tsv
0.e [s] Create a new branch for your changes; Example: git checkout -b <preston.parsard>-practice (For this and remaining examples, replace <preston.parsard> with your name)
0.f [s] Install the Azure CLI from https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli
0.g [s] Install the Bicep CLI using: 'az bicep install'

1. [x] Use the command reference cr1 to create a resource group in the 'centralus' region with a name of 'rgp-lab' in the main-exercises-<env>.bicep file
a. [] Push changes to your branch with: git add .; git commit -m "resource(group): add"; git push origin <preston.parsard>-practice
b. [] Deploy the changes to Azure with command reference cr1 above
c. [] Delete the deployment stack with command reference cr2 above. 
   This is just to demonstrate that the deployment is managed and maintains the state to cleanup previously deployed resources
e. [] Redeploy the changes to Azure with command reference cr1 above

2. [x] Create a storage account named sta<randomstring> in the resource group created in step 1 above where <randomstring> is the name suffix that must be randomly generated
a. [s] Push changes to your branch with: git add .; git commit -m "storage(account): add"; git push origin <preston.parsard>-practice
b. [s] Deploy the changes to Azure with command reference cr1 above

3. [x] Add storage account parameters for the following storage account properties: name = sta<randomstring>, sku = Standard_LRS, kind = StorageV2
a. [s] Push changes to your branch with: git add .; git commit -m "storage(account): add parameters"; git push origin <preston.parsard>-practice
b. [s] Deploy the changes to Azure with command reference cr1 above

4. [x] Create a single storage account resource using the parameters from step 2 above
a. [s] Push changes to your branch with: git add .; git commit -m "storage(account): add resource"; git push origin <preston.parsard>-practice
b. [s] Deploy the changes to Azure with command reference cr1 above

5. [x] Add an output for the storage account resource id in the called module
a. [s] Push changes to your branch with: git add .; git commit -m "storage(account): add output"; git push origin <preston.parsard>-practice
b. [s] Deploy the changes to Azure with command reference cr1 above

6. [x] Deploy 3 additional storage accounts using a for loop where the storage account name is unique (hint: see item 2. above); use (a) for loop
a. [x] Push changes to your branch with: git add .; git commit -m "storage(account): add for loop"; git push origin <preston.parsard>-practice
b. [x] Deploy the changes to Azure with command reference cr1 above

7. [x] Add 3 outputs for each of the three (3) storage account resource ids
a. [s] Push changes to your branch with: git add .; git commit -m "storage(account): add output loop"; git push origin <preston.parsard>-practice
b. [s] Deploy the changes to Azure with command reference cr1 above

8. [x] Add parameter decorators for the storage account name; min, max, allowedvalues, description
a. [s] Push changes to your branch with: git add .; git commit -m "storage(account): add parameter decorators"; git push origin <preston.parsard>-practice
b. [s] Deploy the changes to Azure with command reference cr1 above

9.[x] Discuss which methods are available for using secure secrets for Bicep deployments using Azure DevOps ?
a. [x] Create an Azure key vault in subcription and resource group '/subscriptions/<guid>/resourceGroups/rgp-iac/providers/Microsoft.KeyVault/vaults/iac-kvt-<randomstring>'
      1. To generate the <randomstring> value, use a parameter statement with the newGuid() function in the labs-<env).bicep file.
      2. Configure the keyvualt to use Azure Entra ID RBAC permissions
      3. Add a role to your login account to allow access to the key vault by adding the role 'Key Vault Secrets Officer' to your login account
      4. Add a secret named 'kvtPw' with the value of the powershell command: (new-guid).guid.substring(0,8)
b. [x] Retrieve and display key vault secret by using a *.bicepparam file

10.[x] Use the loadjsoncontent() function to load a collection of nic objects as an array variable in the module file. Nics will have name and private IP address proprties.
a. [] Push changes to your branch with: git add .; git commit -m "nic(array): add loadjsoncontent()"; git push origin <preston.parsard>-practice
b. [] Deploy the changes to Azure with command reference cr1 above

11.[x] Get the resourceid for a log analytics workspace from a different subscription (if available) from a module bicep file at the resource group scope and display as an output.
a. [] Push changes to your branch with: git add .; git commit -m "loganalytics(workspace): add resourceid()"; git push origin <preston.parsard>-practice
b. [] Deploy the changes to Azure with command reference cr1 above

12.[x] Create a key vault resource with a name of lab-kvt-<randomstring> and with RBAC access in the resource group created in step 1 above where <randomstring> is the name suffix that must be randomly generated
a. [x] Push changes to your branch with: git add .; git commit -m "keyvault: add"; git push origin <preston.parsard>-practice
b. [x] Add a secret named 'kvtPw' with the value of the powershell command: (new-guid).guid.substring(0,8)
c. [x] Configure the key vault access policy to allow the current user to get and list secrets
d. [x] Create a new json parameter file named main-exercises-<env>.parameters.json as specified below: (here, <env> is the environment name, e.g. dev, prd)

13.[x] Create 3 containers named container1, container2, container3 in the storage accounts created in step 6 above
a. [] Push changes to your branch with: git add .; git commit -m "storage(account): add containers"; git push origin <preston.parsard>-practice
b. [] Deploy the changes to Azure with command reference cr1 above
c. [] You may choose now to delete the deployment stack with command reference cr2 above.

{
  '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#'
  contentVersion: '1.0.0.0'
  parameters: {
    primaryLocation: {
      value: 'centralus'
    }
    labResourceGroup: {
      value: 'rgp-lab'
    }
    kvtPw: {
      reference: {
        keyVault: {
          id: '/subscriptions/<subscriptionid>/resourceGroups/rgp-iac/providers/Microsoft.KeyVault/vaults/iac-kvt-01'
        }
        secretName: 'kvtPw'
      }
    }
  }
}

d. [x] Add the parameters from (c) above to the params section of the main-exercises-<env>.bicep file and display the parameters in the output section (Here, <env> is the environment name, e.g. dev, prd)
e. [] Deploy the changes to Azure with command reference cr1 above
f. [] {Optional}: Delete the deployment stack with command reference cr2 above. 
   This is just to demonstrate that the deployment is managed and maintains the state to cleanup previously deployed resources 

14. [x] Bonus: Experiment with using loops for array output
15. [x] Bonus: Experiment with using the conditional operator (ternary operator syntax in the main Bicep file output section)
16. *[] Bonus: Use the Azure Contaner Registry to reference modules: (ref): https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/modules#private-module-registry
*/
