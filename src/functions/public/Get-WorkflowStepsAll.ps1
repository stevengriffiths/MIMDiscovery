function Get-WorkflowStepsAll {
  try {
    Get-Workflows | `
      Select-Object DisplayName, @{n='ObjectID'; e={$_.ObjectID.Value}} | `
      ForEach-Object {
        $n = $_.DisplayName
        Get-WorkflowSteps -ObjectID $_.ObjectID
      } | Select-Object @{n='WorkflowName'; e={$n}}, *
  }
  catch {
    throw $_
  }
}