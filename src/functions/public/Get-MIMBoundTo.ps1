function Get-MIMBoundTo {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $false)]
    [string]
    $AttributeType = 'DisplayName'
  )

  try {
    Connect-RMClient
    Search-Resources -XPath "/BindingDescription[BoundAttributeType=AttributeTypeDescription[Name='$AttributeType']]/BoundObjectType" -ExpectedObjectType ObjectTypeDescription | `
      Select-Object DisplayName, Name
  }
  catch {
    throw $_
  }
}