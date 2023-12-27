---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://poshgram.readthedocs.io/en/latest/Get-TelegramStickerPackInfo
schema: 2.0.0
---

# Get-TelegramStickerPackInfo

## SYNOPSIS
Get information for specified Telegram sticker pack.

## SYNTAX

```
Get-TelegramStickerPackInfo [-BotToken] <String> [-StickerSetName] <String> [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to retrieve Telegram sticker pack information.
Displays emoji,emoji code, emoji shortcode, bytes, and file_id, and file information for each sticker in the sticker pack.

## EXAMPLES

### EXAMPLE 1
```
Get-TelegramStickerPackInfo -BotToken $token -StickerSetName STPicard
```

Sends contact via Telegram API

## PARAMETERS

### -BotToken
Use this token to access the HTTP API

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -StickerSetName
Name of the sticker set

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/

Questions on how to set up a bot, get a token, or get your channel ID?
Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

Some sticker authors use the same emoji for several of their stickers.

width       : 512
height      : 512
emoji       : 🙂
set_name    : STPicard
is_animated : False
thumb       : @{file_id=AAQCAAMMAAPdcBMXl0FGgL2-fdo_kOMNAAQBAAdtAAPeLQACFgQ; file_size=3810; width=128; height=128}
file_id     : CAADAgADDAAD3XATF5dBRoC9vn3aFgQ
file_size   : 18356
Bytes       : {61, 216, 66, 222}
Code        : U+1F642
Shortcode   : :slightly_smiling_face:

To find the name of a sticker pack use the telegram app to share the sticker pack.
This will provide a link which contains the sticker pack name.

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Get-TelegramStickerPackInfo](https://poshgram.readthedocs.io/en/latest/Get-TelegramStickerPackInfo)

[https://core.telegram.org/bots/api#getstickerset](https://core.telegram.org/bots/api#getstickerset)

[https://core.telegram.org/bots/api#sticker](https://core.telegram.org/bots/api#sticker)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

