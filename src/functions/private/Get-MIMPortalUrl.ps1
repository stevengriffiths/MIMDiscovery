function Get-MIMPortalUrl {
  try {
    [PSCustomObject]@{
      Host     = $env:COMPUTERNAME
      Role     = 'Portal'
      Property = 'URL'
      Value    = Get-ItemPropertyValue -Path 'HKLM:\SOFTWARE\Microsoft\Forefront Identity Manager\2010\Portal' -Name BaseSiteCollectionURL -ErrorAction Stop
    }
  }
  catch {
    return
  }
}