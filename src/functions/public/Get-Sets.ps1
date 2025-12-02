function Get-Sets {
  try {
    Connect-RMClient
    $sets = Search-Resources -XPath "/Set" -ExpectedObjectType Set
    $sets
  }
  catch {
    throw $_
  }
}
