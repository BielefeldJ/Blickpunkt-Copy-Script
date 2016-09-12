$quellordner = "C:\Users\jensb\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$zielorder = "C:\Users\jensb\Pictures\Hintergrund"
if (-not (Test-Path $zielorder)) { md $zielorder }
$dateien = dir $quellordner
"Kopiere $($dateien.Count) Dateien..."
foreach($datei in $dateien)
{
$zieldatei = "$zielorder\$($datei.name).jpg"
Copy-Item $datei.FullName $zieldatei
$zieldatei
}
"$($dateien.Count) Bilder kopiert!"