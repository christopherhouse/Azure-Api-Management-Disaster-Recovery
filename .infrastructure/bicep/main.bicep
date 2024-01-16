param apiManagementServiceName string
param location string
param skuName string
param skuCapacity int
param publisherEmailAddress string
param publisherName string
@allowed(['External', 'Internal', 'None'])
param vnetIntegrationMode string
param vnetSubnetResourceId string
param publicIpResourceId string
param buildId string

var apimDeploymentName = 'apim-deployment-${buildId}'

module apim './modules/apiManagementService.bicep' = {
  name: apimDeploymentName
  params: {
    apiManagementServiceName: apiManagementServiceName
    location: location
    skuName: skuName
    skuCapacity: skuCapacity
    publisherEmailAddress: publisherEmailAddress
    publisherName: publisherName
    vnetIntegrationMode: vnetIntegrationMode
    vnetSubnetResourceId: vnetSubnetResourceId
    publicIpResourceId: publicIpResourceId
  }
}
