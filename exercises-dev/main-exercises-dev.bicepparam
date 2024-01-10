using './main-exercises-dev.bicep'

param primaryLocation  = 'centralus'
param labResourceGroup = 'rgp-lab'
// Below, the last argument ...d742 is the version of the secret
param kvtPw = getSecret('e25024e7-c4a5-4883-80af-9e81b2f8f689', 'rgp-iac', 'iac-kvt-01', 'kvtPw')
