$env:Path += ";C:\Program Files\PostgreSQL\16\bin"
$env:PGPASSWORD = 'xd'
$xd = psql -U postgres -h localhost -d WOZP -c "SELECT czas FROM rekordy_kobiet_11_letnich_lcm WHERE imie = 'ZawodniczkaX';"
Remove-Item Env:\PGPASSWORD
$makarena = $xd | % {($_ | sls "\d+.\d+" -ea si).ToString().Trim()}
$makarena[0]
