# Blickpunkt-Copy-Script
Ein Script um die Bilder vom Microsoft-Blickpunkt zu kopieren. (Sperrbildschirm Bilder)

`$quellordner` und `§zielornder` anpassen.

Um die ausführung von Powershell scripts zu erlauben folgenden Befehl ausführen. (In der Powershell)
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```


Via Aufgabenplanung bei jedem Anmelden ausführen.

### Aufgabenplanung mit Powershell:

Bei “Aktion:” wird “Programm starten” ausgewählt. Im Textfeld “Programm/Skript:” wird der Pfad zur “PowerShell.Exe” eingetragen.

```
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe
```

Hier darf nicht der Pfad des Skripts stehen! Auch bei Verwendung der PowerShell 2.0 lautet der Pfad wie oben angegeben.

Der Pfad zum eigentlichen Skript wird unter dem Punkt “Argumente hinzufügen (optional):” eingetragen. Der Pfad wird als command-Parameter übergeben:

```
-command "C:\Scripts\Pfad_zum_Skript.ps1"
```
