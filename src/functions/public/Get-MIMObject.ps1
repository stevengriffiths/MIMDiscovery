function Get-MIMObject {
  [CmdletBinding()]
  param
  (
    [parameter(Mandatory = $true)]
    [string]
    $ObjectID,

    [parameter(Mandatory = $false)]
    [string]
    $ObjectType = 'Person',

    [parameter(Mandatory = $false)]
    [switch]
    $All = $false

  )

  try {
    Connect-RMClient
    try {
      [System.Guid]::Parse($ObjectID) | Out-Null
      $filter = "/$ObjectType[ObjectID='$ID']"
    }
    catch {
      $filter = "/$ObjectType[starts-with(DisplayName,'$ObjectID')]"
    }
    finally {
      if ($All) {
        Search-Resources -XPath $filter -ExpectedObjectType $ObjectType
      }
      else {
        (Search-Resources -XPath $filter -ExpectedObjectType $ObjectType).psobject.Properties | `
          ForEach-Object {
          if ($_.Value -ne $null) {
            [pscustomobject]@{Name = $_.Name; Value = $_.Value}
          }
          elseif ($_.Values -ne $null) {
            [pscustomobject]@{Name = $_.Name; Value = $_.Values}
          }
        }
      }
    }
  }
  catch {
    throw $_
  }
}