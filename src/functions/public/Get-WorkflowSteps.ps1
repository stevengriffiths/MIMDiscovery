function Get-WorkflowSteps {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory=$true)]
    [string]
    $ObjectID,

    [parameter(Mandatory=$false)]
    [string[]]
    $Attributes = @('Name','LocalName','Description','ControlTitle','Script','Destination','FunctionExpression','FunctionText')
  )

  try {
    $w = Get-Resource -ID $ObjectID
    [xml]$xoml = $w.XOML
    $nsm = New-Object System.Xml.XmlNamespaceManager($xoml.NameTable)
    switch ($w.RequestPhase) {
      'Action' {
        $xoml.SequentialWorkflow.psobject.Properties.Where({$_.Name -match 'ns[0-9]'}).ForEach({$nsm.AddNamespace($_.Name, $_.Value)})
        $xoml.SelectNodes("//ns0:SequentialWorkflow/*", $nsm) | Select-Object -Property $Attributes
        break
      }
      'Authentication' {
        $xoml.AuthenticationWorkflow.psobject.Properties.Where({$_.Name -match 'ns[0-9]'}).ForEach({$nsm.AddNamespace($_.Name, $_.Value)})
        $xoml.SelectNodes("//ns0:AuthenticationWorkflow/*", $nsm) | Select-Object -Property $Attributes
        break
      }
      'Authorization' {
        $xoml.SequentialWorkflow.psobject.Properties.Where({$_.Name -match 'ns[0-9]'}).ForEach({$nsm.AddNamespace($_.Name, $_.Value)})
        $xoml.SelectNodes("//ns0:SequentialWorkflow/*", $nsm) | Select-Object -Property $Attributes
        break
      }
      default {
        throw ('Unknown RequestPhase: {0}' -f $w.RequestPhase)
      }
    }
  }
  catch {
    throw $_
  }
}