#Demonstrating all ANSI 4 standard console color families with Standard and Light variants. Dark variants are not supported and will be mapped to the standard colors automatically.
Write-ColorEX -Text 'Red Family:', ' Dark Red', ' Red', ' Light Red' -Color White,DarkRed,Red,LightRed -ANSI4
Write-ColorEX -Text 'Red Family:', ' ', 'Dark Red', ' ', 'Red', ' ', 'Light Red' -Color White,None,DarkRed,None,Red,None,LightRed -BackGroundColor None,None,DarkRed,None,Red,None,LightRed -ANSI4

Write-ColorEX -Text 'Green Family:', ' Dark Green', ' Green', ' Light Green' -Color White,DarkGreen,Green,LightGreen -ANSI4
Write-ColorEX -Text 'Green Family:', ' ', 'Dark Green', ' ', 'Green', ' ', 'Light Green' -Color White,None,DarkGreen,None,Green,None,LightGreen -BackGroundColor None,None,DarkGreen,None,Green,None,LightGreen -ANSI4

Write-ColorEX -Text 'Blue Family:', ' Dark Blue', ' Blue', ' Light Blue' -Color White,DarkBlue,Blue,LightBlue -ANSI4
Write-ColorEX -Text 'Blue Family:', ' ', 'Dark Blue', ' ', 'Blue', ' ', 'Light Blue' -Color White,None,DarkBlue,None,Blue,None,LightBlue -BackGroundColor None,None,DarkBlue,None,Blue,None,LightBlue -ANSI4

Write-ColorEX -Text 'Yellow Family:', ' Dark Yellow', ' Yellow', ' Light Yellow' -Color White,DarkYellow,Yellow,LightYellow -ANSI4
Write-ColorEX -Text 'Yellow Family:', ' ', 'Dark Yellow', ' ', 'Yellow', ' ', 'Light Yellow' -Color White,None,DarkYellow,None,Yellow,None,LightYellow -BackGroundColor None,None,DarkYellow,None,Yellow,None,LightYellow -ANSI4

Write-ColorEX -Text 'Magenta Family:', ' Dark Magenta', ' Magenta', ' Light Magenta' -Color White,DarkMagenta,Magenta,LightMagenta -ANSI4
Write-ColorEX -Text 'Magenta Family:', ' ', 'Dark Magenta', ' ', 'Magenta', ' ', 'Light Magenta' -Color White,None,DarkMagenta,None,Magenta,None,LightMagenta -BackGroundColor None,None,DarkMagenta,None,Magenta,None,LightMagenta -ANSI4

Write-ColorEX -Text 'Cyan Family:', ' Dark Cyan', ' Cyan', ' Light Cyan' -Color White,DarkCyan,Cyan,LightCyan -ANSI8
Write-ColorEX -Text 'Cyan Family:', ' ', 'Dark Cyan', ' ', 'Cyan', ' ', 'Light Cyan' -Color White,None,DarkCyan,None,Cyan,None,LightCyan -BackGroundColor None,None,DarkCyan,None,Cyan,None,LightCyan -ANSI8

# Demonstrating all ANSI 8 color families with Dark, standard, and Light variants
# ANSI 8 Standard Console Color Families
Write-ColorEX -Text 'Red Family:', ' Dark Red', ' Red', ' Light Red' -Color White,DarkRed,Red,LightRed -ANSI8
Write-ColorEX -Text 'Red Family:', ' ', 'Dark Red', ' ', 'Red', ' ', 'Light Red' -Color White,None,DarkRed,None,Red,None,LightRed -BackGroundColor None,None,DarkRed,None,Red,None,LightRed -ANSI8

Write-ColorEX -Text 'Green Family:', ' Dark Green', ' Green', ' Light Green' -Color White,DarkGreen,Green,LightGreen -ANSI8
Write-ColorEX -Text 'Green Family:', ' ', 'Dark Green', ' ', 'Green', ' ', 'Light Green' -Color White,None,DarkGreen,None,Green,None,LightGreen -BackGroundColor None,None,DarkGreen,None,Green,None,LightGreen -ANSI8

Write-ColorEX -Text 'Blue Family:', ' Dark Blue', ' Blue', ' Light Blue' -Color White,DarkBlue,Blue,LightBlue -ANSI8
Write-ColorEX -Text 'Blue Family:', ' ', 'Dark Blue', ' ', 'Blue', ' ', 'Light Blue' -Color White,None,DarkBlue,None,Blue,None,LightBlue -BackGroundColor None,None,DarkBlue,None,Blue,None,LightBlue -ANSI8

