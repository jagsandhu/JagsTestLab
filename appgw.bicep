param applicationGateways_appgw_customerportal_test_neu_001_name string = 'appgw-customerportal-test-neu-001'
param virtualNetworks_vnet_il_test_neu_01_externalid string = '/subscriptions/8298964b-7f9c-44d8-8f40-9f11d01ea040/resourceGroups/rg-networks-test-neu-001/providers/Microsoft.Network/virtualNetworks/vnet-il-test-neu-01'
param publicIPAddresses_pip_appgw_customerportal_test_neu_001_externalid string = '/subscriptions/8298964b-7f9c-44d8-8f40-9f11d01ea040/resourceGroups/rg-customerportal-test-neu-001/providers/Microsoft.Network/publicIPAddresses/pip-appgw-customerportal-test-neu-001'

resource applicationGateways_appgw_customerportal_test_neu_001_name_resource 'Microsoft.Network/applicationGateways@2020-11-01' = {
  name: applicationGateways_appgw_customerportal_test_neu_001_name
  location: 'northeurope'
  tags: {
    Service: 'CustomerPortal'
    Project: 'PRJT0040'
    Environment: 'Integration and System Test'
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/8298964b-7f9c-44d8-8f40-9f11d01ea040/resourcegroups/rg-customerportal-test-neu-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/msi-appgw-customerportal-test-neu-001': {
        principalId: '6638a618-fca1-4d6a-838c-80bfb553857e'
        clientId: '47a6baa7-ec4e-4428-aee1-b988b2336e13'
      }
    }
  }
  properties: {
    sku: {
      name: 'WAF_v2'
      tier: 'WAF_v2'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: '${virtualNetworks_vnet_il_test_neu_01_externalid}/subnets/appgw-subnet'
          }
        }
      }
    ]
    sslCertificates: [
      {
        name: 'wildcard.property.nhs.uk'
        properties: {}
      }
    ]
    trustedRootCertificates: []
    trustedClientCertificates: []
    sslProfiles: []
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIp'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddresses_pip_appgw_customerportal_test_neu_001_externalid
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_443'
        properties: {
          port: 443
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'sinkpool'
        properties: {
          backendAddresses: []
        }
      }
      {
        name: 'apimbackend'
        properties: {
          backendAddresses: [
            {
              ipAddress: '10.0.10.69'
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'apim-developer-poolsetting'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 180
          probe: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/probes/apim-developer-probe'
          }
        }
      }
      {
        name: 'apim-management-poolsetting'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 180
          probe: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/probes/apim-management-probe'
          }
        }
      }
      {
        name: 'apim-portal-poolsetting'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Enabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 180
          probe: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/probes/apim-portal-probe'
          }
        }
      }
      {
        name: 'apim-gw-poolsetting'
        properties: {
          port: 443
          protocol: 'Https'
          cookieBasedAffinity: 'Enabled'
          pickHostNameFromBackendAddress: false
          affinityCookieName: 'ApplicationGatewayAffinity'
          requestTimeout: 20
          probe: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/probes/apim-gw-proxyprobe'
          }
        }
      }
    ]
    httpListeners: [
      {
        name: 'apim-gw-listener01'
        properties: {
          frontendIPConfiguration: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/sslCertificates/wildcard.property.nhs.uk'
          }
          hostName: 'test-env-api.property.nhs.uk'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'apim-portal-listener02'
        properties: {
          frontendIPConfiguration: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/sslCertificates/wildcard.property.nhs.uk'
          }
          hostName: 'test-env-portal.property.nhs.uk'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'apim-developer-listener01'
        properties: {
          frontendIPConfiguration: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/sslCertificates/wildcard.property.nhs.uk'
          }
          hostName: 'test-env-developer.property.nhs.uk'
          hostNames: []
          requireServerNameIndication: true
        }
      }
      {
        name: 'apim-management-listener01'
        properties: {
          frontendIPConfiguration: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/frontendIPConfigurations/appGwPublicFrontendIp'
          }
          frontendPort: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/frontendPorts/port_443'
          }
          protocol: 'Https'
          sslCertificate: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/sslCertificates/wildcard.property.nhs.uk'
          }
          hostName: 'test-env-management.property.nhs.uk'
          hostNames: []
          requireServerNameIndication: true
        }
      }
    ]
    urlPathMaps: [
      {
        name: 'apim-gw-external-rule01'
        properties: {
          defaultBackendAddressPool: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/backendAddressPools/sinkpool'
          }
          defaultBackendHttpSettings: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/backendHttpSettingsCollection/apim-gw-poolsetting'
          }
          pathRules: [
            {
              name: 'external'
              properties: {
                paths: [
                  '/external/*'
                ]
                backendAddressPool: {
                  id: 'applicationGateways_appgw_customerportal_test_neu_001_name/backendAddressPools/apimbackend'
                }
                backendHttpSettings: {
                  id: 'applicationGateways_appgw_customerportal_test_neu_001_name/backendHttpSettingsCollection/apim-gw-poolsetting'
                }
              }
            }
          ]
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'apim-portal-rule01'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/httpListeners/apim-portal-listener02'
          }
          backendAddressPool: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/backendAddressPools/apimbackend'
          }
          backendHttpSettings: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/backendHttpSettingsCollection/apim-portal-poolsetting'
          }
        }
      }
      {
        name: 'apim-gw-external-rule01'
        properties: {
          ruleType: 'PathBasedRouting'
          httpListener: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/httpListeners/apim-gw-listener01'
          }
          urlPathMap: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/urlPathMaps/apim-gw-external-rule01'
          }
        }
      }
      {
        name: 'apim-developer-rule01'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/httpListeners/apim-developer-listener01'
          }
          backendAddressPool: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/backendAddressPools/apimbackend'
          }
          backendHttpSettings: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/backendHttpSettingsCollection/apim-developer-poolsetting'
          }
        }
      }
      {
        name: 'apim-management-rule01'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/httpListeners/apim-management-listener01'
          }
          backendAddressPool: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/backendAddressPools/apimbackend'
          }
          backendHttpSettings: {
            id: 'applicationGateways_appgw_customerportal_test_neu_001_name/backendHttpSettingsCollection/apim-management-poolsetting'
          }
        }
      }
    ]
    probes: [
      {
        name: 'apim-gw-proxyprobe'
        properties: {
          protocol: 'Https'
          host: 'test-env-api.property.nhs.uk'
          path: '/status-0123456789abcdef'
          interval: 30
          timeout: 120
          unhealthyThreshold: 8
          pickHostNameFromBackendHttpSettings: false
          minServers: 0
          match: {
            statusCodes: [
              '200-399'
            ]
          }
        }
      }
      {
        name: 'apim-portal-probe'
        properties: {
          protocol: 'Https'
          host: 'test-env-portal.property.nhs.uk'
          path: '/signin'
          interval: 60
          timeout: 300
          unhealthyThreshold: 8
          pickHostNameFromBackendHttpSettings: false
          minServers: 0
          match: {
            statusCodes: [
              '200-399'
            ]
          }
        }
      }
      {
        name: 'apim-developer-probe'
        properties: {
          protocol: 'Https'
          host: 'test-env-developer.property.nhs.uk'
          path: '/signin'
          interval: 60
          timeout: 300
          unhealthyThreshold: 8
          pickHostNameFromBackendHttpSettings: false
          minServers: 0
          match: {
            statusCodes: [
              '200-399'
            ]
          }
        }
      }
      {
        name: 'apim-management-probe'
        properties: {
          protocol: 'Https'
          host: 'test-env-management.property.nhs.uk'
          path: '/ServiceStatus'
          interval: 30
          timeout: 300
          unhealthyThreshold: 3
          pickHostNameFromBackendHttpSettings: false
          minServers: 0
          match: {
            statusCodes: [
              '200-399'
            ]
          }
        }
      }
    ]
    rewriteRuleSets: []
    redirectConfigurations: []
    privateLinkConfigurations: []
    webApplicationFirewallConfiguration: {
      enabled: true
      firewallMode: 'Detection'
      ruleSetType: 'OWASP'
      ruleSetVersion: '3.0'
      disabledRuleGroups: []
      exclusions: []
      requestBodyCheck: true
      maxRequestBodySizeInKb: 128
      fileUploadLimitInMb: 100
    }
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 2
    }
    customErrorConfigurations: []
  }
}
