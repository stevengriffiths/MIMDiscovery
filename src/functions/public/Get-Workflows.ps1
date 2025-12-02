function Get-Workflows {
  try {
    Connect-RMClient
    $wfs = Search-Resources -XPath "/WorkflowDefinition" -ExpectedObjectType WorkflowDefinition
    $wfs
  }
  catch {
    throw $_
  }
}
