---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalPhoto.md
schema: 2.0.0
---

# Send-TelegramLocalPhoto

## SYNOPSIS
Sends Telegram photo message via Bot API from locally sourced photo image

## SYNTAX

```
Send-TelegramLocalPhoto [-BotToken] <String> [-ChatID] <String> [-PhotoPath] <String> [[-Caption] <String>]
 [[-ParseMode] <String>] [-DisableNotification] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send photo message to specified Telegram chat.
The photo will be sourced from the local device and uploaded to telegram.
Several options can be specified to adjust message parameters.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$photo = 'C:\photos\aphoto.jpg'
Send-TelegramLocalPhoto -BotToken $botToken -ChatID $chat -PhotoPath $photo
```

Sends photo message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$photo = 'C:\photos\aphoto.jpg'
$sendTelegramLocalPhotoSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    PhotoPath           = $photo
    Caption             = 'Check out this photo'
    ParseMode           = 'MarkdownV2'
    DisableNotification = $true
    Verbose             = $true
}
Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat
```

Sends photo message via Telegram API

### EXAMPLE 3
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$photo = 'C:\photos\aphoto.jpg'
$sendTelegramLocalPhotoSplat = @{
    BotToken  = $botToken
    ChatID    = $chat
    PhotoPath = $photo
    Caption   = 'Check out this __awesome__ photo\.'
    ParseMode = 'MarkdownV2'
}
Send-TelegramLocalPhoto @sendTelegramLocalPhotoSplat
```

Sends photo message via Telegram API with properly formatted underlined word and escaped special character.

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

### -PhotoPath
File path to local image

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

### -Caption
Brief title or explanation for media

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

### -ParseMode
Send Markdown or HTML, if you want Telegram apps to show bold, italic, fixed-width text or inline URLs in your bot's message.
Default is HTML.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: HTML
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Management.Automation.PSCustomObject
### System.Boolean (on failure)
## NOTES
Author: Jake Morrison - @jakemorrison - https://www.techthoughts.info/
This works with PowerShell Version: 6.1+

The following photo types are supported:
JPG, JPEG, PNG, GIF, BMP, WEBP, SVG, TIFF

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalPhoto.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramLocalPhoto.md)

[https://core.telegram.org/bots/api#sendphoto](https://core.telegram.org/bots/api#sendphoto)

[https://core.telegram.org/bots/api#html-style](https://core.telegram.org/bots/api#html-style)

[https://core.telegram.org/bots/api#markdownv2-style](https://core.telegram.org/bots/api#markdownv2-style)

[https://core.telegram.org/bots/api#markdown-style](https://core.telegram.org/bots/api#markdown-style)

