function Get-InactiveADUsers {
  param(
      [int]$Days = 90,
      [string]$ReportPath = ".\InactiveUsersReport.html"
  )
  
  try {
      $users = Get-ADUser -Filter * -Properties LastLogonDate, DisplayName, mail, Enabled, MemberOf | Where-Object {
          $_.Enabled -eq $false -or ($_.LastLogonDate -le (Get-Date).AddDays(-$Days))
      } | Sort-Object LastLogonDate -Ascending | Select-Object SamAccountName, DisplayName, mail, LastLogonDate, Enabled, MemberOf
  
      $report = $users | ConvertTo-Html -Property SamAccountName, DisplayName, mail, LastLogonDate, Enabled, MemberOf -PreContent "<h1>Raport nieaktywnych użytkowników ($Days dni)</h1>" -PostContent "<p>Liczba nieaktywnych użytkowników: $($users.Count)</p>"
  
      $report | Out-File -FilePath $ReportPath -Encoding UTF8
  
      Write-Host "Raport wygenerowany pomyślnie: $ReportPath"
  
      return $users
  
  } catch {
      Write-Error "Wystąpił błąd: $($_.Exception.Message)"
  }
}

Get-InactiveADUsers -Days 60 -ReportPath ".\InactiveUsers_60days.html"
