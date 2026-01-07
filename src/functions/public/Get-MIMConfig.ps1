# Initially required to run locally
function Get-MIMConfig {
  [CmdletBinding()]
  param()
  
  if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host -ForegroundColor Red 'This command must be run as an administrator'
    return
  }
  try {
    if (Assert-SyncServer) {Get-MIMSyncConfig}
    if (Assert-ServiceServer) {Get-MIMServiceConfig}
    if (Assert-PortalServer) {Get-MIMPortalConfig}
  }
  catch {
    throw $_
  }
}