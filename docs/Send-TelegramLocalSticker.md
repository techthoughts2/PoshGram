---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalSticker
schema: 2.0.0
---

# Send-TelegramLocalSticker

## SYNOPSIS
Sends Telegram sticker message via Bot API from locally sourced sticker image

## SYNTAX

```
Send-TelegramLocalSticker [-BotToken] <String> [-ChatID] <String> [-StickerPath] <String> [[-Emoji] <String>]
 [-DisableNotification] [-ProtectContent] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send sticker message to specified Telegram chat.
The sticker will be sourced from the local device and uploaded to telegram.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$sticker = 'C:\stickers\sticker.webp'
Send-TelegramLocalSticker -BotToken $botToken -ChatID $chatID -StickerPath $sticker
```

Sends sticker message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$sticker = 'C:\stickers\sticker.webp'
$sendTelegramLocalStickerSplat = @{
    BotToken            = $botToken
    ChatID              = $chatID
    StickerPath         = $sticker
    Emoji               = '😀'
    DisableNotification = $true
    ProtectContent      = $true
    Verbose             = $true
}
Send-TelegramLocalSticker @sendTelegramLocalStickerSplat
```

Sends sticker message via Telegram API

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

### -ChatID
Unique identifier for the target chat

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

### -StickerPath
File path to the sticker you wish to send

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Emoji
Emoji associated with the sticker

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableNotification
Send the message silently.
Users will receive a notification with no sound.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProtectContent
Protects the contents of the sent message from forwarding and saving

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

The following sticker types are supported:
WEBP, TGS, WEBM

Questions on how to set up a bot, get a token, or get your channel ID?
Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalSticker](https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalSticker)

[https://core.telegram.org/bots/api#sendsticker](https://core.telegram.org/bots/api#sendsticker)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