Write-ColorEX -Text 'Yellow Family:', ' Dark Yellow', ' Yellow', ' Light Yellow' -Color White,DarkYellow,Yellow,LightYellow -ANSI8
Write-ColorEX -Text 'Yellow Family:', ' ', 'Dark Yellow', ' ', 'Yellow', ' ', 'Light Yellow' -Color White,None,DarkYellow,None,Yellow,None,LightYellow -BackGroundColor None,None,DarkYellow,None,Yellow,None,LightYellow -ANSI8

Write-ColorEX -Text 'Magenta Family:', ' Dark Magenta', ' Magenta', ' Light Magenta' -Color White,DarkMagenta,Magenta,LightMagenta -ANSI8
Write-ColorEX -Text 'Magenta Family:', ' ', 'Dark Magenta', ' ', 'Magenta', ' ', 'Light Magenta' -Color White,None,DarkMagenta,None,Magenta,None,LightMagenta -BackGroundColor None,None,DarkMagenta,None,Magenta,None,LightMagenta -ANSI8

Write-ColorEX -Text 'Cyan Family:', ' Dark Cyan', ' Cyan', ' Light Cyan' -Color White,DarkCyan,Cyan,LightCyan -ANSI8
Write-ColorEX -Text 'Cyan Family:', ' ', 'Dark Cyan', ' ', 'Cyan', ' ', 'Light Cyan' -Color White,None,DarkCyan,None,Cyan,None,LightCyan -BackGroundColor None,None,DarkCyan,None,Cyan,None,LightCyan -ANSI8

# ANSI 8 Extended Color Families
Write-ColorEX -Text 'Orange Family:', ' Dark Orange', ' Orange', ' Light Orange' -Color White,DarkOrange,Orange,LightOrange -ANSI8
Write-ColorEX -Text 'Orange Family:', ' ', 'Dark Orange', ' ', 'Orange', ' ', 'Light Orange' -Color White,None,DarkOrange,None,Orange,None,LightOrange -BackGroundColor None,None,DarkOrange,None,Orange,None,LightOrange -ANSI8

Write-ColorEX -Text 'Purple Family:', ' Dark Purple', ' Purple', ' Light Purple' -Color White,DarkPurple,Purple,LightPurple -ANSI8
Write-ColorEX -Text 'Purple Family:', ' ', 'Dark Purple', ' ', 'Purple', ' ', 'Light Purple' -Color White,None,DarkPurple,None,Purple,None,LightPurple -BackGroundColor None,None,DarkPurple,None,Purple,None,LightPurple -ANSI8

Write-ColorEX -Text 'Pink Family:', ' Dark Pink', ' Pink', ' Light Pink' -Color White,DarkPink,Pink,LightPink -ANSI8
Write-ColorEX -Text 'Pink Family:', ' ', 'Dark Pink', ' ', 'Pink', ' ', 'Light Pink' -Color White,None,DarkPink,None,Pink,None,LightPink -BackGroundColor None,None,DarkPink,None,Pink,None,LightPink -ANSI8

Write-ColorEX -Text 'Brown Family:', ' Dark Brown', ' Brown', ' Light Brown' -Color White,DarkBrown,Brown,LightBrown -ANSI8
Write-ColorEX -Text 'Brown Family:', ' ', 'Dark Brown', ' ', 'Brown', ' ', 'Light Brown' -Color White,None,DarkBrown,None,Brown,None,LightBrown -BackGroundColor None,None,DarkBrown,None,Brown,None,LightBrown -ANSI8

Write-ColorEX -Text 'Teal Family:', ' Dark Teal', ' Teal', ' Light Teal' -Color White,DarkTeal,Teal,LightTeal -ANSI8
Write-ColorEX -Text 'Teal Family:', ' ', 'Dark Teal', ' ', 'Teal', ' ', 'Light Teal' -Color White,None,DarkTeal,None,Teal,None,LightTeal -BackGroundColor None,None,DarkTeal,None,Teal,None,LightTeal -ANSI8

Write-ColorEX -Text 'Violet Family:', ' Dark Violet', ' Violet', ' Light Violet' -Color White,DarkViolet,Violet,LightViolet -ANSI8
Write-ColorEX -Text 'Violet Family:', ' ', 'Dark Violet', ' ', 'Violet', ' ', 'Light Violet' -Color White,None,DarkViolet,None,Violet,None,LightViolet -BackGroundColor None,None,DarkViolet,None,Violet,None,LightViolet -ANSI8

Write-ColorEX -Text 'Lime Family:', ' Dark Lime', ' Lime', ' Light Lime' -Color White,DarkLime,Lime,LightLime -ANSI8
Write-ColorEX -Text 'Lime Family:', ' ', 'Dark Lime', ' ', 'Lime', ' ', 'Light Lime' -Color White,None,DarkLime,None,Lime,None,LightLime -BackGroundColor None,None,DarkLime,None,Lime,None,LightLime -ANSI8

