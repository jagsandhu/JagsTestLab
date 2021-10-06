param privateDnsZones_property_nhs_uk_name string = 'property.nhs.uk'
param virtualNetworks_vnet_il_lt_neu_01_name string = 'vnet-il-lt-neu-01'
param networkSecurityGroups_nsg_db_subnet_name string = 'nsg-db-subnet'
param networkSecurityGroups_nsg_vm_subnet_name string = 'nsg-vm-subnet'
param networkSecurityGroups_nsg_apim_subnet_name string = 'nsg-apim-subnet'
param networkSecurityGroups_nsg_appgw_subnet_name string = 'nsg-appgw-subnet'
param networkSecurityGroups_nsg_webapp_subnet_name string = 'nsg-webapp-subnet'
param networkSecurityGroups_nsg_monitor_subnet_name string = 'nsg-monitor-subnet'
param networkSecurityGroups_nsg_storage_subnet_name string = 'nsg-storage-subnet'
param networkSecurityGroups_nsg_keyvault_subnet_name string = 'nsg-keyvault-subnet'
param networkSecurityGroups_nsg_integration_subnet_name string = 'nsg-integration-subnet'

resource networkSecurityGroups_nsg_apim_subnet_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_nsg_apim_subnet_name
  location: 'northeurope'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    securityRules: [
      {
        name: 'In-ClientCommunicationToAPIManagement-443'
        properties: {
          description: 'Client communication to API Management'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'In-ManagementEndpointForAzurePortalandPowerShell'
        properties: {
          description: 'Management endpoint for Azure portal and PowerShell'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3443'
          sourceAddressPrefix: 'ApiManagement'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-DependencyOnAzureStorage'
        properties: {
          description: 'Dependency on Azure Storage'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'Storage'
          access: 'Allow'
          priority: 100
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-AzureActiveDirectoryandAzureKeyVaultDependency'
        properties: {
          description: 'Azure Active Directory and Azure KeyVault dependency'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'AzureActiveDirectory'
          access: 'Allow'
          priority: 110
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-AccessToAzureSQLEndpoints'
        properties: {
          description: 'Access to Azure SQL endpoints'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '1443'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'SQL'
          access: 'Allow'
          priority: 120
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-AccessToAzureKeyVault'
        properties: {
          description: 'Access to Azure KeyVault'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'AzureKeyVault'
          access: 'Allow'
          priority: 130
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-DependencyForLogToEventHubPolicyandMonitoringAgent'
        properties: {
          description: 'Dependency for Log to Event Hub policy and monitoring agent'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'EventHub'
          access: 'Allow'
          priority: 140
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '5671'
            '5672'
            '443'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-DependencyOnAzureFileShareForGIT'
        properties: {
          description: 'Dependency on Azure File Share for GIT'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '445'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'Storage'
          access: 'Allow'
          priority: 150
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-HealthandMonitoringExtension'
        properties: {
          description: 'Health and Monitoring Extension'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'AzureCloud'
          access: 'Allow'
          priority: 160
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '443'
            '12000'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-PublishDiagnosticsLogsandMetricsResourceHealthandApplicationInsights'
        properties: {
          description: 'Publish Diagnostics Logs and Metrics, Resource Health and Application Insights'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'AzureMonitor'
          access: 'Allow'
          priority: 170
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '1886'
            '443'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-ConnectToSMTPRelayForSendingEmails'
        properties: {
          description: 'Connect to SMTP Relay for sending e-mails'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'Internet'
          access: 'Allow'
          priority: 180
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '25'
            '587'
            '25028'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-AccessRedisServiceForCachePoliciesBetweenMachines'
        properties: {
          description: 'Access Redis Service for Cache policies between machines'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 190
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '6381'
            '6382'
            '6383'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'In-AccessRedisServiceForCachePoliciesBetweenMachines'
        properties: {
          description: 'Access Redis Service for Cache policies between machines'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: [
            '6381'
            '6382'
            '6383'
          ]
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'Out-SyncCountersForRateLimitPoliciesBetweenMachines'
        properties: {
          description: 'Sync Counters for Rate Limit policies between machines'
          protocol: 'Udp'
          sourcePortRange: '*'
          destinationPortRange: '4290'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 200
          direction: 'Outbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'In-SyncCountersForRateLimitPoliciesBetweenMachines'
        properties: {
          description: 'Sync Counters for Rate Limit policies between machines'
          protocol: 'Udp'
          sourcePortRange: '*'
          destinationPortRange: '4290'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 130
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'In-AzureInfrastructureLoadBalancer'
        properties: {
          description: 'Azure Infrastructure Load Balancer'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'AzureLoadBalancer'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 140
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_nsg_appgw_subnet_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_nsg_appgw_subnet_name
  location: 'northeurope'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    securityRules: [
      {
        name: 'In-ApplicaitonGatewayRequirement'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '65503-65534'
          sourceAddressPrefix: 'GatewayManager'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 150
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'In-443'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
      {
        name: 'In-80'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 120
          direction: 'Inbound'
          sourcePortRanges: []
          destinationPortRanges: []
          sourceAddressPrefixes: []
          destinationAddressPrefixes: []
        }
      }
    ]
  }
}

resource networkSecurityGroups_nsg_db_subnet_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_nsg_db_subnet_name
  location: 'northeurope'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    securityRules: []
  }
}

resource networkSecurityGroups_nsg_integration_subnet_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_nsg_integration_subnet_name
  location: 'northeurope'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    securityRules: []
  }
}

resource networkSecurityGroups_nsg_keyvault_subnet_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_nsg_keyvault_subnet_name
  location: 'northeurope'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    securityRules: []
  }
}

resource networkSecurityGroups_nsg_monitor_subnet_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_nsg_monitor_subnet_name
  location: 'northeurope'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    securityRules: []
  }
}

resource networkSecurityGroups_nsg_storage_subnet_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_nsg_storage_subnet_name
  location: 'northeurope'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    securityRules: []
  }
}

resource networkSecurityGroups_nsg_vm_subnet_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_nsg_vm_subnet_name
  location: 'northeurope'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    securityRules: []
  }
}

resource networkSecurityGroups_nsg_webapp_subnet_name_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: networkSecurityGroups_nsg_webapp_subnet_name
  location: 'northeurope'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    securityRules: []
  }
}

resource privateDnsZones_property_nhs_uk_name_resource 'Microsoft.Network/privateDnsZones@2018-09-01' = {
  name: privateDnsZones_property_nhs_uk_name
  location: 'global'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    maxNumberOfRecordSets: 25000
    maxNumberOfVirtualNetworkLinks: 1000
    maxNumberOfVirtualNetworkLinksWithRegistration: 100
    numberOfRecordSets: 5
    numberOfVirtualNetworkLinks: 0
    numberOfVirtualNetworkLinksWithRegistration: 0
    provisioningState: 'Succeeded'
  }
}

resource networkSecurityGroups_nsg_appgw_subnet_name_In_443 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_appgw_subnet_name_resource
  name: 'In-443'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: 'Internet'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_appgw_subnet_name_In_80 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_appgw_subnet_name_resource
  name: 'In-80'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '80'
    sourceAddressPrefix: 'Internet'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Allow'
    priority: 120
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_In_AccessRedisServiceForCachePoliciesBetweenMachines 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'In-AccessRedisServiceForCachePoliciesBetweenMachines'
  properties: {
    description: 'Access Redis Service for Cache policies between machines'
    protocol: 'Tcp'
    sourcePortRange: '*'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Allow'
    priority: 120
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '6381'
      '6382'
      '6383'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_appgw_subnet_name_In_ApplicaitonGatewayRequirement 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_appgw_subnet_name_resource
  name: 'In-ApplicaitonGatewayRequirement'
  properties: {
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '65503-65534'
    sourceAddressPrefix: 'GatewayManager'
    destinationAddressPrefix: '*'
    access: 'Allow'
    priority: 150
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_In_AzureInfrastructureLoadBalancer 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'In-AzureInfrastructureLoadBalancer'
  properties: {
    description: 'Azure Infrastructure Load Balancer'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '*'
    sourceAddressPrefix: 'AzureLoadBalancer'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Allow'
    priority: 140
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_In_ClientCommunicationToAPIManagement_443 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'In-ClientCommunicationToAPIManagement-443'
  properties: {
    description: 'Client communication to API Management'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: 'Internet'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Allow'
    priority: 100
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_In_ManagementEndpointForAzurePortalandPowerShell 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'In-ManagementEndpointForAzurePortalandPowerShell'
  properties: {
    description: 'Management endpoint for Azure portal and PowerShell'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '3443'
    sourceAddressPrefix: 'ApiManagement'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Allow'
    priority: 110
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_In_SyncCountersForRateLimitPoliciesBetweenMachines 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'In-SyncCountersForRateLimitPoliciesBetweenMachines'
  properties: {
    description: 'Sync Counters for Rate Limit policies between machines'
    protocol: 'Udp'
    sourcePortRange: '*'
    destinationPortRange: '4290'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Allow'
    priority: 130
    direction: 'Inbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_AccessRedisServiceForCachePoliciesBetweenMachines 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-AccessRedisServiceForCachePoliciesBetweenMachines'
  properties: {
    description: 'Access Redis Service for Cache policies between machines'
    protocol: 'Tcp'
    sourcePortRange: '*'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Allow'
    priority: 190
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '6381'
      '6382'
      '6383'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_AccessToAzureKeyVault 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-AccessToAzureKeyVault'
  properties: {
    description: 'Access to Azure KeyVault'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'AzureKeyVault'
    access: 'Allow'
    priority: 130
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_AccessToAzureSQLEndpoints 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-AccessToAzureSQLEndpoints'
  properties: {
    description: 'Access to Azure SQL endpoints'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '1443'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'SQL'
    access: 'Allow'
    priority: 120
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_AzureActiveDirectoryandAzureKeyVaultDependency 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-AzureActiveDirectoryandAzureKeyVaultDependency'
  properties: {
    description: 'Azure Active Directory and Azure KeyVault dependency'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'AzureActiveDirectory'
    access: 'Allow'
    priority: 110
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_ConnectToSMTPRelayForSendingEmails 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-ConnectToSMTPRelayForSendingEmails'
  properties: {
    description: 'Connect to SMTP Relay for sending e-mails'
    protocol: 'Tcp'
    sourcePortRange: '*'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'Internet'
    access: 'Allow'
    priority: 180
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '25'
      '587'
      '25028'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_DependencyForLogToEventHubPolicyandMonitoringAgent 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-DependencyForLogToEventHubPolicyandMonitoringAgent'
  properties: {
    description: 'Dependency for Log to Event Hub policy and monitoring agent'
    protocol: 'Tcp'
    sourcePortRange: '*'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'EventHub'
    access: 'Allow'
    priority: 140
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '5671'
      '5672'
      '443'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_DependencyOnAzureFileShareForGIT 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-DependencyOnAzureFileShareForGIT'
  properties: {
    description: 'Dependency on Azure File Share for GIT'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '445'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'Storage'
    access: 'Allow'
    priority: 150
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_DependencyOnAzureStorage 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-DependencyOnAzureStorage'
  properties: {
    description: 'Dependency on Azure Storage'
    protocol: 'Tcp'
    sourcePortRange: '*'
    destinationPortRange: '443'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'Storage'
    access: 'Allow'
    priority: 100
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_HealthandMonitoringExtension 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-HealthandMonitoringExtension'
  properties: {
    description: 'Health and Monitoring Extension'
    protocol: 'Tcp'
    sourcePortRange: '*'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'AzureCloud'
    access: 'Allow'
    priority: 160
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '443'
      '12000'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_PublishDiagnosticsLogsandMetricsResourceHealthandApplicationInsights 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-PublishDiagnosticsLogsandMetricsResourceHealthandApplicationInsights'
  properties: {
    description: 'Publish Diagnostics Logs and Metrics, Resource Health and Application Insights'
    protocol: 'Tcp'
    sourcePortRange: '*'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'AzureMonitor'
    access: 'Allow'
    priority: 170
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: [
      '1886'
      '443'
    ]
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource networkSecurityGroups_nsg_apim_subnet_name_Out_SyncCountersForRateLimitPoliciesBetweenMachines 'Microsoft.Network/networkSecurityGroups/securityRules@2020-11-01' = {
  parent: networkSecurityGroups_nsg_apim_subnet_name_resource
  name: 'Out-SyncCountersForRateLimitPoliciesBetweenMachines'
  properties: {
    description: 'Sync Counters for Rate Limit policies between machines'
    protocol: 'Udp'
    sourcePortRange: '*'
    destinationPortRange: '4290'
    sourceAddressPrefix: 'VirtualNetwork'
    destinationAddressPrefix: 'VirtualNetwork'
    access: 'Allow'
    priority: 200
    direction: 'Outbound'
    sourcePortRanges: []
    destinationPortRanges: []
    sourceAddressPrefixes: []
    destinationAddressPrefixes: []
  }
}

resource privateDnsZones_property_nhs_uk_name_loadtest_env_api 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_property_nhs_uk_name_resource
  name: 'loadtest-env-api'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.0.12.69'
      }
    ]
  }
}

resource privateDnsZones_property_nhs_uk_name_loadtest_env_developer 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_property_nhs_uk_name_resource
  name: 'loadtest-env-developer'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.0.12.69'
      }
    ]
  }
}

resource privateDnsZones_property_nhs_uk_name_loadtest_env_management 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_property_nhs_uk_name_resource
  name: 'loadtest-env-management'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.0.12.69'
      }
    ]
  }
}

resource privateDnsZones_property_nhs_uk_name_loadtest_env_portal 'Microsoft.Network/privateDnsZones/A@2018-09-01' = {
  parent: privateDnsZones_property_nhs_uk_name_resource
  name: 'loadtest-env-portal'
  properties: {
    ttl: 3600
    aRecords: [
      {
        ipv4Address: '10.0.12.69'
      }
    ]
  }
}

resource Microsoft_Network_privateDnsZones_SOA_privateDnsZones_property_nhs_uk_name 'Microsoft.Network/privateDnsZones/SOA@2018-09-01' = {
  parent: privateDnsZones_property_nhs_uk_name_resource
  name: '@'
  properties: {
    ttl: 3600
    soaRecord: {
      email: 'azureprivatedns-host.microsoft.com'
      expireTime: 2419200
      host: 'azureprivatedns.net'
      minimumTtl: 10
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
  }
}

resource virtualNetworks_vnet_il_lt_neu_01_name_integration_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_il_lt_neu_01_name_resource
  name: 'integration-subnet'
  properties: {
    addressPrefix: '10.0.12.96/27'
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_il_lt_neu_01_name_apim_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_il_lt_neu_01_name_resource
  name: 'apim-subnet'
  properties: {
    addressPrefix: '10.0.12.64/27'
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_apim_subnet_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_il_lt_neu_01_name_appgw_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_il_lt_neu_01_name_resource
  name: 'appgw-subnet'
  properties: {
    addressPrefix: '10.0.12.0/27'
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_appgw_subnet_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_il_lt_neu_01_name_db_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_il_lt_neu_01_name_resource
  name: 'db-subnet'
  properties: {
    addressPrefix: '10.0.12.128/27'
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_db_subnet_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_il_lt_neu_01_name_keyvault_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_il_lt_neu_01_name_resource
  name: 'keyvault-subnet'
  properties: {
    addressPrefix: '10.0.13.64/27'
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_keyvault_subnet_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_il_lt_neu_01_name_monitor_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_il_lt_neu_01_name_resource
  name: 'monitor-subnet'
  properties: {
    addressPrefix: '10.0.13.32/27'
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_monitor_subnet_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_il_lt_neu_01_name_storage_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_il_lt_neu_01_name_resource
  name: 'storage-subnet'
  properties: {
    addressPrefix: '10.0.12.160/27'
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_storage_subnet_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_il_lt_neu_01_name_vm_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_il_lt_neu_01_name_resource
  name: 'vm-subnet'
  properties: {
    addressPrefix: '10.0.13.0/27'
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_vm_subnet_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_il_lt_neu_01_name_webapp_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_vnet_il_lt_neu_01_name_resource
  name: 'webapp-subnet'
  properties: {
    addressPrefix: '10.0.12.32/27'
    networkSecurityGroup: {
      id: networkSecurityGroups_nsg_webapp_subnet_name_resource.id
    }
    serviceEndpoints: []
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_vnet_il_lt_neu_01_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_vnet_il_lt_neu_01_name
  location: 'northeurope'
  tags: {
    Environment: 'Load Testing'
    Project: 'PRJT0040'
    Service: 'CustomerPortal'
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.12.0/23'
      ]
    }
    subnets: [
      {
        name: 'apim-subnet'
        properties: {
          addressPrefix: '10.0.12.64/27'
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_apim_subnet_name_resource.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'keyvault-subnet'
        properties: {
          addressPrefix: '10.0.13.64/27'
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_keyvault_subnet_name_resource.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'db-subnet'
        properties: {
          addressPrefix: '10.0.12.128/27'
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_db_subnet_name_resource.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'appgw-subnet'
        properties: {
          addressPrefix: '10.0.12.0/27'
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_appgw_subnet_name_resource.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'integration-subnet'
        properties: {
          addressPrefix: '10.0.12.96/27'
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'storage-subnet'
        properties: {
          addressPrefix: '10.0.12.160/27'
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_storage_subnet_name_resource.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'webapp-subnet'
        properties: {
          addressPrefix: '10.0.12.32/27'
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_webapp_subnet_name_resource.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'vm-subnet'
        properties: {
          addressPrefix: '10.0.13.0/27'
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_vm_subnet_name_resource.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'monitor-subnet'
        properties: {
          addressPrefix: '10.0.13.32/27'
          networkSecurityGroup: {
            id: networkSecurityGroups_nsg_monitor_subnet_name_resource.id
          }
          serviceEndpoints: []
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}
