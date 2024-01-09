---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://poshgram.readthedocs.io/en/latest/Get-TelegramCustomEmojiStickerInfo
schema: 2.0.0
---

# Get-TelegramCustomEmojiStickerInfo

## SYNOPSIS
Retrieve information about Telegram custom emoji stickers using their identifiers.

## SYNTAX

```
Get-TelegramCustomEmojiStickerInfo [-BotToken] <String> [-CustomEmojiIdentifier] <String[]>
 [<CommonParameters>]
```

## DESCRIPTION
This function interacts with the Telegram Bot API to gather detailed information about custom emoji stickers
specified by their unique identifiers.
It can handle requests for up to 200 custom emoji IDs at a time

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
Get-TelegramCustomEmojiStickerInfo -BotToken $botToken -CustomEmojiIdentifier 5404870433939922908
```

Retrieves detailed information about the custom emoji sticker with identifier 5404870433939922908.

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
Get-TelegramCustomEmojiStickerInfo -BotToken $botToken -CustomEmojiIdentifier 5404870433939922908, 5368324170671202286
```

Fetches information for multiple custom emoji stickers, using their respective identifiers 5404870433939922908 and 5368324170671202286.

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

### -CustomEmojiIdentifier
Custom emoji ID number(s).
Specify up to 200 custom emoji IDs.

```yaml
Type: String[]
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
    - This function is currently experimental.
Bots can only access custom emoji sticker information for purchased additional usernames on Fragment.
        - This makes it difficult to determine the custom emoji ID for a custom emoji sticker pack.
    - pwshEmojiExplorer is used to retrieve additional emoji information.

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Get-TelegramCustomEmojiStickerInfo](https://poshgram.readthedocs.io/en/latest/Get-TelegramCustomEmojiStickerInfo)

[https://poshgram.readthedocs.io/en/doctesting/PoshGram-Sticker-Info/](https://poshgram.readthedocs.io/en/doctesting/PoshGram-Sticker-Info/)

[https://core.telegram.org/bots/api#getcustomemojistickers](https://core.telegram.org/bots/api#getcustomemojistickers)

[https://core.telegram.org/bots/api#sticker](https://core.telegram.org/bots/api#sticker)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

