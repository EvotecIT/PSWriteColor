---
title: "Add readable status output to scripts"
description: "Use PSWriteColor to make status messages, menus, and success feedback easier to scan."
layout: docs
---

This example is a good first stop if you want to replace plain `Write-Host` output with something operators can scan quickly.

It comes from the source example at `Examples/Write-Color-Examples.ps1`.

## When to use this pattern

- You want progress and status messages to stand out in the console.
- Your scripts present simple operator choices.
- You need readable output without building a full TUI experience.

## Example

```powershell
Import-Module PSWriteColor

Write-Color "[i] ", "Sending email...." -Color White, White -NoNewLine
if ($true) {
    Write-Color -Text "OK" -Color Green
}

Write-Color "1. ", "Option 1" -Color Yellow, Green
Write-Color "2. ", "Option 2" -Color Yellow, Green
Write-Color "9. ", "Press 9 to exit" -Color Yellow, Gray -LinesBefore 1
```

## What this demonstrates

- mixing plain labels with highlighted status text
- showing success feedback inline
- building lightweight operator menus without a complex UI layer

## Source

- [Write-Color-Examples.ps1](https://github.com/EvotecIT/PSWriteColor/blob/master/Examples/Write-Color-Examples.ps1)
