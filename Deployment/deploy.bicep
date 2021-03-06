param primary_location string = 'centralus'
param environment string
param prefix string
param branch string
param version string

var stackEnvironment = toLower(replace(environment, '_', ''))
var stackName = '${prefix}${stackEnvironment}'
var tags = {
  'stack-name': prefix
  'stack-version': version
  'stack-environment': stackEnvironment
  'stack-branch': branch
}

resource logicapp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: stackName
  tags: tags
  location: primary_location
  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      'contentVersion': '1.0.0.0'
      'parameters': {
        '$connections': {
          defaultValue: {}
          type: 'Object'
        }
      }
      'triggers': {
        'http_request': {
          type: 'Request'
          kind: 'Http'
        }
      }
    }
    parameters: {
      '$connections': {
        type: 'Object'
      }
    }
  }
}
