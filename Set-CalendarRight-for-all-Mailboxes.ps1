# Dieses Skript setzt f�r alle Mailboxen das Kalenderrecht
# Stannek GmbH - v.1.0 - 28.12.2022 E.Sauerbier

#Parameter
$AccessRight = "Editor" # Hier das gew�nschte Kalenderrecht angegeben
$CalendarUser = "Standard"

# Alle Mailboxen auslesen
$mailboxes = Get-Mailbox 

# Schleife zum setzen des Kalenderrechts
foreach ($mailbox in $mailboxes) { 
	# Kalender-Identity auslesen/erstellen
    $Calendar = (($mailbox.SamAccountName)+ ":\" + (Get-MailboxFolderStatistics -Identity $mailbox.SamAccountName -FolderScope Calendar | Select-Object -First 1).Name) 
 	# Hinweistext ausgeben
    Write-Host "Rechte f�r Kalender setzen bei $mailbox..." 
    # Kalenderrecht f�r aktuelle Mailbox in Schleife setzen
	Set-MailboxFolderPermission -User $CalendarUser -AccessRights $AccessRight -Identity $Calendar 
}