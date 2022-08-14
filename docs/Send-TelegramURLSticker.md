---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramURLSticker.md
schema: 2.0.0
---

# Send-TelegramURLSticker

## SYNOPSIS
Sends Telegram sticker message via Bot API from URL sourced sticker image

## SYNTAX

```
Send-TelegramURLSticker [-BotToken] <String> [-ChatID] <String> [-StickerURL] <String> [-DisableNotification]
 [-ProtectContent] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send sticker message to specified Telegram chat.
The sticker will be sourced from the provided URL and sent to Telegram.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$StickerURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.webp'
Send-TelegramURLSticker -BotToken $token -ChatID $channel -StickerURL $StickerURL
```

Sends sticker message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$StickerURL = 'https://github.com/techthoughts2/PoshGram/raw/main/test/SourceFiles/techthoughts.webp'
$sendTelegramURLStickerSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    StickerURL          = $StickerURL
    DisableNotification = $true
    ProtectContent      = $true
    Verbose             = $true
}
Send-TelegramURLSticker @sendTelegramURLStickerSplat
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

### -StickerURL
URL path to sticker

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

How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramURLSticker.md](https://github.com/techthoughts2/PoshGram/blob/main/docs/Send-TelegramURLSticker.md)

[https://core.telegram.org/bots/api#sendsticker](https://core.telegram.org/bots/api#sendsticker)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

