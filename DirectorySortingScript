$DirectoryPath = 'C:\Users\mzkwcim\Desktop\New folder'
(gci -File $DirectoryPath | % { $_.Extension -replace '\.' } | Select -Unique) | % {$folderName = "$DirectoryPath\$_ Files"; ni -I Directory -F -Pa $folderName}
gci -File $DirectoryPath | % { $extension = $_.Extension -replace '\.';$destinationFolder = Join-Path $DirectoryPath "$extension Files"; mv $_.FullName $destinationFolder -Fo}
