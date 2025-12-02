function Get-MPRs {
  try {
    Connect-RMClient
    $mprs = Search-Resources -XPath "/ManagementPolicyRule" -ExpectedObjectType ManagementPolicyRule
    $mprs
  }
  catch {
    throw $_
  }
}
