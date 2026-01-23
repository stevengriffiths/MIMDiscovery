function Compare-FileHash {
  [CmdletBinding()]
  param (
    [parameter(Mandatory = $true)]
    [ValidateScript({Test-Path $_})]
    [string]
    $ReferenceFile,

    [parameter(Mandatory = $true)]
    [ValidateScript({Test-Path $_})]
    [string]
    $DifferenceFile
  )

  try {
    $ref = Import-Clixml -Path $ReferenceFile
    $dif = Import-Clixml -Path $DifferenceFile
    if ($ref -isnot [Hashtable] -or $dif -isnot [Hashtable]) {
      Write-Output 'Both -ReferenceFile and -DifferentFile must contain a serialized Hashtable.'
      return
    }

    $cmp = Compare-Object -ReferenceObject ($ref.Keys | Sort-Object) -DifferenceObject ($dif.Keys | Sort-Object) -IncludeEqual

    # Common files
    $cmp | Where-Object {$_.SideIndicator -eq '=='} | ForEach-Object {
      $key = $_.InputObject
      [pscustomobject]@{
        FullName = $key
        Hash = (@('Different','Match')[$ref[$key] -eq $dif[$key]])
      }
    }

    # New files
    $cmp | Where-Object {$_.SideIndicator -eq '=>'} | ForEach-Object {
      $key = $_.InputObject
      [pscustomobject]@{
        FullName = $key
        Hash = 'Added'
      }
    }

    # Removed files
    $cmp | Where-Object {$_.SideIndicator -eq '<='} | ForEach-Object {
      $key = $_.InputObject
      [pscustomobject]@{
        FullName = $key
        Hash = 'Removed'
      }
    }
  }
  catch {
    throw $_
  }
}