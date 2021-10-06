@description('The name of the frontdoor resource.')
param resourceName string = 'powerapptest'

@description('The location of the frontdoor resource.')
param location string = 'global'

resource afd 'Microsoft.Network/frontdoors@2020-05-01' = {
  name: resourceName
  location: location
  tags: {}
  properties: {
    //frontdoorId: '/subscriptions/0e9da35c-07a7-4468-98f4-03fbeb4db963/resourceGroups/rg-frondoor-neu-001/providers/Microsoft.Network/frontdoors/powerappstest'
    friendlyName: 'powerappstest'
    enabledState: 'Enabled'
    healthProbeSettings: [
      {
        id: '/subscriptions/0e9da35c-07a7-4468-98f4-03fbeb4db963/resourceGroups/rg-frondoor-neu-001/providers/Microsoft.Network/frontdoors/powerappstest/healthProbeSettings/healthProbeSettings-1630519923604'
        name: 'healthProbeSettings-1630519923604'
        properties: {
          path: '/'
          protocol: 'Https'
          intervalInSeconds: 30
          healthProbeMethod: 'HEAD'
          enabledState: 'Enabled'
        }
      }
    ]
    loadBalancingSettings: [
      {
        id: '/subscriptions/0e9da35c-07a7-4468-98f4-03fbeb4db963/resourceGroups/rg-frondoor-neu-001/providers/Microsoft.Network/frontdoors/powerappstest/loadBalancingSettings/loadBalancingSettings-1630519923604'
        name: 'loadBalancingSettings-1630519923604'
        properties: {
          sampleSize: 4
          successfulSamplesRequired: 2
          additionalLatencyMilliseconds: 0
        }
      }
    ]
    frontendEndpoints: [
      {
        name: 'powerappstest-azurefd-net'
        properties: {
          hostName: 'powerappstest.azurefd.net'
          sessionAffinityEnabledState: 'Disabled'
          sessionAffinityTtlSeconds: 0
          webApplicationFirewallPolicyLink: null
          //customHttpsConfiguration: null
        }
        id: '/subscriptions/0e9da35c-07a7-4468-98f4-03fbeb4db963/resourceGroups/rg-frondoor-neu-001/providers/Microsoft.Network/frontdoors/powerappstest/frontendEndpoints/powerappstest-azurefd-net'
      }
    ]
    backendPools: [
      {
        id: '/subscriptions/0e9da35c-07a7-4468-98f4-03fbeb4db963/resourceGroups/rg-frondoor-neu-001/providers/Microsoft.Network/frontdoors/powerappstest/backendPools/jagslabtestblue'
        name: 'jagslabtestblue'
        properties: {
          backends: [
            {
              address: 'jagslabtestblue.powerappsportals.com'
              privateLinkResourceId: null
              privateLinkLocation: null
              //privateEndpointStatus: null
              privateLinkApprovalMessage: null
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
              backendHostHeader: 'jagslabtestblue.powerappsportals.com'
            }
            {
              address: 'jagslabtestgreen.powerappsportals.com'
              privateLinkResourceId: null
              privateLinkLocation: null
              //privateEndpointStatus: null
              privateLinkApprovalMessage: null
              enabledState: 'Enabled'
              httpPort: 80
              httpsPort: 443
              priority: 2
              weight: 50
              backendHostHeader: 'jagslabtestgreen.powerappsportals.com'
            }
          ]
          loadBalancingSettings: {
            id: '/subscriptions/0e9da35c-07a7-4468-98f4-03fbeb4db963/resourceGroups/rg-frondoor-neu-001/providers/Microsoft.Network/frontdoors/powerappstest/loadBalancingSettings/loadBalancingSettings-1630519923604'
          }
          healthProbeSettings: {
            id: '/subscriptions/0e9da35c-07a7-4468-98f4-03fbeb4db963/resourceGroups/rg-frondoor-neu-001/providers/Microsoft.Network/frontdoors/powerappstest/healthProbeSettings/healthProbeSettings-1630519923604'
          }
        }
      }
    ]
    routingRules: [
      {
        name: 'route'
        properties: {
          frontendEndpoints: [
            {
              id: '/subscriptions/0e9da35c-07a7-4468-98f4-03fbeb4db963/resourceGroups/rg-frondoor-neu-001/providers/Microsoft.Network/frontdoors/powerappstest/frontendEndpoints/powerappstest-azurefd-net'
            }
          ]
          acceptedProtocols: [
            'Http'
            'Https'
          ]
          patternsToMatch: [
            '/*'
          ]
          enabledState: 'Enabled'
          routeConfiguration: {
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
            customForwardingPath: null
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: '/subscriptions/0e9da35c-07a7-4468-98f4-03fbeb4db963/resourceGroups/rg-frondoor-neu-001/providers/Microsoft.Network/frontdoors/powerappstest/backendPools/jagslabtestblue'
            }
            cacheConfiguration: null
          }
        }
        id: '/subscriptions/0e9da35c-07a7-4468-98f4-03fbeb4db963/resourceGroups/rg-frondoor-neu-001/providers/Microsoft.Network/frontdoors/powerappstest/routingRules/route'
      }
    ]
    backendPoolsSettings: {
      enforceCertificateNameCheck: 'Enabled'
      sendRecvTimeoutSeconds: 30
    }
  }
}
