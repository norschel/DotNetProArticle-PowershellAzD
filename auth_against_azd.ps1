# Variante 1 - Cloud + On-Premise: (sichere) Anmeldung mit PATs und Umgebungsvariablen
$pat64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes
("PAT:$($env:Azure_DevOps_PAT)"))
$headers = @{
    'Authorization' = 'Basic ' + $pat64
}
Invoke-WebRequest -Uri $myApiUri -Method Get -Headers $headers -Body $myBody -ContentType "application/json-patch+json"

# Variante 2 - Cloud + On-Premise: (sichere) Anmeldung mit PATs und SecureStrings
$pat64 = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes
("PAT:$(ConvertFrom-SecureString $pat -AsPlainText)"))
$headers = @{
    'Authorization' = 'Basic ' + $pat64
}
Invoke-WebRequest -Uri $myApiUri -Method Get -Headers $headers -Body $myBody -ContentType "application/json-patch+json"

# Variante 3 – On-Premise: Aktuellen Nutzer zur Anmeldung verwenden
Invoke-WebRequest -Uri $myApiUri -Method Get -UseDefaultCredentials -Body $myBody -ContentType "application/json-patch+json"

# Variante 4 – On-Premise: Anmeldung mit definiertem Nutzer und Passwort
$myCredentialObject = get-credential
Invoke-WebRequest -Uri $myApiUri -Method Get -Credentials $myCredentialObject -Body $myBody -ContentType "application/json-patch+json"
