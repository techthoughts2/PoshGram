---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://poshgram.readthedocs.io/en/latest/Get-TelegramStickerPackInfo
schema: 2.0.0
---

# Get-TelegramStickerPackInfo

## SYNOPSIS
Retrieve detailed information about a specified Telegram sticker pack.

## SYNTAX

```
Get-TelegramStickerPackInfo [-BotToken] <String> [-StickerSetName] <String> [<CommonParameters>]
```

## DESCRIPTION
This function connects to the Telegram Bot API to fetch detailed information about a specified sticker pack.
It is designed to help you explore the contents of a Telegram sticker pack by providing a variety of information for each sticker.
This includes details like the associated emoji, its group and subgroup classifications, Unicode code, shortcode, and the sticker's file ID.
It also leverages the capabilities of pwshEmojiExplorer to retrieve additional emoji information, enriching the data set provided.
To effectively use this function, you need the name of the sticker pack.
You can find this by sharing the sticker pack within the Telegram app, which will generate a link containing the pack's name.
More information is available in the links.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
Get-TelegramStickerPackInfo -BotToken $botToken -StickerSetName STPicard
```

Retrieves information for the STPicard sticker pack from the Telegram Bot API.

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
Get-TelegramStickerPackInfo -BotToken $botToken -StickerSetName FriendlyFelines
```

Retrieves information for the FriendlyFelines sticker pack from the Telegram Bot API.

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

Note:
    - Some sticker authors use the same emoji for several of their stickers.
    - pwshEmojiExplorer is used to retrieve additional emoji information.

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Get-TelegramStickerPackInfo](https://poshgram.readthedocs.io/en/latest/Get-TelegramStickerPackInfo)

[https://poshgram.readthedocs.io/en/doctesting/PoshGram-Sticker-Info/](https://poshgram.readthedocs.io/en/doctesting/PoshGram-Sticker-Info/)

[https://core.telegram.org/bots/api#getstickerset](https://core.telegram.org/bots/api#getstickerset)

[https://core.telegram.org/bots/api#sticker](https://core.telegram.org/bots/api#sticker)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

