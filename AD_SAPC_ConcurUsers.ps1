$Group = "AD_SAPC_ConcurUsers"
$Server = "192.168.182.30"
$Days = 7

$DaysAgo = (Get-Date).AddDays(-$Days)

$SAMAccountNames = (Get-ADGroupMembers -Identity $Group -Server $Server).SamAccountName

foreach($SAMAccountName in $SAMAccountNames){
  try {
    $userObject = Get-ADUser -Identity $SAMAccountName -Server $Server -Properties Enabled, LastLogonTimeStamp
  
    if ($userObject.Enabled -eq $false -and $userObject.LastLogonTimeStamp -ne $null -and ([datetime]::FromFileTime($userObject.LastLogonTimeStamp) -le $DaysAgo)) {
      Remove-ADGroupMember -Identity $Group -Members $userObject -Server $Server -WhatIf # Usuń -WhatIf po testach
      Write-Host "User $($userObject.SAMAccountName) has been removed from group $($Group) (WhatIf)"
    } else {
      Write-Host "User $($userObject.SAMAccountName) does not meet the criteria for removal."
    }
  } catch {
    Write-Host "Error processing user $($SAMAccountName): $($_.Exception.Message)"
  }
}
