Add-Type -AssemblyName System.Windows.Forms

# Erstellt einen Dialog zum Öffnen eines Ordners, um das Quellverzeichnis auszuwählen
$sourceDialog = New-Object System.Windows.Forms.FolderBrowserDialog
$sourceDialog.Description = "Wählen Sie das Quellverzeichnis aus"
$sourceDialog.ShowNewFolderButton = $false

# Zeigt den Dialog zum Öffnen eines Ordners an und wartet auf Benutzereingabe
$sourceResult = $sourceDialog.ShowDialog()

# Überprüft, ob der Benutzer im Dialog auf "OK" geklickt hat
if ($sourceResult -eq [System.Windows.Forms.DialogResult]::OK) {
    $sourceDirectory = $sourceDialog.SelectedPath

    # Erstellt einen Dialog zum Speichern eines Ordners, um das Zielverzeichnis auszuwählen
    $destinationDialog = New-Object System.Windows.Forms.FolderBrowserDialog
    $destinationDialog.Description = "Wählen Sie das Zielverzeichnis aus"
    $destinationDialog.ShowNewFolderButton = $true

    # Zeigt den Dialog zum Speichern eines Ordners an und wartet auf Benutzereingabe
    $destinationResult = $destinationDialog.ShowDialog()

    # Überprüft, ob der Benutzer im Dialog auf "OK" geklickt hat
    if ($destinationResult -eq [System.Windows.Forms.DialogResult]::OK) {
        $destinationDirectory = $destinationDialog.SelectedPath

        # Pfad zur Logdatei
        $logFile = Join-Path -Path $destinationDirectory -ChildPath "RoboCopyLog.txt"

        # RoboCopy-Befehl mit den ausgewählten Quell- und Zielverzeichnissen
        $roboCopyCommand = "RoboCopy `"$sourceDirectory`" `"$destinationDirectory`" /MIR /R:3 /W:1 /TEE /LOG:`"$logFile`""

        # Führt den RoboCopy-Befehl aus
        Invoke-Expression -Command $roboCopyCommand
    }
    else {
        Write-Host "Auswahl des Zielverzeichnisses abgebrochen."
    }
}
else {
    Write-Host "Auswahl des Quellverzeichnisses abgebrochen."
}
