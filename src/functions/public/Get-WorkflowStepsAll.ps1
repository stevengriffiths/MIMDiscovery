function Get-WorkflowStepsAll {
  try {
    Get-Workflows | `
      Select-Object DisplayName, @{n='ObjectID'; e={$_.ObjectID.Value}} | `
      ForEach-Object {
        $n = $_.DisplayName
        $i = $_.ObjectID
        Get-WorkflowSteps -ObjectID $_.ObjectID
      } | Select-Object @{n='WorkflowName'; e={$n}}, @{n='WorkflowID'; e={$i}}, *
  }
  catch {
    throw $_
  }
}