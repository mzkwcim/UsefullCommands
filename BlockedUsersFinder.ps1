# search for locked out accounts
Search-ADAccount -LockedOut | Select-Object SamAccountName

$username = "waldemar.krakowiak"
$server = "192.168.182.30"

$isBlockedNewAD = (get-aduser $username -server $server -Properties lockedout).lockedout
$isBlockedOldAD = (get-aduser $username -Properties lockedout).lockedout

if ($isBlockedNewAD -and $isBlockedOldAD){
    Write-host "User $($username) is lockedout in both AD"
} elseif ($isBlockedNewAD){
    Write-host "User $($username) is lockedout in the new AD"
} elseif ($isBlockedOldAD){
    Write-host "User $($username) is lockedout in the old AD"
} else {
    Write-host "User $($username) isn't blocked"
}
