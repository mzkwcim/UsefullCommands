function Encode-Base64{
    process{
        [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($_))
    }
}
function Decode-Base64{
    process{
        [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($_))
    }
}
"who am i" | Encode-Base64
("who am i" | Encode-Base64) | Decode-Base64
