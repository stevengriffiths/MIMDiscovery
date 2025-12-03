function Get-MprsAndSetsForWorkflowsWithScripts {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory=$false)]
    [string]
    $ScriptAttributeName = 'Script'
  )

  try {
    $slu = @{}
    Search-Resources -XPath "/Set" -AttributesToGet DisplayName,Filter,ObjectID | `
      ForEach-Object {$slu.Add($_.ObjectID, $_.DisplayName)}
    Get-WorkflowStepsAll | `
      Where-Object {$_.$ScriptAttributeName -ne $null} | `
      Select-Object WorkflowName, $ScriptAttributeName | `
      ForEach-Object {
        $wfName = $_.WorkflowName
        $script = $_.$ScriptAttributeName
        Search-Resources -XPath "/ManagementPolicyRule[ActionWorkflowDefinition=WorkflowDefinition[DisplayName=""$wfName""]/ObjectID]" -ExpectedObjectType ManagementPolicyRule | `
        Select-Object @{n='Workflow'; e={$wfName}},@{n='Script'; e={$script}},@{n='MPR'; e={$_.DisplayName}},Disabled,@{n='MPRType'; e={$_.ManagementPolicyRuleType}},@{n='TISet'; e={@([string]::Empty,$slu[$_.ResourceFinalSet])[$_.ActionType[0] -eq 'TransitionIn']}},@{n='TOSet'; e={@([string]::Empty,$slu[$_.ResourceCurrentSet])[$_.ActionType[0] -eq 'TransitionOut']}},@{n='ActionType'; e={$_.ActionType -join ','}},@{n='ActionParameter'; e={$_.ActionParameter -join ','}}
      }
  }
  catch {
    throw $_
  }
}