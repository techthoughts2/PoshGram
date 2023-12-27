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
You will need the name of the sticker pack you want to retrieve information for.
To find the name of a sticker pack use the telegram app to share the sticker pack.
This will provide a link which contains the sticker pack name.
More information is available in the links.

## EXAMPLES

### EXAMPLE 1
```
Get-TelegramStickerPackInfo -BotToken $token -StickerSetName STPicard
```

Retrieves information for the STPicard sticker pack from the Telegram Bot API.

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

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Get-TelegramStickerPackInfo](https://poshgram.readthedocs.io/en/latest/Get-TelegramStickerPackInfo)

[https://poshgram.readthedocs.io/en/doctesting/PoshGram-Sticker-Info/](https://poshgram.readthedocs.io/en/doctesting/PoshGram-Sticker-Info/)

[https://core.telegram.org/bots/api#getstickerset](https://core.telegram.org/bots/api#getstickerset)

[https://core.telegram.org/bots/api#sticker](https://core.telegram.org/bots/api#sticker)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

