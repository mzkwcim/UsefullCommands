$lastWriteTime = Get-ChildItem $home\Desktop -File
Start-Sleep -Seconds 15
$newWriteTime = Get-ChildItem $home\Desktop -File

for ($i = 0; $i -lt $lastWriteTime.Count; $i++){
    $lastFullName = $lastWriteTime[$i].FullName
    $newFullName = $newWriteTime[$i].FullName

    if ($newFullName -notin $lastWriteTime.FullName){
        Copy-Item $newFullName -Destination "C:\Users\mzkwcim\Desktop\Nieprawda" -Force
        Write-Host "Przeniesiono $($newFullName) do C:\Users\mzkwcim\Desktop\Nieprawda"
    }

    if ($lastFullName -eq $newFullName -and $lastWriteTime[$i].LastWriteTimeUtc -ne $newWriteTime[$i].LastWriteTimeUtc){
        Copy-Item $newFullName -Destination "C:\Users\mzkwcim\Desktop\Nieprawda" -Force
        Write-Host "Przeniesiono $($newFullName) do C:\Users\mzkwcim\Desktop\Nieprawda"
    }
}