Write-ColorEX -Text 'Slate Family:', ' Dark Slate', ' Slate', ' Light Slate' -Color White,DarkSlate,Slate,LightSlate -ANSI8
Write-ColorEX -Text 'Slate Family:', ' ', 'Dark Slate', ' ', 'Slate', ' ', 'Light Slate' -Color White,None,DarkSlate,None,Slate,None,LightSlate -BackGroundColor None,None,DarkSlate,None,Slate,None,LightSlate -ANSI8

Write-ColorEX -Text 'Gold Family:', ' Dark Gold', ' Gold', ' Light Gold' -Color White,DarkGold,Gold,LightGold -ANSI8
Write-ColorEX -Text 'Gold Family:', ' ', 'Dark Gold', ' ', 'Gold', ' ', 'Light Gold' -Color White,None,DarkGold,None,Gold,None,LightGold -BackGroundColor None,None,DarkGold,None,Gold,None,LightGold -ANSI8

Write-ColorEX -Text 'Sky Family:', ' Dark Sky', ' Sky', ' Light Sky' -Color White,DarkSky,Sky,LightSky -ANSI8
Write-ColorEX -Text 'Sky Family:', ' ', 'Dark Sky', ' ', 'Sky', ' ', 'Light Sky' -Color White,None,DarkSky,None,Sky,None,LightSky -BackGroundColor None,None,DarkSky,None,Sky,None,LightSky -ANSI8

Write-ColorEX -Text 'Coral Family:', ' Dark Coral', ' Coral', ' Light Coral' -Color White,DarkCoral,Coral,LightCoral -ANSI8
Write-ColorEX -Text 'Coral Family:', ' ', 'Dark Coral', ' ', 'Coral', ' ', 'Light Coral' -Color White,None,DarkCoral,None,Coral,None,LightCoral -BackGroundColor None,None,DarkCoral,None,Coral,None,LightCoral -ANSI8

Write-ColorEX -Text 'Olive Family:', ' Dark Olive', ' Olive', ' Light Olive' -Color White,DarkOlive,Olive,LightOlive -ANSI8
Write-ColorEX -Text 'Olive Family:', ' ', 'Dark Olive', ' ', 'Olive', ' ', 'Light Olive' -Color White,None,DarkOlive,None,Olive,None,LightOlive -BackGroundColor None,None,DarkOlive,None,Olive,None,LightOlive -ANSI8

Write-ColorEX -Text 'Lavender Family:', ' Dark Lavender', ' Lavender', ' Light Lavender' -Color White,DarkLavender,Lavender,LightLavender -ANSI8
Write-ColorEX -Text 'Lavender Family:', ' ', 'Dark Lavender', ' ', 'Lavender', ' ', 'Light Lavender' -Color White,None,DarkLavender,None,Lavender,None,LightLavender -BackGroundColor None,None,DarkLavender,None,Lavender,None,LightLavender -ANSI8

Write-ColorEX -Text 'Mint Family:', ' Dark Mint', ' Mint', ' Light Mint' -Color White,DarkMint,Mint,LightMint -ANSI8
Write-ColorEX -Text 'Mint Family:', ' ', 'Dark Mint', ' ', 'Mint', ' ', 'Light Mint' -Color White,None,DarkMint,None,Mint,None,LightMint -BackGroundColor None,None,DarkMint,None,Mint,None,LightMint -ANSI8

Write-ColorEX -Text 'Salmon Family:', ' Dark Salmon', ' Salmon', ' Light Salmon' -Color White,DarkSalmon,Salmon,LightSalmon -ANSI8
Write-ColorEX -Text 'Salmon Family:', ' ', 'Dark Salmon', ' ', 'Salmon', ' ', 'Light Salmon' -Color White,None,DarkSalmon,None,Salmon,None,LightSalmon -BackGroundColor None,None,DarkSalmon,None,Salmon,None,LightSalmon -ANSI8

Write-ColorEX -Text 'Indigo Family:', ' Dark Indigo', ' Indigo', ' Light Indigo' -Color White,DarkIndigo,Indigo,LightIndigo -ANSI8
Write-ColorEX -Text 'Indigo Family:', ' ', 'Dark Indigo', ' ', 'Indigo', ' ', 'Light Indigo' -Color White,None,DarkIndigo,None,Indigo,None,LightIndigo -BackGroundColor None,None,DarkIndigo,None,Indigo,None,LightIndigo -ANSI8

Write-ColorEX -Text 'Turquoise Family:', ' Dark Turquoise', ' Turquoise', ' Light Turquoise' -Color White,DarkTurquoise,Turquoise,LightTurquoise -ANSI8
Write-ColorEX -Text 'Turquoise Family:', ' ', 'Dark Turquoise', ' ', 'Turquoise', ' ', 'Light Turquoise' -Color White,None,DarkTurquoise,None,Turquoise,None,LightTurquoise -BackGroundColor None,None,DarkTurquoise,None,Turquoise,None,LightTurquoise -ANSI8

