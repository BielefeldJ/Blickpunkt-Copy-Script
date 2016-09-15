$quellordner = "C:\Users\jensb\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$zielorder = "C:\Users\jensb\Pictures\Hintergrund"

function Add-ExtendedFileProperties
{
    param(
        [Parameter(Mandatory=$true,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
        $fileItem,
        [String[]] $PropertyExtended = "ALL"
    )
    begin
    {
        $shellObject = New-Object -Com Shell.Application
        $itemProperties = $null
    }
    process
    {
        if($fileItem.PsIsContainer)
        {
            $fileItem
            return
        }
        $directoryName = $fileItem.DirectoryName
        $filename = $fileItem.Name

        $folderObject = $shellObject.NameSpace($directoryName)
        $item = $folderObject.ParseName($filename)

        if(-not $itemProperties)
        {
            $itemProperties = @{}
            $counter = 0
            $columnName = ""
            if ($PropertyExtended -eq "ALL")
            {
                 #get all properties
                do {
                    $columnName = $folderObject.GetDetailsOf($folderObject.Items, $counter)
                    if($columnName) 
                    {
                        $itemProperties[$counter] = $columnName 
                    }
                    $counter++
                } while($columnName)
            }
            else
            {
                #get user defined properties
                do {
                    $columnName = $folderObject.GetDetailsOf($folderObject.Items, $counter)
                    foreach($name in $PropertyExtended)
                    {
                        if ($columnName.toLower() -eq $name.toLower())
                        {
                            $itemProperties[$counter] = $columnName
                        }
                    }
                    $counter++
                } while($columnName)
            }
        }

        foreach($itemProperty in $itemProperties.Keys)
        {
            $fileItem | Add-Member NoteProperty $itemProperties[$itemProperty] `
                $folderObject.GetDetailsOf($item, $itemProperty) -ErrorAction `
                SilentlyContinue
        }
        $fileItem
    }
}

if (-not (Test-Path "$zielorder")) { md "$zielorder" }
$dateien = dir "$quellordner"
"Kopiere $($dateien.Count) Dateien..."
foreach($datei in $dateien)
{
    $zieldatei = "$zielorder\$($datei.name).jpg"
    Copy-Item $datei.FullName $zieldatei
    $zieldatei   
}
"$($dateien.Count) Bilder kopiert!"
"Lösche falsche Bilder"
$abmessung = Get-ChildItem $zielorder | Add-ExtendedFileProperties -PropertyExtended "Abmessungen"
foreach($bild in $abmessung)
{
    $hb = $bild | select Abmessungen
    $path = $bild | select FullName
    $hb= "$hb"
    if($hb -ne "@{Abmessungen=‪1920 x 1080‬}")
    {   
        $path = "$path".Replace("@{FullName=","").Replace("}","")
        $path           
        Remove-Item $path      
    }
}


