---
external help file: PoshGram-help.xml
Module Name: PoshGram
online version: https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalAnimation
schema: 2.0.0
---

# Send-TelegramLocalAnimation

## SYNOPSIS
Sends Telegram animation message via Bot API from locally sourced animation

## SYNTAX

```
Send-TelegramLocalAnimation [-BotToken] <String> [-ChatID] <String> [-AnimationPath] <String>
 [[-Caption] <String>] [[-ParseMode] <String>] [-HasSpoiler] [-DisableNotification] [-ProtectContent]
 [<CommonParameters>]
```

## DESCRIPTION
Uses Telegram Bot API to send animation message to specified Telegram chat.
The animation will be sourced from the local device and uploaded to telegram.
Several options can be specified to adjust message parameters.

## EXAMPLES

### EXAMPLE 1
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$animation = 'C:\animation\animation.gif'
Send-TelegramLocalAnimation -BotToken $botToken -ChatID $chat -AnimationPath $animation
```

Sends AnimationPath message via Telegram API

### EXAMPLE 2
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$animation = 'C:\animation\animation.gif'
$sendTelegramLocalAnimationSplat = @{
    BotToken            = $botToken
    ChatID              = $chat
    AnimationPath       = $animation
    Caption             = 'Check out this animation'
    ParseMode           = 'MarkdownV2'
    HasSpoiler          = $true
    DisableNotification = $true
    ProtectContent      = $true
    Verbose             = $true
}
Send-TelegramLocalAnimation @sendTelegramLocalAnimationSplat
```

Sends animation message via Telegram API

### EXAMPLE 3
```
$botToken = 'nnnnnnnnn:xxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxx'
$chatID = '-nnnnnnnnn'
$animation = 'C:\animation\animation.gif'
$sendTelegramLocalAnimationSplat = @{
    BotToken      = $botToken
    ChatID        = $chat
    AnimationPath = $animation
    Caption       = 'Check out this __awesome__ animation\.'
    ParseMode     = 'MarkdownV2'
}
Send-TelegramLocalAnimation @sendTelegramLocalAnimationSplat
```

Sends animation message via Telegram API with properly formatted underlined word and escaped special character.

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

### -AnimationPath
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

### -HasSpoiler
Animation needs to be covered with a spoiler animation

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

The following animation types are supported:
GIF

Questions on how to set up a bot, get a token, or get your channel ID?
Answers on the PoshGram documentation: https://poshgram.readthedocs.io/en/latest/PoshGram-FAQ/

Get creative by sending Gifs with your bot!

## RELATED LINKS

[https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalAnimation](https://poshgram.readthedocs.io/en/latest/Send-TelegramLocalAnimation)

[https://core.telegram.org/bots/api#sendanimation](https://core.telegram.org/bots/api#sendanimation)

[https://core.telegram.org/bots/api#html-style](https://core.telegram.org/bots/api#html-style)

[https://core.telegram.org/bots/api#markdownv2-style](https://core.telegram.org/bots/api#markdownv2-style)

[https://core.telegram.org/bots/api#markdown-style](https://core.telegram.org/bots/api#markdown-style)

[https://core.telegram.org/bots/api](https://core.telegram.org/bots/api)

