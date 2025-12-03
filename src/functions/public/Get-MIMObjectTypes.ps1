function Get-MIMObjectTypes {
  try {
    Connect-RMClient
    Search-Resources -XPath "/ObjectTypeDescription" -ExpectedObjectType ObjectTypeDescription | `
      Select-Object Name, DisplayName, ObjectID
  }
  catch {
    throw $_
  }
}