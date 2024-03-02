$emailPath = "$home\desktop\Odcinek płacowy.eml"
$customObject = [PSCustomObject]@{
    SenderEmail = (gc $emailPath | sls "Sender: <") -replace ".+<" -replace ">"
    ReceiverEmail = ((gc $emailPath | sls "Delivered-To:") -replace ".+:").ToString().Trim()
    Date = ((gc $emailPath | sls "Date: ") -replace "Date:").ToString().Trim()
    ReceivedFromDate = ((gc $emailPath | sls "Received: from place") -replace ".+\[" -replace"\].+") | where {$_ -ne "127.0.0.1"}
    Subject = ((gc $emailPath | sls "Subject: ") -replace ".+:").ToString().Trim()
    Attachments = (gc $emailPath | sls "filename=") -replace ".+=" -replace '"'
}
Clear-Host
$customObject




