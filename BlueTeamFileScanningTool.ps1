$filePath = Read-Host "Insert full path to the file"
while ((Test-Path $filePath) -eq $false){
    Write-Host "you have entered wrong path"
    $filePath = Read-Host "Insert full path to the file"
}
$sha256 = (Get-FileHash -A SHA256 $filePath).Hash
$apiKey = "xxx"
$queryUrl = "https://www.virustotal.com/vtapi/v2/file/report?apikey=$apiKey&resource=$sha256"
$response = Invoke-RestMethod -Uri $queryUrl -Method Get

$customObject = [PSCustomObject]@{
    AdditionalSignatureInfo = (Get-AuthenticodeSignature $filePath).SignerCertificate.RawData.Length
    Attributes = (gi $filePath).Attributes
    FileName = (gi $filePath).Name
    FileSize = (gi $filePath).Length
    IsOSBinary = (Get-AuthenticodeSignature $filePath).IsOSBinary
    LastAccessTimeUtc = (gi $filePath).LastAccessTimeUtc 
    LastWriteTimeUtc = (gi $filePath).LastWriteTimeUtc
    MimeType = (Get-Item $filePath).Extension
    Path = (Get-AuthenticodeSignature $filePath).Path 
    MD5 = (Get-FileHash -A MD5 $filePath).Hash
    RIPEMD160 = (Get-FileHash -Algorithm RIPEMD160 $filePath).Hash
    SHA1 = (Get-FileHash -A SHA1 $filePath).Hash
    SHA256 = $sha256
    ScanningResults = if ($response.response_code -eq 1) {"Wynik skanowania: $($response.positives) pozytywnych, $($response.total) wszystkich."} else {"Brak dostępu do wyników skanowania."}
    SignatureType = (Get-AuthenticodeSignature $filePath).SignatureType
    SignerCertificate = (Get-AuthenticodeSignature $filePath).SignerCertificate
    Status = (Get-AuthenticodeSignature $filePath).Status
    StatusMessage = (Get-AuthenticodeSignature $filePath).StatusMessage
    TimeStamperCertificate = (Get-AuthenticodeSignature $filePath).TimeStamperCertificate
}

$customObject

#scanning tool for enitre system
$apiKey = "xxx"
foreach($var in ((PSDrive | ? Root -like "*:\").Root | % {ls $_ -Recurse -File | select -exp fullname})){
    $sha256 = Get-FileHash $var -Algorithm SHA256
    $queryUrl = "https://www.virustotal.com/vtapi/v2/file/report?apikey=$apiKey&resource=$sha256"
    $response = Invoke-RestMethod -Uri $queryUrl -Method Get
    if ($response.response_code -eq 1) {"Wynik skanowania: $($response.positives) pozytywnych, $($response.total) wszystkich."} else {"Brak dostępu do wyników skanowania."}
}

