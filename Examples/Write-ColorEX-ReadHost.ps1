Import-Module .\PSWriteColor.psd1 -Force

Write-ColorEX -Text "Enter the number of your choice: " -Color White -NoNewline -LinesBefore 1; $selected = Read-Host
Write-ColorEX -Text "Are you sure you want to select $selected"," (Y/","N","): " -Color White,DarkYellow,Green,DarkYellow -NoNewline; $confirmed = Read-Host