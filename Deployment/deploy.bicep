param primary_location string = 'centralus'
param environment string
param prefix string
param branch string
param version string

var tags = {
  'stack-name': prefix
  'stack-version': version
  'stack-environment': toLower(replace(environment, '_', ''))
  'stack-branch': branch
}

resource logicapp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: prefix
  tags: tags
  location: primary_location
  properties: {
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      'content-version': '1.0.0.0'
      'parameters': {
        '$connections': {
          type: 'Object'
        }
      }
      'triggers': {
        'manual': {
          'type': 'Request'
          'kind': 'Http'
        }
      }
    }
    parameters: {}
  }
}
