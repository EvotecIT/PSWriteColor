
if ($PSEdition -eq 'Core') {
    Import-Module PSWriteColor -SkipEditionCheck -Force
} else {
    Import-Module PSWriteColor -Force
}

$line = '========================================================='

do {
    Clear-Host
    Write-Color $line -LinesBefore 1
    Write-Color 'ACTIVE DIRECTORY Domain Services Section' -C Green -StartTab 1
    Write-Color $line
    Write-Color ' 1', ' - ', 'List of Domain Controller and FSMO Roles' -C Yellow, White, Green
    Write-Color ' 2', ' - ', 'Domain Main Configuration' -C Yellow, White, Green
    Write-Color ' 3', ' - ', 'Forest Main Configuration' -C Yellow, White, Green
    Write-Color ' 4', ' - ', 'List all Windows Clients' -C Yellow, White, Green
    Write-Color ' 5', ' - ', 'List all Windows Server' -C Yellow, White, Green
    Write-Color ' 6', ' - ', 'List all Computer (sort by operatingsystem)' -C Yellow, White, Green
    Write-Color ' 7', ' - ', 'Run systeminfo on remote computers' -C Yellow, White, Green
    Write-Color ' 8', ' - ', 'List Domain Admins' -C Yellow, White, Green
    Write-Color ' 9', ' - ', 'Enabled Optional Features' -C Yellow, White, Green
    Write-Color '10', ' - ', 'List of Active GPOs' -C Yellow, White, Green
    Write-Color '11', ' - ', 'Default Password Policy Settings' -C Yellow, White, Green
    Write-Color '12', ' - ', 'Active Directory Sites' -C Yellow, White, Green
    Write-Color '13', ' - ', 'Users Last Logon' -C Yellow, White, Green
    Write-Color '14', ' - ', 'List all Users (enabled)' -C Yellow, White, Green
    Write-Color '15', ' - ', 'List User Details' -C Yellow, White, Green
    Write-Color '16', ' - ', 'List all Groups' -C Yellow, White, Green
    Write-Color '17', ' - ', 'List Group Memberships' -C Yellow, White, Green
    Write-Color '18', ' - ', 'Send message to users Desktop' -C Yellow, White, Green
    Write-Color '19', ' - ', 'Get Logged on User' -C Yellow, White, Green
    Write-Color ' 0', ' - ', 'Quit' -C Yellow, White, Green -LinesAfter 1
    Write-Color $line

    $input = Read-Host 'Select'

    Switch ($input) {
        0 { Exit }
        default {
            Write-Color 'Not implemented...', ' Press any key to continue!' -Color Red, Yellow -LinesBefore 1
            [void][System.Console]::ReadKey($true)
        }
    }
} while ($input -ne '0')