
Send-MailMessage -To "przykład@strona.com" -Subject "TestOneLinera" -Body "Zobaczymy czy zadziała" -SmtpServer "authmail.mn-man.biz" -Attachments "C:\ewentualny\zalaczniki" -Credential (New-Object System.Management.Automation.PSCredential("mailUzytkownika@strona.com", (ConvertTo-SecureString "haslo" -AsPlainText -Force))) -From "mailwysylajacy@strona.com"
