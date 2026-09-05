---
title: "Build a readable console menu"
description: "Use PSWriteColor to make a simple operator menu easier to scan in the terminal."
layout: docs
---

This example is useful when a script still belongs in the console, but the operator needs clearer menu choices than plain text can provide.

It comes from the source example at `Examples/Write-Color-ExamplesFunctionalMenu.ps1`.

## When to use this pattern

- You have a small operator-driven script with numbered actions.
- You want important labels and choices to stand out.
- You do not need a full graphical or terminal UI framework.

## Example

```powershell
Import-Module .\PSWriteColor.psd1 -Force

$line = '========================================================='

Write-Color $line -LinesBefore 1
Write-Color 'ACTIVE DIRECTORY Domain Services Section' -Color Green -StartTab 1
Write-Color $line
Write-Color ' 1', ' - ', 'List domain controllers and FSMO roles' -Color Yellow, White, Green
Write-Color ' 2', ' - ', 'Show domain configuration' -Color Yellow, White, Green
Write-Color ' 0', ' - ', 'Quit' -Color Yellow, White, Green -LinesAfter 1
Write-Color $line

$choice = Read-Host 'Select'
```

## What this demonstrates

- using color to separate numbers, separators, and action labels
- keeping simple scripts readable without adding a larger UI dependency
- making operator choices easier to scan under pressure

## Source

- [Write-Color-ExamplesFunctionalMenu.ps1](https://github.com/EvotecIT/PSWriteColor/blob/master/Examples/Write-Color-ExamplesFunctionalMenu.ps1)
