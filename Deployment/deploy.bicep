param primary_location string = 'centralus'
param environment string
param prefix string
param branch string

var tags = {
  'stack-name': prefix
  'stack-version': '0'
  'stack-environment': toLower(replace(environment, '_', ''))
  'stack-branch': branch
}

resource logicapp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: prefix
  tags: tags
  location: primary_location
}
