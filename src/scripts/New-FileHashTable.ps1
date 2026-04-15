[CmdletBinding()]
param
(
  [parameter(Mandatory = $true)]
  [string]
  $RootPath,

  [parameter(Mandatory = $false)]
  [string]
  $RootReplace,

  [parameter(Mandatory = $false)]
  [string]
  $Filter = '*.*',

  [parameter(Mandatory = $false)]
  [switch]
  $Recurse
)

try {
  $ht = @{}
  $resolvedRoot = Resolve-Path -Path $RootPath
  $params = @{
    Path = $resolvedRoot
    Filter = $Filter
    Recurse = $Recurse
  }
  Get-ChildItem @params | ForEach-Object {
    if (Test-Path $_.FullName -PathType Leaf) {
      $key = $_.FullName
      if ($PSBoundParameters['RootReplace']) {
        $key = $_.FullName.Replace($resolvedRoot, $RootReplace)
      }
      $ht.Add($key, (Get-FileHash -Path $_.FullName -Algorithm SHA1).Hash)
    }
  }
  $ht
}
catch {
  throw $_
}