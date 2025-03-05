function GenerateInactiveDomainUserTable {
  param (
      [string]$server
  )
  
  $domains = (Get-ADUser -Filter "mail -notlike '*vml.com*' -and mail -notlike '*wundermanthompson.com*' -and mail -notlike '*wundermancommerce.com*'" -Server $server -Properties mail | ForEach-Object { if ($_.mail -match '@(.*)') { $Matches[1] } } | Sort-Object -Unique -CaseSensitive:$false)
  
  $allTables = @()
  
  $allTables += "<div class='domain-tables-container'>"
  
  foreach ($domain in $domains) {
      $tableRows = @()
      $tableRows += "<div class='table-wrapper'>"
      $tableRows += "<h3>Grupy użytkowników domeny: $domain</h3>"
      $tableRows += "<table border='1'>"
      $tableRows += "<tr><th>Nazwa Grupy</th></tr>"
  
      # Pobierz unikalne grupy dla domeny
      $domainGroups = (Get-ADUser -Filter "mail -like '*@$domain*'" -Server $server -Properties memberof | Select-Object -ExpandProperty memberof -Unique) -replace "CN=" -replace ",.*"
  
      foreach ($group in $domainGroups) {
          $tableRows += "<tr><td>$group</td></tr>"
      }
  
      $tableRows += "</table>"
      $tableRows += "</div>"
  
      $allTables += $tableRows -join ""
  }
  
  $allTables += "</div>"
  
  return $allTables -join ""
}