Write-ColorEX -Text 'Ruby Family:', ' Dark Ruby', ' Ruby', ' Light Ruby' -Color White,DarkRuby,Ruby,LightRuby -ANSI8
Write-ColorEX -Text 'Ruby Family:', ' ', 'Dark Ruby', ' ', 'Ruby', ' ', 'Light Ruby' -Color White,None,DarkRuby,None,Ruby,None,LightRuby -BackGroundColor None,None,DarkRuby,None,Ruby,None,LightRuby -ANSI8

Write-ColorEX -Text 'Jade Family:', ' Dark Jade', ' Jade', ' Light Jade' -Color White,DarkJade,Jade,LightJade -ANSI8
Write-ColorEX -Text 'Jade Family:', ' ', 'Dark Jade', ' ', 'Jade', ' ', 'Light Jade' -Color White,None,DarkJade,None,Jade,None,LightJade -BackGroundColor None,None,DarkJade,None,Jade,None,LightJade -ANSI8

Write-ColorEX -Text 'Amber Family:', ' Dark Amber', ' Amber', ' Light Amber' -Color White,DarkAmber,Amber,LightAmber -ANSI8
Write-ColorEX -Text 'Amber Family:', ' ', 'Dark Amber', ' ', 'Amber', ' ', 'Light Amber' -Color White,None,DarkAmber,None,Amber,None,LightAmber -BackGroundColor None,None,DarkAmber,None,Amber,None,LightAmber -ANSI8

Write-ColorEX -Text 'Steel Family:', ' Dark Steel', ' Steel', ' Light Steel' -Color White,DarkSteel,Steel,LightSteel -ANSI8
Write-ColorEX -Text 'Steel Family:', ' ', 'Dark Steel', ' ', 'Steel', ' ', 'Light Steel' -Color White,None,DarkSteel,None,Steel,None,LightSteel -BackGroundColor None,None,DarkSteel,None,Steel,None,LightSteel -ANSI8

Write-ColorEX -Text 'Crimson Family:', ' Dark Crimson', ' Crimson', ' Light Crimson' -Color White,DarkCrimson,Crimson,LightCrimson -ANSI8
Write-ColorEX -Text 'Crimson Family:', ' ', 'Dark Crimson', ' ', 'Crimson', ' ', 'Light Crimson' -Color White,None,DarkCrimson,None,Crimson,None,LightCrimson -BackGroundColor None,None,DarkCrimson,None,Crimson,None,LightCrimson -ANSI8

Write-ColorEX -Text 'Emerald Family:', ' Dark Emerald', ' Emerald', ' Light Emerald' -Color White,DarkEmerald,Emerald,LightEmerald -ANSI8
Write-ColorEX -Text 'Emerald Family:', ' ', 'Dark Emerald', ' ', 'Emerald', ' ', 'Light Emerald' -Color White,None,DarkEmerald,None,Emerald,None,LightEmerald -BackGroundColor None,None,DarkEmerald,None,Emerald,None,LightEmerald -ANSI8

Write-ColorEX -Text 'Sapphire Family:', ' Dark Sapphire', ' Sapphire', ' Light Sapphire' -Color White,DarkSapphire,Sapphire,LightSapphire -ANSI8
Write-ColorEX -Text 'Sapphire Family:', ' ', 'Dark Sapphire', ' ', 'Sapphire', ' ', 'Light Sapphire' -Color White,None,DarkSapphire,None,Sapphire,None,LightSapphire -BackGroundColor None,None,DarkSapphire,None,Sapphire,None,LightSapphire -ANSI8

Write-ColorEX -Text 'Wine Family:', ' Dark Wine', ' Wine', ' Light Wine' -Color White,DarkWine,Wine,LightWine -ANSI8
Write-ColorEX -Text 'Wine Family:', ' ', 'Dark Wine', ' ', 'Wine', ' ', 'Light Wine' -Color White,None,DarkWine,None,Wine,None,LightWine -BackGroundColor None,None,DarkWine,None,Wine,None,LightWine -ANSI8

Write-ColorEX -Text 'Gray Family:', ' Black', ' Light Black', ' Dark Gray', ' Gray', ' Light Gray', ' White'  -Color White,Black,LightBlack,DarkGray,Gray,LightGray,White -ANSI8
Write-ColorEX -Text 'Gray Family:', ' ', 'Black', ' ', 'Light Black', ' ', 'Dark Gray', ' ', 'Gray', ' ', 'Light Gray', ' ', 'White'  -Color White,None,Black,None,LightBlack,None,DarkGray,None,Gray,None,LightGray,None,White -BackGroundColor None,None,Black,None,LightBlack,None,DarkGray,None,Gray,None,LightGray,None,White -ANSI8