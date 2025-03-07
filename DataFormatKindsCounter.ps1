$ADServer = "10.90.1.5"
$Users = Get-ADUser -Filter * -server $ADServer -Properties samaccountname, extensionattribute9 | Where-Object {$_.extensionattribute9 -ne $null}

$DateFormatPatterns = @(
    @{ Name = "dd/MM/yyyy"; Regex = "^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/(19|20)\d\d$" },
    @{ Name = "MM/dd/yyyy"; Regex = "^(0[1-9]|1[012])/(0[1-9]|[12][0-9]|3[01])/(19|20)\d\d$" },
    @{ Name = "dd.MM.yyyy"; Regex = "^(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[012])\.(19|20)\d\d$" },
    @{ Name = "yyyy-MM-dd"; Regex = "^(19|20)\d\d-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$" },
    @{ Name = "yyyy/MM/dd"; Regex = "^(19|20)\d\d/(0[1-9]|1[012])/(0[1-9]|[12][0-9]|3[01])$" },
    @{ Name = "yyyy.MM.dd"; Regex = "^(19|20)\d\d\.(0[1-9]|1[012])\.(0[1-9]|[12][0-9]|3[01])$" },
    @{ Name = "dd-MMM-yyyy"; Regex = "^(0[1-9]|[12][0-9]|3[01])-(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)-(19|20)\d\d$" }
)
$DateFormatCounts = @{}  

foreach ($User in $Users) {
    $DateString = $User.extensionattribute9

    $MatchedFormat = $null

    foreach ($Pattern in $DateFormatPatterns) {
      if ($DateString -match $Pattern.Regex) {
        $MatchedFormat = $Pattern.Name
        break 
      }
    }

    if ($MatchedFormat) {
      if ($DateFormatCounts.ContainsKey($MatchedFormat)) {
        $DateFormatCounts[$MatchedFormat]++ 
      } else {
        $DateFormatCounts[$MatchedFormat] = 1 
      }
    } else {
      Write-Warning "Nie można rozpoznać formatu daty dla użytkownika $($User.SamAccountName): '$DateString'"
    }
}

    Write-Host "Statystyki formatów dat:"
    $DateFormatCounts.GetEnumerator() | Sort-Object Value -Descending | ForEach-Object {
    Write-Host "$($_.Name): $($_.Value)"
}
