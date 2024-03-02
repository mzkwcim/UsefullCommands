Function Get-Hello{
  Param(
    [Parameter(Position=0)]
    [ValidatePattern("^[A-Z]", Options=0)]
    [Parameter(Mandatory=$True, ValueFromPipelin=$True,Position=1)]
    [Alias("hihi")]
  )
  Write-Output "$Grettings, $Name"
}
