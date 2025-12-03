function Get-WorkflowsMprsAndSetsAll {
  try {
    $slu = @{}
    Search-Resources -XPath "/Set" -AttributesToGet DisplayName,Filter,ObjectID | `
      ForEach-Object {$slu.Add($_.ObjectID, $_.DisplayName)}
    $w = Search-Resources -XPath "/WorkflowDefinition" -ExpectedObjectType WorkflowDefinition

    $w | ForEach-Object {
      $wfName = $_.DisplayName
      Search-Resources -XPath "/ManagementPolicyRule[ActionWorkflowDefinition=WorkflowDefinition[DisplayName=""$($_.DisplayName)""]/ObjectID]" -ExpectedObjectType ManagementPolicyRule
    } | `
    Select-Object @{n='Workflow'; e={$wfName}},@{n='MPR'; e={$_.DisplayName}},Disabled,@{n='MPRType'; e={$_.ManagementPolicyRuleType}},@{n='TISet'; e={@([string]::Empty,$slu[$_.ResourceFinalSet])[$_.ActionType[0] -eq 'TransitionIn']}},@{n='TOSet'; e={@([string]::Empty,$slu[$_.ResourceCurrentSet])[$_.ActionType[0] -eq 'TransitionOut']}},@{n='ActionType'; e={$_.ActionType -join ','}},@{n='ActionParameter'; e={$_.ActionParameter -join ','}}
  }
  catch {
    throw $_
  }
}