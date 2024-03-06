$env:Path += ";C:\Program Files\PostgreSQL\16\bin"
$env:PGPASSWORD = 'xd'
$counter = 0
((psql -U postgres -h localhost -d WOZP -c "SELECT czas FROM rekordy_kobiet_11_letnich_lcm WHERE imie = 'ZawodniczkaX';") | % {($_ | sls "\d+.\d+").ToString().Trim()}) | % {if ($_ -lt 30) {$counter++}}
Remove-Item Env:\PGPASSWORD
$counter
