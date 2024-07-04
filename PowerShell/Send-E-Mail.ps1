##########################################
## https://github.com/Wxrlds/AdminTools ##
##########################################

# Requires:
# https://github.com/EvotecIT/Mailozaurr

$From = "your@mail.com"
$To = "$From"
$MailTextHTML = @"
E-Mail text here
"@
$Attachment = Get-ChildItem "C:\Users\Username\Downloads\test.txt"
$MailCredentials = Get-Credential -UserName $From
Send-EmailMessage -To $To -Subject "SMTP Auth Test" -Body $MailTextHTML -SmtpServer 'smtp.office365.com' -From $From -Encoding UTF8 -Credential $MailCredentials -UseSsl -Port 587 -Verbose
Send-EmailMessage -To $To -Subject 'SMTP Auth Test' -Body $MailTextHTML -SmtpServer 'smtp.office365.com' -From $From -Encoding UTF8 -Credential $MailCredentials -UseSsl -Port 587 -Verbose -Attachment $Attachment
