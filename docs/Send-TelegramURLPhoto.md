---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLPhoto.md
schema: 2.0.0
---

# Send-TelegramURLPhoto

## SYNOPSIS
Sends Telegram photo message via Bot API from URL sourced photo image

## SYNTAX

```
Send-TelegramURLPhoto [-BotToken] <String> [-ChatID] <String> [-PhotoURL] <String> [[-Caption] <String>]
 [[-ParseMode] <String>] [-DisableNotification] [-ProtectContent] [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send photo message to specified Telegram chat.
The photo will be sourced from the provided URL and sent to Telegram.
Several options can be specified to adjust message parameters.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$photoURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.png'
Send-TelegramURLPhoto -BotToken $botToken -ChatID $chat -PhotoURL $photourl
```

Sends photo message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$photoURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.png'
$sendTelegramURLPhotoSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    PhotoURL            = $photourl
    Caption             = 'DSC is a great technology'
    ParseMode           = 'MarkdownV2'
    DisableNotification = $true
    ProtectContent      = $true
    Verbose             = $true
}
Send-TelegramURLPhoto @sendTelegramURLPhotoSplat
```

Sends photo message via Telegram API

### EXAMPLE 3
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chat = '-nnnnnnnnn'
$photoURL = 'https://github.com/techthoughts2/PoshGram/raw/master/test/SourceFiles/techthoughts.png'
$sendTelegramURLPhotoSplat = @{
    BotToken  = $botToken
    ChatID    = $chat
    PhotoURL  = $photourl
    Caption   = "DSC is a __great__ technology\."
    ParseMode = 'MarkdownV2'
}
Send-TelegramURLPhoto @sendTelegramURLPhotoSplat
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

### -PhotoURL
URL path to photo

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

How do I get my channel ID?
Use the getidsbot https://telegram.me/getidsbot  -or-  Use the Telegram web client and copy the channel ID in the address
How do I set up a bot and get a token?
Use the BotFather https://t.me/BotFather

## RELATED LINKS

[https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLPhoto.md](https://github.com/techthoughts2/PoshGram/blob/master/docs/Send-TelegramURLPhoto.md)

[https://core.telegram.org/bots/api#sendphoto](https://core.telegram.org/bots/api#sendphoto)

[https://core.telegram.org/bots/api#html-style](https://core.telegram.org/bots/api#html-style)

[https://core.telegram.org/bots/api#markdownv2-style](https://core.telegram.org/bots/api#markdownv2-style)

[https://core.telegram.org/bots/api#markdown-style](https://core.telegram.org/bots/api#markdown-style)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

