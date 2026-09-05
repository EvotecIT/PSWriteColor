Import-Module PSWriteColor

# Keep differently colored segments in a single fixed-width row.
Write-Color '1. ', 'Start backup' -Color Yellow, White -BackgroundColor Blue, Blue -PadRight 32 -LinesBefore 1
Write-Color '2. ', 'View logs' -Color Yellow, White -BackgroundColor Blue, Blue -PadRight 32
Write-Color '9. ', 'Exit' -Color Yellow, White -BackgroundColor Blue, Blue -PadRight 32 -LinesAfter 1

# Odd extra padding goes on the right. Longer text is never truncated.
Write-Color ' MENU ' -PadCenter 32 -PadCharacter '-' -Color Cyan
Write-Color 'Total: ', '42' -Color Gray, Green -PadLeft 32
