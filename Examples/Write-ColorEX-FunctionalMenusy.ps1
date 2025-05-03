Import-Module .\PSWriteColor.psd1 -Force

# EXAMPLE
$line = '========================================================='

do {
    Clear-Host
    Write-ColorEX $line -LinesBefore 1
    Write-ColorEX 'ACTIVE DIRECTORY Domain Services Section' -C Green -StartTab 1
    Write-ColorEX $line
    Write-ColorEX ' 1', ' - ', 'List of Domain Controller and FSMO Roles' -C Yellow, White, Green
    Write-ColorEX ' 2', ' - ', 'Domain Main Configuration' -C Yellow, White, Green
    Write-ColorEX ' 3', ' - ', 'Forest Main Configuration' -C Yellow, White, Green
    Write-ColorEX ' 4', ' - ', 'List all Windows Clients' -C Yellow, White, Green
    Write-ColorEX ' 5', ' - ', 'List all Windows Server' -C Yellow, White, Green
    Write-ColorEX ' 6', ' - ', 'List all Computer (sort by operatingsystem)' -C Yellow, White, Green
    Write-ColorEX ' 7', ' - ', 'Run systeminfo on remote computers' -C Yellow, White, Green
    Write-ColorEX ' 8', ' - ', 'List Domain Admins' -C Yellow, White, Green
    Write-ColorEX ' 9', ' - ', 'Enabled Optional Features' -C Yellow, White, Green
    Write-ColorEX '10', ' - ', 'List of Active GPOs' -C Yellow, White, Green
    Write-ColorEX '11', ' - ', 'Default Password Policy Settings' -C Yellow, White, Green
    Write-ColorEX '12', ' - ', 'Active Directory Sites' -C Yellow, White, Green
    Write-ColorEX '13', ' - ', 'Users Last Logon' -C Yellow, White, Green
    Write-ColorEX '14', ' - ', 'List all Users (enabled)' -C Yellow, White, Green
    Write-ColorEX '15', ' - ', 'List User Details' -C Yellow, White, Green
    Write-ColorEX '16', ' - ', 'List all Groups' -C Yellow, White, Green
    Write-ColorEX '17', ' - ', 'List Group Memberships' -C Yellow, White, Green
    Write-ColorEX '18', ' - ', 'Send message to users Desktop' -C Yellow, White, Green
    Write-ColorEX '19', ' - ', 'Get Logged on User' -C Yellow, White, Green
    Write-ColorEX ' 0', ' - ', 'Quit' -C Yellow, White, Green -LinesAfter 1
    Write-ColorEX $line

    $inputData = Read-Host 'Select'

    Switch ($inputData) {
        0 { Continue }
        default {
            Write-ColorEX 'Not implemented...', ' Press any key to continue!' -Color Red, Yellow -LinesBefore 1
            [void][System.Console]::ReadKey($true)
        }
    }
} while ($inputData -ne '0')

# EXAMPLE
do {
    Write-ColorEX '1. ', 'View System Information   '-Color Yellow,Cyan -BackGroundColor Black -StartTab 2
    Write-ColorEX '2. ', 'Check Disk Space          ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2
    Write-ColorEX '3. ', 'Scan for Updates          ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2
    Write-ColorEX '4. ', 'Exit                      ' -Color Yellow,Cyan -BackGroundColor Black -StartTab 2

    Write-ColorEX -Text "Enter the number of your choice: " -Color White -NoNewline -LinesBefore 1; $selected = Read-Host

    Switch ($selected) {
        1 { Exit }
        2 { Exit }
        3 { Exit }
        4 { Exit }
        default {
            Write-ColorEX 'Not implemented...', ' Press any key to continue!' -Color Red, Yellow -LinesBefore 1
            [void][System.Console]::ReadKey($true)
        }
    }
} while ($selected -notin 1..4)
