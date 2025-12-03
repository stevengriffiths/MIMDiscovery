function Get-MIMBindings {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $false)]
    [string]
    $ObjectType = 'Person'
  )

  try {
    Connect-RMClient
    Search-Resources -XPath "/BindingDescription[BoundObjectType=ObjectTypeDescription[Name='$ObjectType']]/BoundAttributeType" -ExpectedObjectType AttributeTypeDescription | `
      Select-Object DisplayName, Name, DataType
  }
  catch {
    throw $_
  }
}