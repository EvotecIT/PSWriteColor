Import-Module .\PSWriteColor.psd1 -Force

Write-Color -Text "Enter the number of your choice: " -Color White -NoNewline -LinesBefore 1; $selected = Read-Host
Write-Color -Text "Are you sure you want to select $selected"," (Y/","N","): " -Color White,DarkYellow,Green,DarkYellow -NoNewline; $confirmed = Read-Host