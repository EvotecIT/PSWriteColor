Import-Module .\PSWriteColor.psd1 -Force

Write-Color -Text "Select an ", 'option', ' to ', 'type', ' [quit]', ' to exit:' -Color White, Yellow, White, White, Green, White -NoNewLine
$inputInformation = Read-Host
$inputInformation